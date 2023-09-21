# Active Directory modülünü yükle
Import-Module ActiveDirectory

# Kullanıcı adlarını dosyadan oku
$kullaniciListesi = Get-Content -Path "C:\yol\kullanicilar.txt"

# Sonuçları saklamak için bir array oluştur
$sonuclar = @()

foreach ($kullanici in $kullaniciListesi) {
    # Kullanıcıyı Active Directory'den sorgula
    $adKullanici = Get-ADUser -Filter "SamAccountName -eq '$kullanici'" -Properties GivenName, Surname

    # Kullanıcıyı bulduysak sonuçlara ekle
    if ($adKullanici) {
        $sonuclar += "$($adKullanici.SamAccountName);$($adKullanici.GivenName) $($adKullanici.Surname)"
    }
}

# Sonuçları bir dosyaya yaz
$sonuclar | Out-File -Path "C:\yol\sonuclar.txt" -Encoding UTF8

Write-Host "İşlem tamamlandı!"
