class Feature < ActiveRecord::Base

  attr_accessible :name, :category, :super_id, :sub_id

  belongs_to :super, class_name: "Sequence", foreign_key: :super_id
  belongs_to :sub,   class_name: "Sequence", foreign_key: :sub_id

  def latest
    sub.latest
  end

end