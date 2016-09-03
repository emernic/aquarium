class SequenceVersion < ActiveRecord::Base

  attr_accessible :data, :parent_id

  belongs_to :sequence
  belongs_to :parent, class_name: "SequenceVersion", foreign_key: :parent_id

  def to_s
    "#{id}: #{data}"
  end

end
