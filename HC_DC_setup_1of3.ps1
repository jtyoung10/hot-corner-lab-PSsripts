# Part 1 of 3 in getting a Domain Controller set up for my home lab
# This step is to create an internal switch on my host computer

# Create an internal switch
New-VMSwitch -Name "HCDC01" -SwitchType Internal

# Give the host's virtual adapter the default gateway address
New-NetIPAddress -IPAddress 192.168.50.1 -PrefixLength 24 -InterfaceAlias "vEthernet (HCDC01)"

# Create the NAT
New-NetNat -Name "LabNAT" -InternalIPInterfaceAddressPrefix 192.168.50.0/24

#Verify configs on the host machine
Get-VMSwitch -Name "LabSwitch" 
Get-NetIPAddress -InterfaceAlias "vEthernet (LabSwitch)" 
Get-NetNat