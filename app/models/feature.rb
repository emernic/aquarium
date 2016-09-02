class Feature < ActiveRecord::Base

  attr_accessible :name, :type

  belongs_to :super, class_name: "Sequence", foreign_key: :super_id
  belongs_to :sub,   class_name: "Sequence", foreign_key: :sub_id

end