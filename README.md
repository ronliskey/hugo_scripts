# Hugo Scripts

Various scripts for optimizing work with Hugo Static Site Generator.

## gallerymaker.sh

Creates a directory of optimized images and thumbnail files for use in Hugo Easy Gallery.

1. Creates a new gallery drectory. (Will not overwrite existing directories.)
1. Creates reasonably sized gallery images (default: 1200px wide)
1. Creates matching thumbnail images (defaut: 300px wide)
1. Sets read permissions on all gallery images.
1. Attempts to wipe clean OSX quarantine bits.
1. Adds an **index.html** file to the new gallery directory to block index viewing.
1. Calls the Hugo 'new' command to create a **<YOUR_NEW_GALLERY>.md** file.

### Installaion

1. Install ImageMagick: https://www.imagemagick.org/script/download.php
1. Install **gallerymaker.sh**, and make it executable.
1. Set default values in **gallerymaker.sh**.
    * **HUGO_ROOT**="/path/to/your/hugo/installation/"
    * **GALLERY_ROOT**="/static/img/gallery" # The directory in which all your galleries are stored.
    * **GALLERY_SECTION**="gallery" # The Hugo Section configured to display image galleries.
    * **IMAGE_WIDTH**=1200
    * **THUMB_WIDTH**=300

### usage

     $ gallerymaker.sh [**-g** <my-new-gallery>] [**-t** <-thumb>]
