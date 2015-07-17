require 'bio'

out_file = File.open("BEI_Mock_Even_Oriented.fastq", "w")

forward_primer_re = Bio::Sequence::NA.new("AGRGTTYGATYMTGGCTCAG").to_re
#p forward_primer_re
forward_primer_reverse_complement_re = Bio::Sequence::NA.new("AGRGTTYGATYMTGGCTCAG").reverse_complement.to_re
#p forward_primer_reverse_complement_re
reverse_primer_re = Bio::Sequence::NA.new("RGYTACCTTGTTACGACTT").to_re
#p reverse_primer_re
reverse_primer_reverse_complement_re = Bio::Sequence::NA.new("RGYTACCTTGTTACGACTT").reverse_complement.to_re
#p reverse_primer_reverse_complement_re


file = Bio::FlatFile.auto("BEI_Mock_Even_Modified_with_ee.fastq")
file.each do |entry|
  #puts entry.sequence_string.class
  if forward_primer_re.match(entry.sequence_string.downcase)
    out_file.write(entry)                                                                                              
  end
  if forward_primer_reverse_complement_re.match(entry.sequence_string.downcase)
    out_file.write(entry.seq.reverse!)
  end 
end

