class Version < ActiveRecord::Base

  attr_accessible :data

  belongs_to :sequence

end
