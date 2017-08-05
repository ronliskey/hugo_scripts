# Hugo Scripts

Various scripts for optimizing work with Hugo Static Site Generator.

## gallerymaker.sh

Creates a directory of optimized images  and thumbnail files for use in Hugo Easy Gallery.

1. Creates a new drectory for the resulting gallery images. (Will not overwrite existing directories).
1. Creates reasonably sized images (defaut: 1200px wide)
1. Creates matching thumbnail images (defaut: 300px wide)
1. Sets read permissions on all gallery images.
1. Attempts to wipe clean the OSX 'quarentine' bit.
1. Adds an 'index.html' file to the new gallery directory to block index viewing.
1. Calls the Hugo 'new' command to create a '<YOUR_NEW_GALLERY>.md' file.
