#!/bin/sh

. /sbin/ovirt-boot-functions


# Check firstboot arg
# accept either ovirt-firstboot or firstboot
# return if =0 or =no
if getarg firstboot >/dev/null; then
    fb=$(getarg firstboot)
elif getarg ovirt_firstboot; then
    fb=$(getarg ovirt_firstboot)
else
    return 0
fi

if [ "$fb" = "no" -o "$fb" = 0 ]; then
    return 0
fi


# Check storage_init argument
# Accept either storage_init or ovirt_init
# Prefer storage_init
# Blank entry will result in getting first disk

if getarg storage_init; then
    storage_init=$(getarg storage_init)
elif getarg ovirt_init; then
    storage_init=$(getarg ovirt_init)
else
    return 0
fi

# storage_init is passed in a specific format
# A comma separated list of HostVG devices
# then optionally, a comma separated list of AppVG devices
# The two lists are separated by a ';'
# e.g, storage_init=/dev/sda,/dev/sdb;/dev/sdc,/dev/sdd
# would partition sda and sdb as part of HostVG and
# sdc and sdd as part of AppVG
# Since we only care which disks are being used, change to a single list
storage_init=$(echo $storage_init | sed 's/;/,/')

oldIFS=$IFS

IFS=","
for dev in $storage_init; do
    device=$(IFS=$oldIFS parse_disk_id "$dev")
    echo "Wiping LVM from device: ${device}"
    IFS=$oldIFS
    for i in $(lvm pvs --noheadings -o pv_name,vg_name --separator=, $device* 2>/dev/null); do
        pv="${i%%,*}"
        vg="${i##*,}"
        if [ -n "$vg" ]; then
            lvm vgremove -ff "$vg"
        fi
        lvm pvremove -ff "$pv"
    done
    IFS=,
done

IFS=$oldIFS


return 0
