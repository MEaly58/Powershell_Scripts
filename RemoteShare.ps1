#Script to open temp remote share
#Variables Go here
$Drive = READ-Host "Share to open"
#Execute
New-PSDrive –Name “T” –PSProvider FileSystem –Root  $Drive
