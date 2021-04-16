function .env(){
    param(
    [Parameter(Position = 0, Mandatory=$true)][ValidateScript({$_.Trim().length -gt 0})][string]$inputvar
    )
    if(!($script:baseDir)){$script:baseDir = Split-Path $myinvocation.mycommand.path -Parent}
    $dotenvcontent = get-content "$($script:baseDir)\.env" |where {$_ -like "$($inputvar)*"}
    foreach($item in $dotenvcontent){
            $splititem=$item.split("=",2)
        $varnamefull=$splititem[0].trim()
        if($varnamefull -eq $inputvar){
        $value=$splititem[1].trim()
        if($value -like "@*" -or $value -like "(*" -or $value -like "{*" -or $value -like "[[]*"){
                Try{
                    Invoke-Expression $value | Out-Null
                    $value=Invoke-Expression $value
                } Catch {}
        }elseif($value -eq "`$true" -or $value -eq "true"){$value=$true}
        elseif($value -eq "`$false" -or $value -eq "false"){$value=$false}
        else{
            Try{
                [int]$value | Out-Null
                $value=[int]$value
            } Catch {
                Try{
                    [decimal]$value | Out-Null
                    $value=[decimal]$value
                } Catch {}
            }
        }
        return $value
        }
    }
    Write-Warning "$($inputvar): Not Found in .env"
}
