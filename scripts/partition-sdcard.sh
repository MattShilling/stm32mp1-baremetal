#!/usr/bin/env bash

# Script to format and partition an SD card to prepare for u-boot and a bare-metal app.

# This script is meant to be run once when using a new SD Card.
# 
# After running this script, you must load your application
# code on the card using the copy-app-to-sdcard.sh script or by manually copying the uimg file

set -e

[ "$#" -eq 1 ] || { 
	echo ""
	echo "Usage: "
	echo "scripts/partition-sdcard.sh /dev/XXX"  >&2; 
	echo ""
	echo "Where /dev/XXX is the sd card device, e.g. /dev/sdc or /dev/disk3"
	exit 1; 
}

if [ ! -b $1 ]; then
	echo "Device $1 does not exist";
	exit 1;
fi

echo ""
echo "Device $1 found, removing partitions"

set -x

sgdisk --mbrtogpt -o $1
sgdisk --resize-table=128 \
    -a 1 \
	-n 1:34:545 -c 1:fsbl1 \
	-n 2:546:1057 -c 2:fsbl2 \
	-n 3:1058:5153 -c 3:ssbl \
	-N 4 -c 4:prog \
	-p $1

echo "Formatting partition 4 as FAT32"

KERNEL_NAME=$(uname -s)
case "${KERNEL_NAME}" in
	Darwin)
		diskutil eraseVolume FAT32 BAREAPP ${1}s4
		sleep 3
		diskutil unmountDisk $1 || true
		;;
	Linux)
		mkfs.fat -F 32 ${1}4
		sleep 3
		# Unmount disk (if already mounted).
		sudo umount $1 || true
		;;
	*)
		echo 'OS not supported: please format $1 partition 4 as FAT32'
		;;
esac

echo "Done!"

