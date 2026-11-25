Import-Module ActiveDirectory

$csvPath   = "C:\Users\Administrator\Downloads\Hot Corner users.csv"
$domain    = "hotcorner.lab.com"
$baseOU    = "OU=Locations,DC=hotcorner,DC=lab,DC=com" 

$users = Import-Csv -Path $csvPath

foreach ($u in $users) {
    # Skip if the account already exists
    if (Get-ADUser -Filter "SamAccountName -eq '$($u.samaccountname)'" -ErrorAction SilentlyContinue) {
        Write-Warning "Skipping $($u.samaccountname): already exists"
        continue
    }

$securePwd = ConvertTo-SecureString $u.initial_password -AsPlainText -Force    

    $params = @{
        Name                  = "$($u.first_name) $($u.last_name)"
        GivenName             = $u.first_name
        Surname               = $u.last_name
        DisplayName           = "$($u.first_name) $($u.last_name)"
        SamAccountName        = $u.samaccountname
        UserPrincipalName     = "$($u.samaccountname)@$domain"
        EmailAddress          = $u.email
        Office                = $u.location
        Title                 = $u.title
        Description           = $u.title
        Department            = $u.department
        Path                  = "OU=$($u.location),$baseOU"
        AccountPassword       = $securePwd
        Enabled               = $true
        ChangePasswordAtLogon = $false  # for the sake of my lab, password change not required. Would change to $true if in a real-world setting
    }

    try {
        New-ADUser @params -ErrorAction Stop
        Write-Host "$($u.first_name) $($u.last_name) successfully created" -ForegroundColor Green
    }
    catch {
        Write-Warning "Failed on $($u.samaccountname): $($_.Exception.Message)"
    }
}