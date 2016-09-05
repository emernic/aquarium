module DNA

  def self.reverse_complement seq

    rc = { "A" => "T", "T" => "A", "C" => "G", "G" => "C" }
    seq.split('').reverse.collect { |c| rc[c].capitalize }.join('')

  end

  def self.extract_ape_features ape

    features = []

    ape[:features].each do |feature|
      a = feature[:range][0]
      b = feature[:range][1]
      features << {
        name: feature[:label],
        sequence: (feature[:complement] ? reverse_complement(ape[:sequence][a,b-a]) : ape[:sequence][a,b-a])
      }
    end

    features

  end

end
