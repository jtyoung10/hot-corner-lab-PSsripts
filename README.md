I used Hyper-V Manager to create a home lab

I first created a virtual machine, using Windows Server 2022 as the operating system. I then used PowerShell to create an internal switch, configure NAT, assign a static IP address to the VM, and promote the VM to the Domain Controller for my lab.
See HC_DC_setup .ps1 files for the code that was used

The IP address range was chosen because it was a private range and because it did not overlap with my home subnet. The default gateway ends in .1, since that is typical in real-world environments, and the static IP for the DC is .10, which is just easy to remember.

AD_UserImport.ps1 was the code used to create 100 users in my domain. I used Google Gemini to generate a list of names and job titles, based on departments that I predetermined. 
