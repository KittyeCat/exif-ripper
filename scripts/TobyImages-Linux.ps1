
$ImageDirectory = $args[0]

if($ImageDirectory = $null) {
    $ImageDirectory = $PSScriptRoot 
}

$outfile = "$PSScriptRoot\output.csv"

#Grab EXIF data from Photos
Get-ChildItem -Path "$ImageDirectory\*.jpg" -Recurse  | Select-Object -Property Name,LastWriteTime | Export-CSV -Path "$PSScriptRoot\temp1.csv"

#Create Dates column
Import-CSV "$PSScriptRoot\temp1.csv" | 
Select-Object *,@{Name='DateOnly';Expression={([datetime]::ParseExact($_.LastWriteTime ,'M/dd/yyyy h:mm:ss tt',$null)).ToString('d/MM/yyyy')}} | 
Export-Csv "$PSScriptRoot\temp2.csv" -NoTypeInformation

#Create Times column
Import-CSV "$PSScriptRoot\temp2.csv" | 
Select-Object *,@{Name='TimeOnly';Expression={([datetime]::ParseExact($_.LastWriteTime ,'M/dd/yyyy h:mm:ss tt',$null)).AddHours(-10).ToString('HH:mm:ss')}} | 
Export-Csv $outfile -NoTypeInformation

Remove-Item "$PSScriptRoot\temp1.csv","$PSScriptRoot\temp2.csv"