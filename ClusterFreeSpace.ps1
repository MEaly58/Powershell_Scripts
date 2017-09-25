#Import the Failover Cluster module
Import-Module FailoverClusters
#Execute the script
$objs = @()

$csvs = Get-ClusterSharedVolume
foreach ( $csv in $csvs )
{
   $csvinfos = $csv | Select-Object -Property Name -ExpandProperty SharedVolumeInfo
   foreach ( $csvinfo in $csvinfos )
   {
      $obj = New-Object PSObject -Property @{
         Name        = $csv.Name
         Path        = $csvinfo.FriendlyVolumeName
         Size        = $csvinfo.Partition.Size
         FreeSpace   = $csvinfo.Partition.FreeSpace
         UsedSpace   = $csvinfo.Partition.UsedSpace
         PercentFree = $csvinfo.Partition.PercentFree
      }
      $objs += $obj
   }
}

$objs | Format-Table -auto Name,Path,@{ Label = "Size(GB)" ; Expression = { "{0:N2}" -f ($_.Size/1024/1024/1024) } },@{ Label = "FreeSpace(GB)" ; Expression = { "{0:N2}" -f ($_.FreeSpace/1024/1024/1024) } },@{ Label = "UsedSpace(GB)" ; Expression = { "{0:N2}" -f ($_.UsedSpace/1024/1024/1024) } },@{ Label = "PercentFree" ; Expression = { "{0:N2}" -f ($_.PercentFree) } }
