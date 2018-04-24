#!/bin/bash

if [ "$1" == "" ]; then
		echo "Usage: ./launch.sh <vm-name>"
		echo "Example: ./launch.sh test (it will launch IMG/test/qemu-img-test.img)"
		exit 0
fi

if [ ! -e "IMG/$1/qemu-img-$1.img" ]; then
		echo "VM $1 doesn't exist"
		exit 0
fi

sudo qemu-system-x86_64 --enable-kvm\
		-m 2048	\
		-smp 8	\
		-kernel "/home/refone/cuckoo-migration/arch/x86/boot/bzImage" \
		-hda "IMG/$1/qemu-img-$1.img" \
		#-drive file=IMG/"$1"/qemu-img-$1.img,index=0,media=disk,format=raw \
		-append "root=/dev/sda" \
		-net bridge \
		-net nic \
#		-append	console=ttyS0 \
#		--nographic