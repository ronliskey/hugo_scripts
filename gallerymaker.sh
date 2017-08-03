#!/bin/sh

function usage()
{
  echo "Sets up a directory of images for use in Hugo Easy Gallery."
  echo "Copy resulting files into a gallery directory in your Hugo site."
  echo $0 "-d [output_directory]"
  echo "Optional arguments: "
  echo "\t-d Name of output directory"
  echo "\t-v Verbose"
  echo "\t-h --help"
  echo ""
}

IMAGE_WIDTH=1200
THUMB_WIDTH=300
THUMB_NAME=-thumb
OUTPUT_DIR="gallery_files"
VERBOSE=0

while getopts d:vh? option
do
  case "${option}"
  in
  d) OUTPUT_DIR=${OPTARG};;
  v) VERBOSE=$OPTARG;;
  h|?) HELP=$OPTARG;;
  esac
done

#
#
# Thumbnail filenames must match main filenames.
#    <main>.jpg
#    <main>-thumb.jpg
#

clear

echo "\nRenaming files with U/C JPG..."
for pic in *".JPG"
do
	if [[ -f "$pic" ]]
	then
	    mv "$pic" "${pic%.JPG}.jpg"
	    echo "\t $pic"
	fi
done


echo "\nRenaming files with U/C PNG..."
for pic in *".PNG"
do
	if [[ -f "$pic" ]]
	then
	    mv "$pic" "${pic%.PNG}.png"
	    echo "\t $pic"
	fi
done

echo "\nCreating directory: $OUTPUT_DIR"
mkdir -p $OUTPUT_DIR 

echo "\nResizing images..."
for pic in *.jpg
do
	convert $pic -resize $IMAGE_WIDTH  $OUTPUT_DIR/$pic
	echo "\t $pic"
done

echo "\nCreating thumbnails..."
for pic in *.jpg
do
	cp "$pic" "$OUTPUT_DIR/${pic%.jpg}$THUMB_NAME.jpg"
	echo "\t $pic"
done

echo "\nResizing thumbnails..."
for pic in $OUTPUT_DIR/*-thumb.jpg
do
	convert $pic -resize $THUMB_WIDTH $pic
	echo "\t $pic"
done

echo "\nWorking in directory: $OUTPUT_DIR..."
cd $OUTPUT_DIR 

echo "\nAdding index file."
touch index.html

echo "\nSetting read file permissions..."
chmod go+r *.* 

echo "\nDeleting quarantine bits..."
# xattr -dr com.apple.quarantine *.*
find . -iname '*-thumb.jpg' -print0 | xargs -0 xattr -d com.apple.quarantine
find . -iname '*-thumb.png' -print0 | xargs -0 xattr -d com.apple.quarantine

echo "\n Fini! \n"
