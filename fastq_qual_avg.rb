# Array which contains the line eith quality scores
qual_lines = []

# Opening the file and getting an array with all the lines have the quality
File.open("sample.fastq", "r") do |f|
in_qual = false
  f.each_line do |line|
    if /^\+\d+/.match(line)
      in_qual = true
      next
    end  
    if in_qual
      qual_lines.push(line.chomp)  
      if /^@\d+/.match(line)
        in_qual = false
      end  
    end
  end
end
 
# Removing the elements which start with @ 
for i in qual_lines
  #puts i
  if i.start_with?('@')
    qual_lines.delete(i)
  end  
end
#puts qual_lines.inspect

# Obtaining the quality scores in an array
qual_scores = [] 
for each in 0..qual_lines.size-1
  #puts qual_lines[each].inspect
  each_element = qual_lines[each]
  each_element.split("").each do |i|
    #puts i
    current_score = i.ord
    corrected_score = current_score - 64 
    qual_scores.push(corrected_score)
  end  
end 
#puts qual_scores

# Averaging the quality scores 
tot_qual = 0
avg_qual = 0
for each in 0..qual_scores.size-1
  #puts each
  tot_qual += qual_scores[each]
  avg_qual = tot_qual/qual_scores.size
end

puts "Total quality is", tot_qual 
puts "Number of quality scores is", qual_scores.size
puts "Average quality is", avg_qual 



