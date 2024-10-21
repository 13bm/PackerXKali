SHELL := /bin/bash

# Variables
VCENTER_USERNAME =
VCENTER_PASSWORD =
iso_url =
iso_checksum =

# Define targets
.PHONY: all kali-vm-base clean 

kali-vm-base:
	@latest_version=$$(curl -s 'https://cdimage.kali.org/' | grep -oE 'kali-[0-9]+\.[0-9]+' | tail -n 1); \
	latest_iso=$$(curl -s "https://cdimage.kali.org/$$latest_version/" | grep -oE '<a href="([^"]+-installer-amd64\.iso)"' | awk -F'"' '{print $$2}'); \
	iso_url="https://cdimage.kali.org/$$latest_version/$$latest_iso"; \
	iso_checksum=$$(curl -sL "https://cdimage.kali.org/$$latest_version/SHA256SUMS" | grep "$$latest_iso" | grep -v '.iso.torrent' | awk '{print "sha256:" $$1}'); \
	echo "iso urlL: $$iso_url"; \
	echo "iso checksum: $$iso_checksum"; \
	export iso_url=$$iso_url && \
	export iso_checksum=$$iso_checksum && \
	read -p "Enter vSphere username: " VCENTER_USERNAME;  \
	read -sp "Enter vSphere password: " VCENTER_PASSWORD; \
	echo; \
	export VCENTER_USERNAME=$$VCENTER_USERNAME && \
	export VCENTER_PASSWORD=$$VCENTER_PASSWORD && \
	packer init -var-file=variables/kali-vm.pkrvars.hcl builds/linux-kali-latest && \
	packer build -var-file=variables/kali-vm.pkrvars.hcl builds/linux-kali-latest
	@$(MAKE) clean

clean:
	@unset VCENTER_USERNAME
	@unset VCENTER_PASSWORD
	@unset iso_url
	@unset iso_checksum
	@echo "Environment variables cleared."
