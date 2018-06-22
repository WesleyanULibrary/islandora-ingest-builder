#!/usr/bin/env ruby

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

## if only 1 xml file, rename the single xml file to MODS.xml and move the tif files to individual folders #######################
if (xmlCount == 1) && (xmlFiles[0] != "MODS.xml")
	xmlFile = Dir.glob("#{filePath}/#{xmlFiles[0]}")
	File.rename(xmlFile[0],"#{newFilePath}/MODS.xml")
	print "XML file renamed MODS.xml"
	print "\n"
	
	folderNum = 1
	for t in tifFiles 
		Dir.mkdir("#{newFilePath}/#{folderNum.to_s}")
		tifFile = Dir.glob("#{filePath}/#{t}")
		File.rename(tifFile[0],"#{newFilePath}/#{folderNum}/#{t}")
	
		folderNum +=1
	end
else #if multiple xml files
	folderNum = 1
	
	for x in xmlFiles.reverse
		xName = File.basename(x, ".*")
		for t in tifFiles
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
end