[CmdletBinding()]
    Param(  [Parameter(Mandatory=$true)][String]$UriLink,
            [Parameter(Mandatory=$true)][String]$TargetFolder,
            [Parameter(Mandatory=$true)][String]$TargetFile )

    <#
       example:  usage via CMD shell  - or via CMD file

        @REM ##########################################################
        @REM #
        Set DellApplication=Dell-Device-Management-Agent
        @REM #
        @REM ##########################################################
        set DL_Link="https://clientperipherals.dell.com/DDMA/Windows/DellDeviceManagementAgent.SubAgent_25.09.0.336.exe"
        set DL_Folder="C:\ProgramData\Dell\Downloaded_Installations\%DellApplication%"
        set DL_File="DellDeviceManagementAgent.SubAgent_25.09.0.336.exe"
        PowerShell.exe -ExecutionPolicy ByPass -File C:\__B\PowerShell\DownloadFile_System.Net.webclient_CmdletBinding.ps1  -UriLink %DL_Link% -TargetFolder %DL_Folder% -TargetFile %DL_File%
        @Echo.
        @Echo  Download returned %errorlevel%
        @Echo.
        @REM -------------------------------------------------
        set DL_Link="https://clientperipherals.dell.com/DDMA/Windows/DellDeviceManagementAgent.SubAgent_25.06.0.8.exe"
        set DL_Folder="C:\ProgramData\Dell\Downloaded_Installations\%DellApplication%"
        set DL_File="DellDeviceManagementAgent.SubAgent_25.06.0.8.exe"
        PowerShell.exe -ExecutionPolicy ByPass -File C:\__B\PowerShell\DownloadFile_System.Net.webclient_CmdletBinding.ps1  -UriLink %DL_Link% -TargetFolder %DL_Folder% -TargetFile %DL_File%
        @Echo.
        @Echo  Download returned %errorlevel%
        @Echo.
        @REM -------------------------------------------------


        @REM ##########################################################
        @REM #
        Set DellApplication=Dell-Display-Peripheral-Manager
        @REM #
        @REM ##########################################################
        set DL_Link="https://dl.dell.com/FOLDER13376505M/1/DDPM-Setup_2.1.0.24.exe"
        set DL_Folder="C:\ProgramData\Dell\Downloaded_Installations\%DellApplication%"
        set DL_File="DDPM-Setup_2.1.0.24.exe"
        PowerShell.exe -ExecutionPolicy ByPass -File C:\__B\PowerShell\DownloadFile_System.Net.webclient_CmdletBinding.ps1  -UriLink %DL_Link% -TargetFolder %DL_Folder% -TargetFile %DL_File%
        @Echo.
        @Echo  Download returned %errorlevel%
        @Echo.
        @REM -------------------------------------------------
        set DL_Link="https://dl.dell.com/FOLDER13664507M/1/DDPM-Setup_2.1.2.12.exe"
        set DL_Folder="C:\ProgramData\Dell\Downloaded_Installations\%DellApplication%"
        set DL_File="DDPM-Setup_2.1.2.12.exe"
        PowerShell.exe -ExecutionPolicy ByPass -File C:\__B\PowerShell\DownloadFile_System.Net.webclient_CmdletBinding.ps1  -UriLink %DL_Link% -TargetFolder %DL_Folder% -TargetFile %DL_File%
        @Echo.
        @Echo  Download returned %errorlevel%
        @Echo.
        @REM -------------------------------------------------

        @REM ##########################################################
        @REM #
        Set DellApplication=Dell-Optimizer
        @REM #
        @REM ##########################################################
        set DL_Link="https://dl.dell.com/FOLDER13529075M/3/Dell-Optimizer-Application_G3TR8_WIN64_6.2.1.0_A00.EXE"
        set DL_Folder="C:\ProgramData\Dell\Downloaded_Installations\%DellApplication%"
        set DL_File="Dell-Optimizer-Application_G3TR8_WIN64_6.2.1.0_A00.EXE"
        PowerShell.exe -ExecutionPolicy ByPass -File C:\__B\PowerShell\DownloadFile_System.Net.webclient_CmdletBinding.ps1  -UriLink %DL_Link% -TargetFolder %DL_Folder% -TargetFile %DL_File%
        @Echo.
        @Echo  Download returned %errorlevel%
        @Echo.
        @REM -------------------------------------------------
        

    #>
    
    $FctName = "Download-File-System.Net.webclient() -"

    Write-Host "$FctName Parameter UriLink      ='$UriLink'"
    Write-Host "$FctName Parameter TargetFolder ='$TargetFolder'"
    Write-Host "$FctName Parameter TargetFile   ='$TargetFile'"

    $TargetFilePath = "$TargetFolder\$TargetFile"

    if (!(Test-Path $TargetFolder)){$newfolder = New-Item -Path $TargetFolder -ItemType Directory -Force}
    
    if (!(Test-Path $TargetFilePath)) 
        { 
        Write-Host "$FctName Downloading file from '$UriLink'" 
        Write-Host "$FctName Downloading file to   '$TargetFilePath'" 
        }
    else
        { 
        Write-Host "$FctName File already downloaded to '$TargetFilePath'" 
        Exit 0   
        }
    
    try {

        Write-Host "$FctName Downloading" 

        # (New-Object -TypeName 'System.Net.WebClient').DownloadFile($Url, $FileName)
        
        
        $DL = New-Object System.Net.webclient
        $DL.Headers['User-Agent'] = 'chrome';
        $DLResult = $DL.DownloadFile( $UriLink, $TargetFilePath )
        <#
                paramter for Invoke-Webrequest:

                if download started without  '-userAgent ([Microsoft.PowerShell.Commands.PSUserAgent]::Chrome)'  
                -> DELL server will refuse access / download
                -> System.Net.WebException: The remote server returned an error: (403) Forbidden.

                You don't have permission to access "https://dl.dell.com/FOLDER12702584M/3/Dell-ControlVault3-Driver-and-Firmware_G7K77_WIN64_5.15.10.14_A31_01.EXE" on this server.

                #>
        }
  #  catch [System.IO.IOException]

    catch 
        {
     
      #  Write-Host "'$($PSItem.Exception.InnerException)'"
        if ( $($PSItem.Exception.InnerException) -like "*The remote server returned an error: (403) Forbidden.*" )
            {
            Write-Host "`r`nRan into an issue: `r`n$($PSItem.ToString())`r`n" -ForegroundColor red
            Exit 5   
            }
        else
            {
            $result = $_.Exception.Response.GetResponseStream()
            $reader = New-Object System.IO.StreamReader($result)
            $reader.BaseStream.Position = 0
            $reader.DiscardBufferedData()
            $responseBody = $reader.ReadToEnd()
            $responseBody = $responseBody.Replace('&#45;','-')
            $responseBody = $responseBody.Replace('&#46;','.')
            $responseBody = $responseBody.Replace('&#47;','/')
            $responseBody = $responseBody.Replace('&#58;',':')
            $responseBody = $responseBody.Replace('&#95;','_')
            #  $responseBody 
            Write-Host "$FctName Download ERROR '$($_.Exception)'  `r`n"                       # System.Net.WebException: The remote server returned an error: (403) Forbidden.
            Write-Host "$FctName Download ERROR '$($_.Exception.Response.StatusCode)'  `r`n"   # 'Forbidden'  
            Write-Host "FctName Download ERROR '$($_.Exception.Message)'  `r`n"               # 'The remote server returned an error: (403) Forbidden.'  
            }
        }

    if (!(Test-Path $TargetFilePath))     
        { 
        Exit 1  
        }
    else                                  
        { 
        Write-Host "$FctName file is downloaded to '$TargetFilePath'"
        Exit 0    
        }
