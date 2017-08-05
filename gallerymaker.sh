#!/bin/sh

# Defaults
HUGO_ROOT="/Volumes/Data/Users/ron/Sites/test_hugo/ronliskey_new"
GALLERY_ROOT="/static/img/gallery"
GALLERY_SECTION="gallery"
IMAGE_WIDTH=1200
THUMB_WIDTH=300

# Defaults that can be overwritten by command line.
THUMB_NAME="-thumb"
GALLERY="new-gallery"

function cd_hugo_root () {
  cd ${HUGO_ROOT}
}

function cd_gallery_root () {
  cd ${HUGO_ROOT}${GALLERY_ROOT}
}

function cd_gallery () {
  cd ${HUGO_ROOT}${GALLERY_ROOT}/${GALLERY}
}

function usage()
{
  echo "Usage: `basename $0` options (-d output_dir) (-t -thumbname) -h for help"
  exit
}

function dir_error()
{
    echo "\nERROR: That directory already exists!"
    usage
}

pause(){
 read -n1 -rsp $'Press any key to continue or Ctrl+C to exit...\n'
}


while getopts g:t:h? option
do
  case "${option}"
  in
  g) GALLERY=${OPTARG};;
  t) THUMB_NAME=${OPTARG};;
  h|?) usage;;
  esac
done

for pic in *".JPG"
do
	if [[ -f "$pic" ]]
	then
	    mv "${pic}" "${pic%.JPG}.jpg"
	fi
done

for pic in *".PNG"
do
	if [[ -f "${pic}" ]]
	then
	    mv "${pic}" "${pic%.PNG}.png"
	fi
done

OUTPUT_DIR=${HUGO_ROOT}${GALLERY_ROOT}/${GALLERY}

# Abort if directory already exists.
if [ -d "${OUTPUT_DIR}" ]; then
    dir_error
fi

mkdir ${OUTPUT_DIR}

# Create resized image files.
for pic in *.jpg
do
	convert ${pic} -resize ${IMAGE_WIDTH} ${OUTPUT_DIR}/${pic}
done

# Create thumbnail files.
for pic in *.jpg
do
	cp "$pic" "${OUTPUT_DIR}/${pic%.jpg}${THUMB_NAME}.jpg"
done

# Resize thumbnail files.
for pic in ${OUTPUT_DIR}/*${THUMB_NAME}.jpg
do
	convert ${pic} -resize ${THUMB_WIDTH} $pic
done

# Add index file to block directory view.
touch ${OUTPUT_DIR}/index.html

# Ensure all files have correct read permissions.
chmod go+r ${OUTPUT_DIR}/*.*

# Remove quarentine atribute if present. (OSX only)
find ${HUGO_ROOT}${GALLERY_ROOT}/${GALLERY} -iname '*${THUMB_NAME}.jpg' -print0 | xargs -0 xattr -dr com.apple.quarantine
find ${HUGO_ROOT}${GALLERY_ROOT}/${GALLERY} -iname '*${THUMB_NAME}.png' -print0 | xargs -0 xattr -dr com.apple.quarantine

clear
ls -l ${OUTPUT_DIR}

cd_hugo_root
hugo new gallery/${GALLERY}.md
