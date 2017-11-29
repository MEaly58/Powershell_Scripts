#Add .Net Framework for System.Windows.Forms
Add-Type -AssemblyName System.Windows.Forms

#I suck at .Net however this will move the mouse a bit to keep the system awake
while ($true)
{
  $Pos = [System.Windows.Forms.Cursor]::Position
  $x = ($pos.X % 500) + 1
  $y = ($pos.Y % 500) + 1
  [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
  Start-Sleep -Seconds 10
}
