require 'rails_helper'

RSpec.describe Sequence, :type => :model do

  describe "Sequences" do
    it "makes sequences and features" do

      s = Sequence.new circular: false, single_stranded: false
      s.save

      s.data = "ATCCGGC"
      s.data = "TTCCGGC"

      f = Sequence.new circular: false, single_stranded: false
      f.save
      f.data = "CCGG"

      s.associate_feature f, name: "thing", type: "plain"

      puts s

    end

  end

end
