# RaspberryPiAutoConfig
A shell script to automatically configure a Raspberry Pi (Raspbian) without manual login

Purpose:
To allow basic configuration of a Raspberry Pi (especially ssh keys) without 
interaction. This is mainly useful when you have lots of pis to confgure, or 
if you regularly reinstall a pi from scratch.

The script will:
 - log in to the pi using ssh with the default password for the 'pi' user.
 - copy an ssh public key from the host to the pi user.
 - create a new user on the pi with the same username as the user that invoked 
   the script.

Assumptions:
 - you know the DNS name or IP address of the pi.
 - the pi is a standard Rasbian install with:
     a) ssh enabled
     b) the user 'pi's password set to the default - raspberry

Security Considerations:
 - Ordinarily the use fo sshpass in a script would be frowned upon as it's
   insecure. In this instance, the default user/password on the pi is very 
   much public knowledge. 
 - The use of ssh-keyscan could be considered insecure but this script is 
   designed to be used in a controlled development LAN where man-in-the-middle
   attacks are not a practical concern.

Future enhancements:
 - if the script is called without a parameter it could scan the local subnet
   for MAC addresses that match the Rasberry Pi range(es) and present these as
   a list with IP address.

