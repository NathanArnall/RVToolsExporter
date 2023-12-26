$RVToolsFilePath = "C:\Program Files (x86)\Dell\RVTools\RVTools.exe" # Point this to your RVTools install location
$ExportDir = "$env:HOMEPATH\Documents\RVTools Reports" # Directory of the file you want to export to
$ExportName = "RVTools_Export.xlsx" # Name of the file that gets exported. Leave .xlsx at the end.
$ESXiUsername = "" # Username used to log into vSphere
$ESXiServer = "" # Server IP Address or Hostname.
$GenerateEncPWD = $false # Set to $true if you want to ask for the password each time. Leave as $false and set $EncPWD for scripting and automating.
$EncPWD = "" # Required if $GenerateEncPWD = $false. Encrypted Password from RVTools password encyption powershell script, or remove the comment from the following code on $set-clipboard (line 24) and set generate password to $true to use the same script.
if ($GenerateEncPWD -eq $true){
        # Script:    RVToolsPasswordEncryption.ps1
        # Version:   1.0
        # Date:      November, 2023
        # By:        Dell Technologies
        # Read password as secure string from host
        #==================================================================
        $securepwd = Read-Host "Please enter your password" -AsSecureString
        # Encrypt password
        $encryptedpwd = $securepwd | ConvertFrom-SecureString
        # Prefix the encrypted password with the string "_RVToolsV3PWD" so that RVTools understands what needs to be done
        $encryptedpwd = '_RVToolsV3PWD' + $encryptedpwd
        #==================================================================

    # Set $EncPWD to finished password.
    $EncPWD = $encryptedpwd
    #set-clipboard "$EncPWD" # Remove comment to set the clipboard to use the password in the $EncPWD variable if you need to generate one.

}

$RVToolsArguments = ".\RVTools.exe -s $ESXiServer -u $ESXiUsername -p $EncPWD -c ExportAll2xlsx -d '$ExportDir' -f $ExportName" # Command that gets invoked. Unable to pass through the string into the command without invoking.
function ExportRV() {
    if (Test-Path $ExportDir) {
        cd $RVToolsFilePath\..
        iex "$RVToolsArguments"
        Write-Host "File will be created at $ExportDir"\"$ExportName"
        }
    else {
        Write-Host "Unable to find directory specified. Check if $ExportDir exists."
        $Confirm = Read-Host "Would you like to create this directory at '$ExportDir' and try again? y/n"
        if ($Confirm.ToLower() -eq "y"){
            mkdir $ExportDir
            if (Test-Path $ExportDir) {
                "Directory created successfully."
                ExportRV
                }
            else {
                "Unable to create directory. Check path and permissions."
            }
        }
    }
}
ExportRV