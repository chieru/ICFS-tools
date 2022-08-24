$path = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $path
$inputFiles = Get-ChildItem $path\input -Filter icfs_log*.csv

foreach ($input in $inputFiles){
    $UTF8NoBomEnc = New-Object System.Text.UTF8Encoding $False
    $inputName = $path + '\input\' + $input.Name
    $outputName = $path + '\output\Block-' + $input.Name

    $inputFile = New-Object System.IO.StreamReader($inputName, $UTF8NoBomEnc)
    Out-File $outputName -Encoding utf8

    $Block = ',BLOCK,'

    while ($null -ne ($line = $inputFile.ReadLine()))
    {
        if ($line.Contains($Block)) {
            echo $line | Out-File $outputName -Encoding utf8 -Append
        }
    }
    
    $inputFile.close()
}
