require 'bio'

output_file = File.open("/home/archana/projects/mock_community/BEI_Mock_OTU_nonchimera_edit.fasta", "w")

file = Bio::FastaFormat.open("/home/archana/projects/mock_community/BEI_Mock_OTU_nonchimera.fasta")
file.each do |entry|
  output_file.write(">"+entry.definition+"barcodelabel="+entry.definition.split(";")[0]+";\n")
  output_file.write(entry.seq+"\n")
end 
