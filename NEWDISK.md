For > 2 TB, use parted

parted /dev/sda

mklabel gpt
unit TB
mkpart primary 0.0 4.0TB
print
quit

verify with fdisk -l

mkfs.ext4 /dev/sda1

