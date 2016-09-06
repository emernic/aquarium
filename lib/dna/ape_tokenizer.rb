module DNA

  class ApeTokenizer

    def initialize content
      @tokens = content.gsub(/\n/,' EOL ').gsub(/\s+/m, ' ').strip.split(" ")
      @tokens << "EOF"
      @index = 0
    end

    def current
      @tokens[@index]
    end

    def next
      @tokens[@index + 1]
    end

    def eat str=nil
      raise "expected #{str} at token #{current}" if str && current != str
      temp = current
      @index += 1
      if @index > @tokens.length
        raise "ran out of tokens!"
      end
      temp
    end

  end

end
