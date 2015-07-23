require 'bio-blastxmlparser'

output_file = File.open("BEI_Alignment_paserd.csv", "w")

fn = "BEI_Alignment.xml"
n = Bio::BlastXMLParser::XmlIterator.new(fn).to_enum
n.each do | iter |
  hit = iter.hits.first
  print hit.identity, "\t", hit.evalue, "\t", hit.align_len, "\n"
end
