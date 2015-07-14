require 'json'

file_names = []
File.open("Assembly_files_to_read.txt", "r") do |f|
  f.each_line do |line|
    file_names = line.split(" ")
  end
end

#puts file_names                                                                                                                                              
#puts file_names.class                                                                                                                                        

output_file = open("Output_assembly_results.txt", "w")
output_file.puts "ID\tPolished_contigs\tMax_contig_length\tN50_contig_length\tSum_of_contig_lengths\n"

prefix = "017"

for each in 0..file_names.size-1
  file = File.read("/data/pacbio/smrtanalysis_userdata/jobs/#{prefix}/#{prefix}0"+file_names[each].to_s+"/results/polished_report.json")
  data_hash = JSON.parse(file)
  output_file.puts "#{prefix}0"+file_names[each].to_s+"\t"+data_hash["attributes"][0]["value"].to_s+"\t"+data_hash["attributes"][1]["value"].to_s+"\t"+data_h\
ash["attributes"][2]["value"].to_s+"\t"+data_hash["attributes"][3]["value"].to_s+"\n"
end
