# Part 2 of 3 in getting a Domain Controller set up for my home lab
# This step is to set up the network configs on the virtual DC
# Prior to proceeding, Windows Server must be installed on the DC

# Set the static IP and the default gateway on the DC
New-NetIPAddress -IPAddress 192.168.50.10 -PrefixLength 24 -DefaultGateway 192.168.50.1 -InterfaceAlias "Ethernet"

# Set the DNS
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 1.1.1.1
# Used 1.1.1.1 as the dnsserveraddress for the interim until AD DS and DNS can be properly set up

# Confirm network configs on the DC
ping 192.168.50.1 
ping 8.8.8.8 
ping google.com