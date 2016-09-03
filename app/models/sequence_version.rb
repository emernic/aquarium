class SequenceVersion < ActiveRecord::Base

  attr_accessible :data

  belongs_to :sequence

  def to_s
    "#{id}: #{data}"
  end

end
