require 'bio'

out_file = File.open("BEI_Mock_Community_Stats.txt", "w")
out_file.write("Subject_ID\tExpected_error\tAvg_Qual_Score\tLength\n")

subject_line = []
ee_score = []
subject_line_array = []
ee_score_array = []

File.open("BEI_Mock_Even_Modified_with_ee.fastq", "r") do |f|
  f.each_line do |line|
    if /^@/.match(line)
      subject_line = line.split(";")
      ee_score = subject_line[1].split("=")
      subject_line_array.push(subject_line[0])
      ee_score_array.push(ee_score[1])
      #puts subject_line[0]+"\t"+ee_score[1]
      out_file.write(subject_line[0]+"\t"+ee_score[1]+"\t")
    end
  end
end 


file = Bio::FlatFile.auto("BEI_Mock_Even_Modified_with_ee.fastq")
file.each do |entry|
  #puts entry.class                                                                                                                                    
  #puts entry.quality_scores.length                                                                                                                     
  out_file.write((entry.quality_scores.inject(0){|sum,x| sum+x} / entry.quality_scores.length).to_s+"\t"+entry.quality_scores.length.to_s+"\n")
end

  
