Name "test_dl"
OutFile "test_dl.exe"

!include "MUI.nsh"

!insertmacro MUI_LANGUAGE "French"
!insertmacro MUI_LANGUAGE "English"

!include "nsisdl.nsh"

section
!insertmacro NSISDLSMOOTH_DOWNLOAD http://www.dog-cie.com/map%20obj/dmarena-towers.pk3 "C:\[TDM] arena-towers"
rename "C:\[TDM] arena-towers"  "dmarena-towers.pk3"
sectionend

