# Backup a Cisco Certificate Authority

## Introduction
This TCL script can be run on an IOS device via a kron schedule and will allow the relevant files stored on NVRAM of the device to be copied to an FTP server, allowing the Certificate Authority to be backed up and subsequently restored, as per the [Cisco design guide for Digital Certificates/PKI](https://www.cisco.com/c/en/us/td/docs/solutions/Enterprise/Security/DCertPKI.html#wp130755).

## Usage
1. In backup_ca.tcl, edit the `ftp_server` and `ftp_path` variables.
2. Copy the script to the IOS device, e.g. to flash:
3. On the device, set `ip ftp username` and `ip ftp password` and if appropriate `ip ftp source-interface`
4. On the device, configure a kron schedule. For example:
````
kron policy-list BACKUP_CA
 cli tclsh flash:/backup_ca.tcl
kron occurance DAILY at 04:00 recurring
 policy-list BACKUP_CA
````
