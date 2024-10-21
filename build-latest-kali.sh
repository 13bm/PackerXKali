#!/bin/bash

# python3 -m http.server --directory ./http 8000 &> /dev/null &
# pid=$!
# echo "Python web server for preseed running in background ${pid}"

# Function to clean up environment variables
cleanup() {
    # unset VSPHERE_SERVER
    unset VCENTER_USERNAME
    unset VCENTER_PASSWORD
    unset iso_url
    unset iso_checksum
    # kill "${pid}"
    # echo "Python Server Stopped."
    echo "Environment variables cleared."
}

# Prompt for vSphere credentials
# read -p "Enter vSphere server: " VSPHERE_SERVER
read -p "Enter vSphere username: " VCENTER_USERNAME
read -sp "Enter vSphere password: " VCENTER_PASSWORD
echo

# Export variables as environment variables
# export VSPHERE_SERVER
export VCENTER_USERNAME
export VCENTER_PASSWORD

# Fetch the latest ISO URL and checksum
latest_version=$(curl -s 'https://cdimage.kali.org/' | grep -oE 'kali-[0-9]+\.[0-9]+' | tail -n 1)
latest_iso=$(curl -s "https://cdimage.kali.org/$latest_version/" | grep -oE '<a href="([^"]+-installer-amd64\.iso)"' | awk -F'"' '{print $2}')
iso_url="https://cdimage.kali.org/$latest_version/$latest_iso"
iso_checksum=$(curl -sL "https://cdimage.kali.org/$latest_version/SHA256SUMS" | grep "$latest_iso" | grep -v '.iso.torrent' | awk '{print "sha256:" $1}')

echo "Latest ISO URL: $iso_url"
echo "Latest ISO Checksum: $iso_checksum"

export iso_url="$iso_url"
export iso_checksum="$iso_checksum"

# Update the Packer template with the latest ISO URL and checksum
packer init -var-file variables/kali-vm.pkrvars.hcl builds/linux-kali-latest
packer build -var-file variables/kali-vm.pkrvars.hcl builds/linux-kali-latest

# Call cleanup function to unset environment variables
cleanup