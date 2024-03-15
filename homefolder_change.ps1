Import-Module ActiveDirectory

# OU yolu
$ouPath = "OU=users,DC=emea,DC=corpdir,DC=net"

# Home drive harfi ve eski/yeni yollar
$homeDriveLetter = "H:"
$oldPathStart = "\\E891H001.tr152.corpinttra.net\H01$\"
$newPathStart = "\\E891H001.tr891.corpinttra.net\H01$"

# Belirtilen OU altındaki tüm kullanıcıları al ve gerekli değişiklikleri yap
Get-ADUser -Filter * -SearchBase $ouPath -Properties HomeDirectory, HomeDrive | ForEach-Object {
    $user = $_
    $homeDirectory = $user.HomeDirectory

    # Eğer home drive H: ise ve eski yolu içeriyorsa
    if ($user.HomeDrive -eq $homeDriveLetter -and $homeDirectory.StartsWith($oldPathStart)) {
        # Yeni yol oluştur
        $newHomeDirectory = $homeDirectory -replace [regex]::Escape($oldPathStart), $newPathStart

        # Home directory'yi güncelle
        Set-ADUser $user -HomeDirectory $newHomeDirectory

        Write-Host "Güncellendi: $($user.SamAccountName) -> $newHomeDirectory"
    }
}
