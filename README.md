# Intune-Application-Deployment-SpeedUp-Testing
Predownload huge vendor setups ( MSI, Setup.exe incl Data.Cab) to local disk

Creating SW packages for Intune application ( Win32App ) deployments may become time consuming if you have to package huge INTUNEWIN files.

Admin job (almost always)
- download SW source
- install once on a test unit
- Version 0.1
  - create your deployment script ( Install.PS1 / .CMD)
  - create intuneWin package    - takes several time
  - Upload to intune            - takes several time
  - Deploy
  - Download on client PC       - takes several time
  - Test
- Version 0.2
  - ....
  -  takes several time
  - ...
- Version 0.3
  - ....
 
 
Save time !!
- download the SW sources directly to any custom, local folder on the client
- --- do this only once
- --- if you use the original sources from setup vendor  ( original MSI, Setup.exe )
- Change your "Install.PS1 / .CMD"
-   if 'Setup file' exists     -> immedeately start setup with paramters
-   if 'Setup file' is missing -> start download of 'Setup file' and finally start setup with paramters

Benefit:
  - IntuneWin package has only a size of some KiloBytes
  - Download to client PC is much faster
  - testing v0.1
  - reengineering
  - testing v0.2
    
<img width="1627" height="476" alt="image" src="https://github.com/user-attachments/assets/f3f1b70d-a57b-4fb8-892b-a52dd2b898cf" />

<img width="901" height="353" alt="image" src="https://github.com/user-attachments/assets/da5a8434-665f-4a4e-9047-1df459c1d058" />
