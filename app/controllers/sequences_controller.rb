class SequencesController < ApplicationController

  before_filter :signed_in_user

  def index   

    respond_to do |format|

      format.html do
        @sequences = Sequence.includes(:features, :sequence_versions).all
      end

      format.json do 
        render json: Sequence.includes(:sequence_versions).all
                             .as_json(include: [:features, :sequence_versions])
      end

    end    

  end

  def show

    respond_to do |format|

      format.html

      format.json do
        render json: Sequence.includes(:sequence_versions, features: { sub: :sequence_versions })
                             .find(params[:id])
                             .as_json(include: [ :sequence_versions, features: { include: { sub: { include: :sequence_versions } } } ])
      end

    end

  end

  def new

    sequence = Sequence.new single_stranded: false, circular: false
    sequence.save
    redirect_to sequence_path(id: sequence.id)

  end

  def upload

    sequence = Sequence.find(params[:id])

    # begin
      sequence.from_ape(params[:file])
      redirect_to sequence_path(id: sequence.id, format: :json)
    # rescue Exception => e
      # logger.info e
      # render json: { error: e }
    # end   

  end

end