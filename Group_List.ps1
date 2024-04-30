# Grup adını girin
$GroupName = "KullanıcıGrubuAdı"

# Grup üyelerini getir
$GroupMembers = Get-ADGroupMember -Identity $GroupName -Recursive | Get-ADUser -Property *

# CSV dosyasına çıkar
$GroupMembers | Select-Object Name, SamAccountName, Enabled, EmailAddress, Department | Export-Csv -Path "C:\path\to\output.csv" -NoTypeInformation

# Başarı mesajı
Write-Host "CSV dosyası başarıyla oluşturuldu: C:\path\to\output.csv"
