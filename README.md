# islandora-ingest-builder

Ruby code to create the right file structure and naming conventions for ingesting Islandora objects. 

## To run

<pre><code>ruby [current folder] [target folder]</code></pre>

Where [current folder] is the file of XML and TIF files you want to ingest, all together in one folder, and [target folder] is the name of the folder which will hold the copied and renamed objects.

The finished file and folder structure will be similar to the following, with each XML file renamed "MODS.xml" or "OBJ.xml" (see below), and each TIF file renamed "OBJ.tif".

Example 1: 
<pre><code>
current_folder/  
	/ar1.xml  
	/file1.tif  
	/file2.tif  

target_folder/   
	/MODS.xml   
	/1  
		/OBJ.tif  
	/2  
		/OBJ.tif  
</code></pre>
Example 2: 
<pre><code>
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
</code></pre>	

## Notes on use

The script is based on the presence of XML and TIF files in the original folder, and a specific naming convention for both these files and the copied/renamed files. 


* In a case where  each TIF file has a matching XML file, each pair must have the same name, e.g. myfile.tif or myfile.xml. The one allowed variant is for the tif file to include "cpd" at the end of the filename, i.e. myfilecpd.tif

* The script assumes two scenarios: either 1 XML file and n TIF files, or n TIF files and n+1 XML files. In the latter case, the non-matching XML file (based on name) will be renamed MODS.xml, and the other XML files will be renamed OBJ.xml
