class BrowserController < ApplicationController

  before_filter :signed_in_user

  def browser
    respond_to do |format|
      format.html { render layout: 'browser' }
    end
  end

  def all

    sts = SampleType.includes(:samples).all

    result = {}

    sts.each { |st|
      result[st.name] = st.samples.collect { |s|
        "#{s.id}: #{s.name}"
      }
    }

    render json: result

  end

  def recent_samples
    if params[:id]
      user = User.find_by_id(params[:id])
    end    
    if !user
      render json: Sample
          .last(25)      
          .reverse
          .to_json(only: [:name,:id,:user_id,:data,:sample_type_id])
    else
      render json: Sample
          .where(user_id: user.id)
          .last(25)
          .reverse
          .to_json(only: [:name,:id,:user_id,:data,:sample_type_id])
    end
  end

  def projects 
    if params[:uid]
      user = User.find_by_id(params[:uid])
    end
    if !user
      render json: {
        projects: Sample.uniq.pluck(:project)
                 .sort
                 .collect { |p| { name: p, selected: false, sample_type_ids: Sample.where( project: p).pluck(:sample_type_id).uniq } }
      }
    else
      render json: {
        projects: Sample.where(user_id: user.id)
                    .uniq
                    .pluck(:project)
                    .sort
                    .collect { |p| { name: p, selected: false, sample_type_ids: Sample.where( project: p).pluck(:sample_type_id).uniq  } }
      }
    end
  end

  def samples_for_tree
    render json: Sample
        .where(project: params[:project], sample_type_id: params[:sample_type_id].to_i)
        .reverse
        .to_json(only: [:name,:id,:user_id,:data])
  end

  def gory_details_of_samples_for_tree
    render json: Sample
        .includes(field_values: :child_sample, sample_type: { field_types: { allowable_field_types: :sample_type } })
        .where(project: params[:project], sample_type_id: params[:sample_type_id].to_i)
        .reverse
        .to_json(include: { 
            field_values: { include: :child_sample },
          }, except: [ :field1, :field2, :field3, :field4, :field5, :field6, :field7, :field8 ]        
        )        
  end

  def subsamples
    render json: Sample.find(params[:id]).properties
  end

  def sample_name_from_identifier str
    parts = str.split(": ")
    if parts.length == 0
      ""
    elsif parts.length == 1
      parts[0]
    else
      parts[1..-1].join(": ")
    end
  end

  def create_samples

    @errors = []
    @samples = []

    begin
      Sample.transaction do
        params[:samples].each do |samp|
          sample = Sample.creator(samp, current_user) 
          if sample.errors.empty?
            @samples << sample
          else
            @errors << sample.errors.full_messages.join(", ")
            raise ActiveRecord::Rollback
          end
        end
      end
    rescue Exception => e
      render json: { errors: [ e.to_s, e.backtrace[0..5].join(", ") ] }
    else
      if @errors.length > 0 
        render json: { errors: @errors }
      else
        render json: { samples: @samples }
      end
    end

  end

  def annotate
    s = Sample.find(params[:id])
    begin
      data = JSON.parse(s.data)
    rescue Exception => e
      data = {}
    end
    data[:note] = (params[:note] == "_EMPTY_" ? "" : params[:note])
    s.data = data.to_json
    s.save
    render json: s
  end

  def items
    sample = Sample.find(params[:id])
    item_list = Item.includes(:locator).where(sample_id: params[:id]) # .select { |i| !i.deleted? }
    containers = ObjectType.where(sample_type_id: sample.sample_type_id)
    render json: { items: item_list.as_json(include: [:locator]), 
                   containers: containers.as_json(only:[:name,:id]) }
  end

  def collections
    s = Sample.find(params[:sample_id])
    collections = Collection.containing(s)
    containers = collections.collect { |c| c.object_type }.uniq
    render json: { collections: collections.as_json(include: :object_type), 
                   containers: containers.as_json(only: [:name,:id]) }
  end  

  def search

    if params[:user_id]
      samples = Sample.where("name like ? or id = ?", "%#{params[:query]}%", params[:query].to_i)
                      .where(user_id: params[:user_id])
    else
      samples = Sample.where("name like ? or id = ?", "%#{params[:query]}%", params[:query].to_i)
    end

    render json: samples.last(50).reverse.to_json(only: [:name,:id,:user_id,:data,:sample_type_id])

  end

  def samples

    if params[:user_id]
      samples = Sample.where(sample_type_id: params[:id], user_id: params[:user_id])
    else
      samples = Sample.where(sample_type_id: params[:id])
    end

    render json: samples.offset(params[:offset]).last(30).reverse
        .to_json(only: [:name,:id,:user_id,:data,:created_at])

  end

  def delete_item
    item = Item.find(params[:item_id])
    item.mark_as_deleted
    item.reload
    render json: { location: item.location }
  end

  def restore_item
    item = Item.find(params[:item_id])
    item.store
    item.reload
    render json: { location: item.location }
  end  

end