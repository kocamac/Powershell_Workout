# Specify the path to the text file containing the list of usernames
$file_path = "C:\Path\To\UserList.txt"

# Specify the DistinguishedName of the OU to search within
$ouDN = "OU=BelirliOU,DC=contoso,DC=com" # OU yolunu güncelleyin

# Read the list of usernames from the file and remove Home Folder definitions for each user within the specified OU
Get-Content $file_path | ForEach-Object {
    $username = $_

    # Find the user within the specified OU
    $user = Get-ADUser -Filter {SamAccountName -eq $username} -SearchBase $ouDN

    if ($user) {
        # Remove the Home Folder attribute for the user
        Set-ADUser $user -HomeDrive $null -HomeDirectory $null
        Write-Host "Home Folder definition removed for user [$username]."
    } else {
        Write-Host "User [$username] not found within OU [$ouDN]."
    }
}
