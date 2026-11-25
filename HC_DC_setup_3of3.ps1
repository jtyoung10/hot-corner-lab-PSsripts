# Part 3 of 3 in getting a Domain Controller set up for my home lab
# This step is to promote the VM to the Domain Controller

# Optional - confirm prereqs of the VM
hostname 
Get-NetIpConfiguration

# Install AD DS role
Install-WindowsFeature AD-Domain-Services –IncludeManagementTools

# Promote the VM to a DC
Install-ADDSForest -DomainName "hotcorner.lab.com" -DomainNetbiosName "LAB" -InstallDns -SafeModeAdministratorPassword (Read-Host -AsSecureString "DSRM password")
# At the DSRM prompt, enter a secure password
# The VM will reboot on its own

# Point the DNS at the DC itself
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 192.168.50.10

# Add a DNS forwarder
Add-DnsServerForwarder -IPAddress 1.1.1.1 
Clear-DnsServerCache -Force 