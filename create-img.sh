#!/bin/bash

if [ ! -e "IMG" ]; then
		mkdir "IMG"
fi

size_d=$(echo $2 | grep '[1-9][0-9]*[kmgKMG]')
if [ "$1" == "" -o "$size_d" == "" ]; then
		echo "Usage: ./create-img <img-name> <size>"
		echo "Example: ./create-img test 5g"
		echo "		-- It will create a 5GB qemu-img-test.img as a rootfs"
		exit 0
fi

name_prefix="qemu-img-"
name_suffix=".img"
IMG="$name_prefix""$1""$name_suffix"
IMG_DIR="./IMG/""$1""/"

if [ -e "$IMG_DIR" ]; then
		echo "$IMG has already exist."
		exit 0
fi

echo "Creating qemu image $IMG ..."

mkdir $IMG_DIR

qemu-img create "$IMG_DIR""$IMG" $2
mkfs.ext4 "$IMG_DIR""$IMG"

echo "$IMG created done."
