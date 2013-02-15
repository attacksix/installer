::GoogleChromeStandaloneEnterprise.msi
::AdbeRdr1010_en_US.msi
::mkdir c:\tca
::copy tca_logo.ico c:\tca

@echo off
ver | findstr /i "5\.1\." > nul
if %ERRORLEVEL% == 0 goto ver_xp

ver | findstr /i "6\.1\." > nul
if %ERRORLEVEL% == 0 goto ver_7

goto exit
		
:ver_xp
echo "Windows XP install"
copy /Y TotalCareAuto.lnk "c:\Documents and Settings\All Users\Desktop"
copy /Y TotalCareAuto.lnk "c:\Documents and Settings\All Users\Start Menu"
goto exit

:ver_7
echo "Windows 7 install"
if "%username%" == "Administrator" (set deskpath="c:\Users\Public\Desktop\") else (set deskpath="%USERPROFILE%\Desktop\")
copy /Y TotalCareAuto.7.lnk "%deskpath%"
rename "%deskpath%TotalCareAuto.7.lnk" TotalCareAuto.lnk
if "%username%" == "Administrator" (set startpath="c:\ProgramData\") else (set startpath="%UserProfile%\AppData\Roaming\")
copy /Y TotalCareAuto.7.lnk "%startpath%Microsoft\Windows\Start Menu\"
rename "%startpath%Microsoft\Windows\Start Menu\TotalCareAuto.7.lnk" TotalCareAuto.lnk
goto exit

:exit
@echo on
