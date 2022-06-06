#Thanks ScriptingGuy1 the function for the select file dialog box works great. 



Function Get-FileName($initialDirectory)
    {
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |
    Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "All files (*.*)| *.*"
    $OpenFileDialog.ShowDialog() | Out-Null 
    $OpenFileDialog.filename 
    } #end function 

#now select CSV From dir

$ImportCsv = Get-FileName -initialDirectory "C:\" 

#then do stuff with it 

$ImportCsv | ForEach-Object {
    New-ADUser `
        -Name $($_.FirstName + " " + $_.LastName) `
        -GivenName $_.FirstName `
        -Surname $_.LastName `
        -Department $_.Department `
        -State $_.State `
        -EmployeeID $_.EmployeeID `
        -DisplayName $($_.FirstName + " " + $_.LastName) `
        -Office $_.Office `
        -UserPrincipalName $_.UserPrincipalName `
        -SamAccountName $_.SamAccountName `
        -AccountPassword $(ConvertTo-SecureString $._Password -AsPlainText -Force) `
        -ChangePasswordAtLogon $True `
        -Enabled $True
}
