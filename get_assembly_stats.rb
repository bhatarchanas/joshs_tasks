require 'json'

file_names = ARGV
#puts file_names                                                                                                                                              
#puts file_names.class                                                                                                                                        

output_file = open("Output_assembly_results.txt", "w")
output_file.puts "ID\tPolished_contigs\tMax_contig_length\tN50_contig_length\tSum_of_contig_lengths\n"

for each in 0..file_names.size-1
  file = File.read("/data/pacbio/smrtanalysis_userdata/jobs/017/0170"+file_names[each].to_s+"/results/polished_report.json")
  data_hash = JSON.parse(file)
  output_file.puts "0170"+file_names[each].to_s+"\t"+data_hash["attributes"][0]["value"].to_s+"\t"+data_hash["attributes"][1]["value"].to_s+"\t"+data_hash["a\
ttributes"][2]["value"].to_s+"\t"+data_hash["attributes"][3]["value"].to_s+"\n"
end

