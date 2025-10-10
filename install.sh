#!/bin/bash

#DISK='/dev/nvme0n1'
#PART1='/dev/nvme0n1p1'
#PART2='/dev/nvme0n1p2'

DISK='/dev/sda'
PART1='/dev/sda1'
PART2='/dev/sda2'

setfont ter-132b

echo 'Please, enter your username: '
read USERNAME

PASSWORD='1'
PASSWORD2='0'

while [ $PASSWORD != $PASSWORD2 ]; do
	echo 'Please, enter your password: '
	read -sr PASSWORD

	echo 'Please, enter your password again: '
	read -sr PASSWORD2
	clear
done

parted --script $DISK \
	mklabel gpt \
	mkpart primary fat32 1MiB 257MiB \
	mkpart primary ext4 257MiB 100% \
	set 1 esp on

mkfs.vfat $PART1
mkfs.ext4 $PART2

mount $PART2 /mnt
mkdir /mnt/boot
mount $PART1 /mnt/boot

#pacstrap -K /mnt linux-zen linux-firmware base efibootmgr neovim

#genfstab -U /mnt > /mnt/etc/fstab

#arch-chroot 

