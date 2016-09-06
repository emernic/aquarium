module DNA

  def self.reverse_complement seq

    rc = { "A" => "T", "T" => "A", "C" => "G", "G" => "C", "a" => "t", "t" => "a", "c" => "g", "g" => "c", "N" => "N", "n" => "n" }
    seq.split('').reverse.collect { |c| rc[c] }.join('')

  end

  def self.extract_ape_features ape

    features = []

    ape[:features].each do |feature|
      if feature[:range]
        a = feature[:range][0]
        b = feature[:range][1]
      else
        a,b, = [0,1]
      end
      features << {
        label: feature[:label],
        category: feature[:category],
        sequence: (feature[:complement] ? reverse_complement(ape[:sequence][a,b-a]) : ape[:sequence][a,b-a])
      }
    end

    features

  end

end
