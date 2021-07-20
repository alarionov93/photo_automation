
#### Default directory of search for ready photos: /Volumes/Data/PhotoDevNew/Export"$year" *including subdirs!*
#### Default directory with production photos: /Volumes/Data/PhotoDevNew/ProdCopies"$year"
#### Name patterns: 
1. \*Panorama.jpg 
2. \*_ps.jpg 
3. \*_ps.tif 
4. \*Panorama.tif
###### *upd: files with spaces are renaming now ' ' -> '_'*

## Create links according to ypur paths in OS
	ln -s /path/to/assembling_pano_executor.sh /usr/local/bin/apexec
	ln -s /path/to/pano_tool.sh /usr/local/bin/mkpano
## Simple usage:
	~ $ apexec /path/to/working/dir --pre-exec
### **--pre-exec option used for generating files with info about field of view for every source image, and create backup dirs with sources.**
#### *'.' is default path to working dir for apexec!*
## and then use
	~ $ apexec /path/to/working/dir
## to init walk by dirs with jpg sources.