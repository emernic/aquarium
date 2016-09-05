module DNA

  class ApeParser

    def initialize content
      @t = ApeTokenizer.new content
      @result = { features: [], sequence: "" }
    end

    def parse
      while @t.current != "EOF"
        statement
      end
      @result
    end

    def statement
      if @tcurrent == "LOCUS"
        locus
      elsif @t.current == "FEATURES"
        features
      elsif @t.current == "ORIGIN"
        origin
      else
        while @t.current != "EOL"
          @t.eat
        end
        @t.eat "EOL"
      end
    end

    def locus
      @t.eat "LOCUS"
      @t.eat
      @t.eat
      @t.eat
      @result[:double_stranded] = (@t.current == 'ds-DNA')
      @t.eat
      @result[:circular] = (@t.current == 'circular')
      while @t.current != "EOL"
        @t.eat
      end
    end

    def features
      @t.eat "FEATURES"
      while @t.current != "ORIGIN"
        if @t.current == "misc_feature"
          @t.eat
          if @t.current =~ /complement/
            range = @t.eat.split('complement(')[1].split(')')[0].split('..').collect { |str| str.to_i }
            comp = true
          else
            range = @t.eat.split('..').collect { |str| str.to_i }
            comp = false
          end
        elsif @t.current =~ /label/
          label = @t.eat.split('=')[1]
          @result[:features] << { range: range, label: label, compliment: comp }
        else
          @t.eat
        end
      end
    end

    def origin
      @t.eat "ORIGIN"
      while @t.current != '//'
        if @t.current =~ /\d+/ || @t.current == "EOL"
          @t.eat
        else
          @result[:sequence] += @t.eat
        end
      end
      @t.eat '//'
    end

  end

end
