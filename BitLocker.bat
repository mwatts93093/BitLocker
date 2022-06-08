:: AIS BitLocker Script
pushd %~dp0

diskpart /s listvol.txt
@echo "What drive letter do you wish to encrypt with BitLocker?
@set /p Drive="Enter drive letter for your OS drive(like C:) 

@manage-bde -on %Drive% -recoverypassword
GOTO Question


:Question
@echo "Do you need to encrypt an additional drive?
@set /p answer=Y/N: 
@if /i "%answer:~,1%" EQU "Y" GOTO DATA
@if /i "%answer:~,1%" EQU "N" GOTO END

:DATA
diskpart /s listvol.txt
@echo "What drive letter do you wish to encrypt with BitLocker?
@set /p Drive="Enter drive letter for your DATA drive(like D:) 

@manage-bde -on %Drive% -recoverypassword -recoverykey C:\AIS_Admin\Key
@manage-bde -autounlock -enable %Drive%

:END
popd
@echo "You need to reboot as soon as possible to initialize BitLocker.
@echo "When the system comes back up, you can run the manage-bde -status command to check for completion."