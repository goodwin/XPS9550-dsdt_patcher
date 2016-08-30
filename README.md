# DSDT patcher for Dell XPS 9550 laptop
This is my own patcher script to fastly prepare dsdt for hackintosh. Currently used with 10.11.6 El Capitan
Works just fine with iMac17,1 SMBIOS

## Howto use it
* Put original files from EFI/Clover/ACPI/origin to ./original
* Run build.sh script
* When it will finish copy all *.aml files from patched folder to EFI/Clover/ACPI/patched
* In clover config drop DMAR table and drop all OEM SSDT tables
* If you are using ordered load of SSDT in Clover - double check that you have all .aml files in the list

## Fixing HDMI video out
* Find your Board-ID in /System/Library/Extensions/AppleGraphicsControl.kext/Contents/PlugIns/AppleGraphicsDevicePolicy.kext/Contents/Info.plist
* Just after this line find attribute "Config2" and replace with "none"
* Refresh kext cache
* Reboot and use
