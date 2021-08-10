
#### Default directory of search for ready photos: /Volumes/Data/PhotoDevNew/Export"$year" *including subdirs!*
#### Default directory with production photos: /Volumes/Data/ProdCopies"$year"
#### Name patterns:
1. `*Panorama*.jpg` 
2. `*_ps*.jpg`

###### *upd: files with spaces are renaming now ' ' -> '_'*

## Create links according to your paths in OS
	ln -s /path/to/assembling_pano_executor.sh /usr/local/bin/apexec
	ln -s /path/to/pano_tool.sh /usr/local/bin/mkpano
## Simple usage:
	~ $ apexec /path/to/working/dir --pre-exec
### **--pre-exec option used for generating files with info about field of view for every source image, and create backup dirs with sources.**
#### *'.' is default path to working dir for apexec!*
## and then use
	~ $ apexec /path/to/working/dir
## to init walk by dirs with jpg sources.
## If .pto file has changed by hand:
	~ $ apexec /path/to/working/dir --blend-only
## it will only generate tiff files and blend panorama, so .pto should contain properly determined control points by this moment!
### Standalone usage:
	# default
	mkpano /path/to/working/dir
	# if correction of projection is done (from hugin interface):
	mkpano /path/to/working/dir --blend-only
###### *removed option '-m' from autooptimiser command because exposition correction is done the wrong way*
###### *--canvas=70%: sometimes `out*` files are too large* -> need to set canvas by hand.
###### *--fov option is not working correctly* -> let hugin (pto_gen) set it.
###### *--center panorama not working, too* -> if center can not be determined (e.g. panorama is stretched and moved to up or down), open .pto file and set pano to center by hands, then run apexec or mkpano with `--blend-only` option.
