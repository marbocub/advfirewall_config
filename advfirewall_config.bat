@echo off
rem ===================================================================
rem define
rem ===================================================================
set BROWSER_PORT="any"
set SSH_PORT="22"
set MOSH_PORT="60000-61000"

set PRIVATE_IP="10.0.0.0/8,172.16.0.0/12,192.168.0.0/16"
set MAIL_REMOTE_IP="any"
set IDM_REMOTE_IP="LOCALSUBNET"

rem ===================================================================
rem initializing
rem ===================================================================
netsh advfirewall reset
netsh advfirewall set allprofiles firewallpolicy blockinbound,blockoutbound

rem ===================================================================
rem setup and modifing pre-defined system rules
rem ===================================================================
rem inbound RDP
netsh advfirewall firewall set rule name="@FirewallAPI.dll,-28753" ^
      new enable=yes profile=private,domain
rem inbound RDP RemoteFX TCP
netsh advfirewall firewall set rule name="@FirewallAPI.dll,-28853" ^
      new enable=yes profile=private,domain
rem inbound RDP RemoteFX UDP
netsh advfirewall firewall set rule name="@RdpGroupPolicyExtension.dll,-101" ^
      new enable=yes profile=private,domain

rem outbound ICMPv4 echo
netsh advfirewall firewall set rule name="@FirewallAPI.dll,-28544" ^
      new enable=yes remoteip=any
rem outbound ICMPv6 echo
netsh advfirewall firewall set rule name="@FirewallAPI.dll,-28546" ^
      new enable=yes remoteip=any

rem outbound NB-Name
netsh advfirewall firewall set rule name="@FirewallAPI.dll,-28523" profile=private,public ^
      new remoteip=%PRIVATE_IP% profile=private enable=yes
rem outbound NB-Datagram
netsh advfirewall firewall set rule name="@FirewallAPI.dll,-28531" profile=private,public ^
      new remoteip=%PRIVATE_IP% profile=private enable=yes
rem outbound NB-Session
netsh advfirewall firewall set rule name="@FirewallAPI.dll,-28507" profile=private,public ^
      new remoteip=%PRIVATE_IP% profile=private enable=yes
rem outbound SMB
netsh advfirewall firewall set rule name="@FirewallAPI.dll,-28515" profile=private,public ^
      new remoteip=%PRIVATE_IP% profile=private enable=yes

rem ===================================================================
rem add application rules
rem ===================================================================
if defined ProgramFiles(x86) goto arch_check_exit
set ProgramFiles(x86)=%ProgramFiles%
:arch_check_exit

rem Windows services
call :AddRule "wuauserv" out TCP any "80,443"
call :AddRule "W32Time"  out UDP any "123"

rem Windows commands
call :AddRule "%SystemRoot%\system32\telnet.exe"   out TCP any any
call :AddRule "%SystemRoot%\system32\nslookup.exe" out TCP any 53
call :AddRule "%SystemRoot%\system32\nslookup.exe" out UDP any 53
call :AddRule "%SystemRoot%\system32\ftp.exe"      out TCP any 21
call :AddRule "%SystemRoot%\system32\ftp.exe"      in  TCP any 20
call :AddRule "%SystemRoot%\system32\mstsc.exe"    out TCP any 3389

rem iexplore
if "%PROCESSOR_ARCHITECTURE%" NEQ "AMD64" goto arch_not_amd64
call :AddRule "%ProgramFiles%\internet explorer\iexplore.exe"      out TCP any %BROWSER_PORT%
:arch_not_amd64
call :AddRule "%ProgramFiles(x86)%\internet explorer\iexplore.exe" out TCP any %BROWSER_PORT%

rem google chrome
call :AddRule "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" out TCP any %BROWSER_PORT%
call :AddRule "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe"      out TCP any %BROWSER_PORT%
call :AddRule "gupdate"  out TCP any "80,443"
call :AddRule "gupdatem" out TCP any "80,443"

rem thunderbird
call :AddRule "%ProgramFiles(x86)%\Mozilla Thunderbird\thunderbird.exe" ^
              out TCP %MAIL_REMOTE_IP% "25,587,465,110,995,143,993"

rem vlc
call :AddRule "%ProgramFiles(x86)%\VodeoLan\vlc.exe" out TCP any any
call :AddRule "%ProgramFiles(x86)%\VodeoLan\vlc.exe" out UDP any any

rem avast! Antivirus
call :AddRule "%ProgramFiles(x86)%\avast software\Avast\avastui.exe" out TCP any "80,443"
call :AddRule "avast! Antivirus" out TCP any any

rem ESET SmartSecurity
call :AddRule "%ProgramFiles(x86)%\ESET\ESET Smart Security\ekrn.exe" out TCP any "80,443,465,993"
call :AddRule "ekrn" out TCP any "80,443,465,993"

rem VirtualBox
call :AddRule "%ProgramFiles(x86)%\Oracle\VirtualBox\virtualbox.exe" out TCP any any
call :AddRule "%ProgramFiles(x86)%\Oracle\VirtualBox\virtualbox.exe" out UDP any any

rem cygwin commands
call :AddRule "%SystemDrive%\cygwin\etc\setup\setup.exe" out TCP any "21,80,443"
call :AddRule "%SystemDrive%\cygwin\bin\wget.exe"        out TCP any %BROWSER_PORT%
call :AddRule "%SystemDrive%\cygwin\bin\ssh.exe"         out TCP any %SSH_PORT%
call :AddRule "%SystemDrive%\cygwin\bin\scp.exe"         out TCP any %SSH_PORT%
call :AddRule "%SystemDrive%\cygwin\bin\slogin.exe"      out TCP any %SSH_PORT%
call :AddRule "%SystemDrive%\cygwin\bin\mosh.exe"        out TCP any %SSH_PORT%
call :AddRule "%SystemDrive%\cygwin\bin\mosh.exe"        out UDP any %MOSH_PORT%
call :AddRule "%SystemDrive%\cygwin\bin\svn.exe"         out TCP any "22,80,443"
call :AddRule "%SystemDrive%\cygwin\bin\git.exe"         out TCP any "22,80,443"
call :AddRule "%SystemDrive%\cygwin\lib\git-core\git-remote-ftp.exe"   out TCP any "21"
call :AddRule "%SystemDrive%\cygwin\lib\git-core\git-remote-ftps.exe"  out TCP any "990"
call :AddRule "%SystemDrive%\cygwin\lib\git-core\git-remote-http.exe"  out TCP any "80"
call :AddRule "%SystemDrive%\cygwin\lib\git-core\git-remote-https.exe" out TCP any "443"
call :AddRule "%SystemDrive%\cygwin\lib\git-core\git-remote.exe"       out TCP any "22,80,443"

rem afxupd
call :AddRule "%ProgramFiles(x86)%\afxw\afxwupd.exe" out TCP any "80,443"

rem idm
call :AddRule "%ProgramFiles(x86)%\idm\IDM.exe" out TCP %IDM_REMOTE_IP% "21"

rem ===================================================================
rem subroutine
rem 
rem usage:
rem   call :AddRule "fullpath\name.exe" out TCP address port
rem 
rem example:
rem   call :AddRule "%SystemRoot%\system32\telnet.exe" out TCP LOCALSUBNET 23
rem 
rem ===================================================================
goto subroutine_end

rem -------------------------------------------------------------------
:AddRule
if not EXIST %1 goto AddRule_service
@echo add outbound rule for %~n1%~x1
netsh advfirewall firewall add rule action=allow ^
      name="%~n1%~x1 %~3 %~4 %~5" ^
      program=%1 dir=%2 protocol=%3 remoteip=%4 remoteport=%5 
goto AddRule_end

:AddRule_service
sc qc %1 > nul
if ERRORLEVEL 1 goto AddRule_end
@echo add outbound rule for %~1 service
netsh advfirewall firewall add rule action=allow ^
      name="(service) %~1 %~3 %~4 %~5" ^
      service=%1 dir=%2 protocol=%3 remoteip=%4 remoteport=%5 
goto AddRule_end

:AddRule_end
exit /B

rem -------------------------------------------------------------------
:subroutine_end
pause
