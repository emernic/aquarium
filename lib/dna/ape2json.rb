require_relative 'ape_tokenizer'
require_relative 'ape_parser'
require_relative 'ape_feature_extractor'

apefilename = ARGV[0]

file = File.open(apefilename,"r")
content = file.read + " EOF"
file.close

parser = DNA::ApeParser.new content
seq = parser.parse
puts seq
puts DNA.extract_features(seq)
