require 'rails_helper'

RSpec.describe Sequence, :type => :model do

  describe "Sequences" do
    it "makes sequences and features" do

      s = Sequence.new circular: false, single_stranded: false

      s.data = "ATCCGGC"
      s.data = "TTCCGGC"

      puts "s = #{s.latest}"
      puts "previous = #{s.previous}"

      s.add_feature "CCGG", "thing", "plain"

      puts "---------------"
      puts "s = #{s}"
      puts "s.features:"
      s.features.each do |f|
        puts "  #{f.name}: #{f.latest}"
      end

      c = s.copy

      puts "---------------"
      puts "c = #{c}"
      puts "c.features:"      
      c.features.each do |f|
        puts "  #{f.name}: #{f.latest}"        
      end

    end

  end

end
