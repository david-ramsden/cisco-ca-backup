 Script to backup the Certificate Authority from an IOS device.
#
# Copyright (c) 2021 David Ramsden
#
# This software is provided 'as-is', without any express or implied
# warranty. In no event will the authors be held liable for any damages
# arising from the use of this software.
#
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
#
# 1. The origin of this software must not be misrepresented; you must not
#    claim that you wrote the original software. If you use this software
#    in a product, an acknowledgment in the product documentation would be
#    appreciated but is not required.
# 2. Altered source versions must be plainly marked as such, and must not be
#    misrepresented as being the original software.
# 3. This notice may not be removed or altered from any source distribution.
#

# List of file extensions to backup.
set file_exts {cer crl prv pub ser cnm}
# FTP server.
set ftp_server "10.10.10.140"
# FTP server path.
# Should be prefixed with a / but there should not be a trailing /.
set ftp_path "/backups/dmvpnca"

# Iterate file extensions.
foreach file_ext $file_exts {
	# Execute: dir nvram:*.<file ext>
	set lines [exec "dir nvram:*.$file_ext"]
	
	# Iterate output from dir command, line by line.
	foreach line [split $lines "\n"] {
		# Remove newline from end of output.
		set line [string trimright $line]
		# Match each file.
		if { [regexp {^\s+.* (.*)$} $line -> file] } {
			# Copy the file to the FTP server.
			typeahead "\n\n"
			copy nvram:$file ftp://$ftp_server/$ftp_path/$file
		}
	}
}
