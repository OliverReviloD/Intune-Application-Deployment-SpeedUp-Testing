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
- Change your "Install.PS1 / .CMD"
-   if 'Setup file' exists     -> immedeately start setup with paramters
-   if 'Setup file' os missing -> start download of 'Setup file' and finally start setup with paramters

Benefit:
  - IntuneWin package has only a size of some KiloBytes
  - Download to client PC is much faster
  - testing v0.1
  - reengineering
  - testing v0.2
    
