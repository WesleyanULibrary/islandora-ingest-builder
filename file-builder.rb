#!/usr/bin/env ruby

#get filepath variables from the input
filePath = ARGV[0]
newFilePath = ARGV[1]

#create arrays of the tif and xml files
xmlCount = 0
xmlFiles = Array.new

tifCount = 0
tifFiles = Array.new

thefiles = Dir.entries(filePath)
thefiles.each do |f|
 if !File.directory?(f)
	if File.extname(f).strip.downcase[1..-1] == "xml"
		xmlCount += 1
		xmlFiles.push(f)
	elsif File.extname(f).strip.downcase[1..-1] == "tif"
		tifCount += 1
		tifFiles.push(f)
	end
 end
end

#create the new file folder
Dir.mkdir("#{newFilePath}")

## if only 1 xml file, rename the single xml file to MODS.xml and move the tif files to individual folders ##
if xmlCount == 1
	xmlFile = Dir.glob("#{filePath}/#{xmlFiles[0]}")
	File.rename(xmlFile[0],"#{newFilePath}/MODS.xml")
	
	folderNum = 1
	tifFiles.each do |t|
		Dir.mkdir("#{newFilePath}/#{folderNum.to_s}")
		tifFile = Dir.glob("#{filePath}/#{t}")
		File.rename(tifFile[0],"#{newFilePath}/#{folderNum}/#{t}")
	
		folderNum +=1
	end
	
	puts "\nMODS.xml file created and #{folderNum-1} tif files copied into folders\n\n"
else #if multiple xml files
	folderNum = 1
	
	xmlFiles.reverse.each do |x|
		xName = File.basename(x, ".*")
		tifFiles.each do |t|
			fixedName = t.gsub("cpd", "")
			fixedName = File.basename(fixedName,".*")
			if xName == fixedName
				Dir.mkdir("#{newFilePath}/#{folderNum.to_s}")
				tifFile = Dir.glob("#{filePath}/#{t}")
				File.rename(tifFile[0],"#{newFilePath}/#{folderNum}/#{t}")
				
				xmlFile = Dir.glob("#{filePath}/#{x}")
				File.rename(xmlFile[0],"#{newFilePath}/#{folderNum}/#{x}")
				
				folderNum += 1
			end
		end
	end
	
	#copy over the last xml file as mods.xml
	thefiles = Dir.entries(filePath)
	thefiles.each do |f|
		if !File.directory?(f)
			xmlFile = Dir.glob("#{filePath}/#{f}")
			File.rename(xmlFile[0],"#{newFilePath}/MODS.xml")
		end
	end
	
	puts "\nMODS.xml file created and #{folderNum-1} tif and xml files copied into folders\n\n"
end

#delete the original folder
system("rm -r #{filePath}")