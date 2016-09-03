class Sequence < ActiveRecord::Base

  attr_accessible :circular, :single_stranded
  has_many :sequence_versions

  def data= str
    save
    versions = sequence_versions
    v = sequence_versions.create data: str
    v.parent_id = versions.last.id unless versions.empty?
    v.save
  end

  def associate_feature seq, opts={}
    feature = Feature.new opts.merge(super_id: id, sub_id: seq.id)
    feature.save
  end

  def latest
    sequence_versions.last
  end

  def to_s
    latest.to_s
  end

end
