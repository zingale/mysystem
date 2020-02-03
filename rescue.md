Rescuing when there is a GRUB issue:

* burn the Fedora install image to a USB disk

* boot as normal

* open terminal and setup for chroot:

  * following: https://docs.fedoraproject.org/en-US/Fedora/22/html/Multiboot_Guide/common_operations_appendix.html

  * mkdir /mnt/sysimage

  * blkid -- look for the root partition (for me it was /dev/sda3)

  * mount /dev/sda3 /mnt/sysimage

    you should see /mnt/sysimage/etc/fedora-release if this is correct

  * find the boot partition (this will have the group folders).  For me
    it was /dev/sda1

    mount /dev/sda1 /mnt/sysimage/boot

  * mount the virtual filesystems:

    for dir in /dev /proc /sys; do mount --bind $dir /mnt/sysimage/$dir ; done

  * chroot /mnt/sysimage

Now fix grub:

  * following: https://fedoraproject.org/wiki/Common_F30_bugs#GRUB_boot_menu_is_not_populated_after_an_upgrade

  * cd to /mnt/sysimage/boot/grub2

  * restore old grub.cfg (it is .rpmsave)

  * grub2-install /dev/sda



    
