 #Powershell to convert .vhd to .vhdx. Time to perform is dependent on the size of the vhd file.
Convert-VHD –Path 'C:\ClusterStorage\Volume1\Server\Server.vhd' –DestinationPath 'C:\ClusterStorage\Volume1\Server\Server.vhdx' 
# Powershell to convert from 512 sector size to 4096.  Goes very fast.
set-vhd 'C:\ClusterStorage\Volume1\Server\Server.vhdx' -PhysicalSectorSizeBytes 4096
