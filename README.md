# islandora-ingest-builder

Ruby code to create the right file structure and naming conventions for ingesting Islandora objects. 

##To run

<pre><code>ruby [current folder] [target folder]</code></pre>

Where [current folder] is the file of XML and TIF files you want to ingest, all together in one folder, and [target folder] is the name of the folder which will hold the copied and renamed objects.

The finished file and folder structure will be similar to the following

Example 1:  
current_folder/. 
	/ar1.xml. 
	/file1.tif. 
	/file2.tif. 

target_folder/. 
	/MODS.xml. 
	/1. 
		/OBJ.tif. 
	/2. 
		/OBJ.tif. 

Example 2:
current_folder/
	/ar1.xml
	/file1.xml
	/file1.tif
	/file2.xml
	/file2.tif
	/file3.xml
	/file3.tif
	
target_folder/
	MODS.xml
	1/
		/OBJ.tif
		/OBJ.xml
	2/
		/OBJ.tif
		/OBJ.xml
	3/
		/OBJ.tif
		/OBJ.xml
		
##Notes on use

The script is based on the presence of XML and TIF files in the original folder, and a specific naming convention for both these files and the copied/renamed files. 


*In a case where the X number of TIF files have a matching XML file, they must have the same name.
*The script works based on either there being 1 XML file and n TIF files, or n TIF files and n+1 XML files. In the latter case, the non-matching XML file (based on name) will be renamed MODS.xml
