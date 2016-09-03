class Sequence < ActiveRecord::Base

  attr_accessible :circular, :single_stranded
  has_many :sequence_versions
  has_many :features, foreign_key: :super_id

  def data= str
    save
    if sequence_versions.empty?
      v = sequence_versions.create data: str
      v.save
    else
      l = latest
      v = sequence_versions.create data: str, parent_id: latest.id 
      v.save
    end
  end

  def associate_feature seq, opts={}
    feature = Feature.new opts.merge(super_id: id, sub_id: seq.id)
    feature.save
  end

  def add_feature data, name, category, opts={circular: false, single_stranded: :true}
    f = Sequence.new(opts)
    f.data = data
    associate_feature f, name: name, category: category
  end

  def copy
    new_sequence = Sequence.new circular: :circular, single_stranded: :single_stranded
    new_sequence.save
    v = new_sequence.sequence_versions.create data: latest.data, parent_id: latest.id
    features.each do |f|
      new_sequence.associate_feature f.sub.copy, name: f.name, category: f.category
    end
    new_sequence
  end

  def all
    sequence_versions
  end

  def latest
    sequence_versions.last
  end

  def previous
    sequence_versions.last.parent
  end

  def to_s
    latest.to_s
  end

end
