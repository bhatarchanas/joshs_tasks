require 'bio'

out_file = File.open("BEI_Mock_Community_Stats.txt", "w")
out_file.write("Subject_ID\tExpected_error\tAvg_Qual_Score\tLength\n")

subject_line = []
ee_score = []
subject_line_array = []
ee_score_array = []

file = Bio::FlatFile.auto("BEI_Mock_Even_Modified_with_ee.fastq")
file.each do |entry|
  #puts entry.class                                                                                                                                    
  #puts entry.quality_scores.length
  #puts entry.definition.split(";")[1].split("=")[1]                                                                                                        
  out_file.write(entry.definition.split(";")[0]+"\t"+entry.definition.split(";")[1].split("=")[1]+"\t"+(entry.quality_scores.inject(0){|sum,x| sum+x} / entry.quality_scores.length).to_s+"\t"+entry.quality_scores.length.to_s+"\n")
end

  
