SetCompressor /FINAL /SOLID bzip2
OutFile "Ultime Pack Maps DMW.exe"
icon "${NSISDIR}\Contrib\Graphics\UltraModernUI\Icon.ico"
;NSIS Modern User Interface
;Basic Example Script
;Written by Joost Verburg

;--------------------------------
;Include Modern UI
  
  !include "UMUI.nsh"
  !include "LogicLib.nsh"
  !include "Sections.nsh"
  !include "${NSISDIR}\Contrib\UltraModernUI\Skins\green.nsh"
;--------------------------------
;General

  ;Name and file
  !define VERSION "2.1.0.0"
  
  VIProductVersion "${VERSION}"
  VIAddVersionKey "Comments" "Web Site : www.ultime-pack.com"
  VIAddVersionKey "CompanyName" "[Dog-Cie] Paco{112}"
  VIAddVersionKey "LegalCopyright" "© BRAULT François"
  VIAddVersionKey "FileDescription" "Certified by DMW"
  VIAddVersionKey "FileVersion" "${VERSION}"

  Name "Ultime Pack Maps DMW v2"
  BrandingText "[Dog-Cie] Paco{112}"
  
  ;Default installation folder

  InstallDir "$PROGRAMFILES\EA GAMES\MOHAA\main"
  InstallDirRegKey HKLM "Software\Ultime_Pack_Maps_DMW" "MAIN"
  

			 		
;--------------------------------

;Interface Settings

!define MUI_CUSTOMFUNCTION_ABORT "leave"
  !define MUI_ABORTWARNING
  
  !define MUI_COMPONENTSPAGE_NODESC
  !define MUI_CUSTOMFUNCTION_GUIINIT myGUIInit
  !define MUI_HEADERIMAGE
  



;--------------------------------
;Pages

    !define MUI_PAGE_CUSTOMFUNCTION_LEAVE "validateDirectory"
    !insertmacro MUI_PAGE_DIRECTORY
    !define MUI_PAGE_CUSTOMFUNCTION_PRE "PreComponents"

    !insertmacro MUI_PAGE_COMPONENTS
    !insertmacro MUI_PAGE_INSTFILES


	!define MUI_FINISHPAGE_LINK ".:: Official Web Site ::.  www.ultime-pack.com  .:: Official Web Site ::."
       	!define MUI_FINISHPAGE_LINK_LOCATION "http://www.ultime-pack.com"

  !define MUI_PAGE_CUSTOMFUNCTION_LEAVE "leave"
  !insertmacro MUI_PAGE_FINISH



InstType "Maps Objectives"
InstType "Maps Team DeathMatch"
InstType "All Maps"
InstType "None (Aucune)"

Function leave

InetLoad::load "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=End" "$PROGRAMFILES\Ultime Pack Maps DMW\info.ini"
delete "$PROGRAMFILES\Ultime Pack Maps DMW\info.ini"

FunctionEnd

Function validateDirectory

IfFileExists "$INSTDIR\*.pk3" End

Abort
End:

FunctionEnd
;--------------------------------

Function VersionCompare
	!define VersionCompare `!insertmacro VersionCompareCall`
 
	!macro VersionCompareCall _VER1 _VER2 _RESULT
		Push `${_VER1}`
		Push `${_VER2}`
		Call VersionCompare
		Pop ${_RESULT}
	!macroend
 
	Exch $1
	Exch
	Exch $0
	Exch
	Push $2
	Push $3
	Push $4
	Push $5
	Push $6
	Push $7
 
	begin:
	StrCpy $2 -1
	IntOp $2 $2 + 1
	StrCpy $3 $0 1 $2
	StrCmp $3 '' +2
	StrCmp $3 '.' 0 -3
	StrCpy $4 $0 $2
	IntOp $2 $2 + 1
	StrCpy $0 $0 '' $2
 
	StrCpy $2 -1
	IntOp $2 $2 + 1
	StrCpy $3 $1 1 $2
	StrCmp $3 '' +2
	StrCmp $3 '.' 0 -3
	StrCpy $5 $1 $2
	IntOp $2 $2 + 1
	StrCpy $1 $1 '' $2
 
	StrCmp $4$5 '' equal
 
	StrCpy $6 -1
	IntOp $6 $6 + 1
	StrCpy $3 $4 1 $6
	StrCmp $3 '0' -2
	StrCmp $3 '' 0 +2
	StrCpy $4 0
 
	StrCpy $7 -1
	IntOp $7 $7 + 1
	StrCpy $3 $5 1 $7
	StrCmp $3 '0' -2
	StrCmp $3 '' 0 +2
	StrCpy $5 0
 
	StrCmp $4 0 0 +2
	StrCmp $5 0 begin newer2
	StrCmp $5 0 newer1
	IntCmp $6 $7 0 newer1 newer2
 
	StrCpy $4 '1$4'
	StrCpy $5 '1$5'
	IntCmp $4 $5 begin newer2 newer1
 
	equal:
	StrCpy $0 0
	goto end
	newer1:
	StrCpy $0 1
	goto end
	newer2:
	StrCpy $0 2
 
	end:
	Pop $7
	Pop $6
	Pop $5
	Pop $4
	Pop $3
	Pop $2
	Pop $1
	Exch $0
FunctionEnd

;--------------------------------
;Languages
  
  !insertmacro MUI_LANGUAGE "English_Map"
  !insertmacro MUI_LANGUAGE "French_Map"

!include "nsisdl.nsh"
  
;--------------------------------

Function .onInit

; minimize all fenetres

    FindWindow $0 "Shell_TrayWnd"
    SendMessage $0 ${WM_COMMAND} 415 0

InitPluginsDir

CreateDirectory "$PROGRAMFILES\Ultime Pack Maps DMW\"

File "/oname=$TEMP\fantasyvirtual.jpg" "fantasyvirtual.jpg"

File "/oname=$PROGRAMFILES\Ultime Pack Maps DMW\logo.gif" "logo.gif"
newadvsplash::show /NOUNLOAD 2000 1000 500 -2 /BANNER "$PROGRAMFILES\Ultime Pack Maps DMW\logo.gif"


ReadRegStr $1 HKCU "Software\2015\MOHAA" "basepath"
WriteRegStr HKLM "Software\Ultime_Pack_Maps_DMW" "MAIN" $1\MAIN
ReadRegStr $INSTDIR HKLM "Software\Ultime_Pack_Maps_DMW" "MAIN"


CopyFiles /SILENT "$EXEDIR\Ultime Pack Maps DMW.exe" "$PROGRAMFILES\Ultime Pack Maps DMW\Ultime Pack Maps DMW.exe"
CreateShortCut "$SMPROGRAMS\Ultime Pack Maps DMW.lnk" "$PROGRAMFILES\Ultime Pack Maps DMW\Ultime Pack Maps DMW.exe"
CreateShortCut "$DESKTOP\Ultime Pack Maps DMW.lnk" "$PROGRAMFILES\Ultime Pack Maps DMW\Ultime Pack Maps DMW.exe"

ifFileExists "$PROGRAMFILES\Ultime Pack Maps DMW\skinnedbutton.dll" yes
File "/oname=$PROGRAMFILES\Ultime Pack Maps DMW\skinnedbutton.dll" "skinnedbutton.dll"

yes:
ifFileExists "$PROGRAMFILES\Ultime Pack Maps DMW\Update.exe" yes1
File "/oname=$PROGRAMFILES\Ultime Pack Maps DMW\Update.exe" "Update.exe"

yes1:

delete "$DESKTOP\Ultime Pack Maps DMW.exe"

   
InetLoad::load "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=info" "$PROGRAMFILES\Ultime Pack Maps DMW\info.ini"
ifFileExists "$PROGRAMFILES\Ultime Pack Maps DMW\info.ini" yes2
MessageBox MB_OK "Unable to connect on www.ultime-pack.com Please try later !"
quit
yes2:
ReadINIStr $0 "$PROGRAMFILES\Ultime Pack Maps DMW\info.ini" "Info" "version"

${VersionCompare} "${VERSION}" "$0" "$R0"

${If} $R0 = 0

sleep 1500
newadvsplash::stop

goto End

${else}

ExecWait "$PROGRAMFILES\Ultime Pack Maps DMW\Update.exe"

End:
delete "$PROGRAMFILES\Ultime Pack Maps DMW\info.ini"
${EndIf}


File "/oname=$PROGRAMFILES\Ultime Pack Maps DMW\button.bmp" "${NSISDIR}\Contrib\skinnedbutton\skins\ishield.bmp"

InetLoad::load "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/online.php" ""

FunctionEnd

Function myGUIInit


Push "$PROGRAMFILES\Ultime Pack Maps DMW\button.bmp"
CallInstDLL "$PROGRAMFILES\Ultime Pack Maps DMW\skinnedbutton.dll" /NOUNLOAD skinit
	
  Pop $0
  StrCmp $0 "success" noerror
    MessageBox MB_ICONEXCLAMATION|MB_OK "skinned button error: $0"
  noerror:


  
FunctionEnd

Function PreComponents

WriteRegStr HKLM "Software\Ultime_Pack_Maps_DMW" "MAIN" "$INSTDIR"

 
 
 
ifFileExists "$DESKTOP\Pk3 Manager.exe" "Y0" "N0"

Y0:

  SectionSetFlags 0 0

  SectionSetText 0 ""

  Goto N0

N0:	   
ifFileExists "$INSTDIR\BA_skin_pack1.*k3" "Y1" "N1"

Y1:

  SectionSetFlags 1 0

  SectionSetText 1 ""

  Goto N1

N1:
ifFileExists "$INSTDIR\User - Aarschot Obj.*k3" "Y2" "N2"

Y2:

  SectionSetFlags 2 0

  SectionSetText 2 ""

  Goto N2

N2:	   
ifFileExists "$INSTDIR\VSUK-AbbeyBeta.*k3" "Y3" "N3"

Y3:

  SectionSetFlags 3 0

  SectionSetText 3 ""

  Goto N3

N3:	   
ifFileExists "$INSTDIR\africannights_obj.*k3" "Y4" "N4"

Y4:

  SectionSetFlags 4 0

  SectionSetText 4 ""

  Goto N4

N4:	   
ifFileExists "$INSTDIR\User-Aftermath.*k3" "Y5" "N5"

Y5:

  SectionSetFlags 5 0

  SectionSetText 5 ""

  Goto N5

N5:	   
ifFileExists "$INSTDIR\Angryfields.*k3" "Y6" "N6"

Y6:

  SectionSetFlags 6 0

  SectionSetText 6 ""

  Goto N6

N6:	   
ifFileExists "$INSTDIR\user-ARG-Hunt.*k3" "Y7" "N7"

Y7:

  SectionSetFlags 7 0

  SectionSetText 7 ""

  Goto N7

N7:	   
ifFileExists "$INSTDIR\user-ARG- Las Chotas v2.0 Obj.*k3" "Y8" "N8"

Y8:

  SectionSetFlags 8 0

  SectionSetText 8 ""

  Goto N8

N8:	   
ifFileExists "$INSTDIR\assault77.*k3" "Y9" "N9"

Y9:

  SectionSetFlags 9 0

  SectionSetText 9 ""

  Goto N9

N9:	   
ifFileExists "$INSTDIR\BA_stalingrad.*k3" "Y10" "N10"

Y10:

  SectionSetFlags 10 0

  SectionSetText 10 ""

  Goto N10

N10:	   
ifFileExists "$INSTDIR\obj_bahnhof_steinhude_1939.*k3" "Y11" "N11"

Y11:

  SectionSetFlags 11 0

  SectionSetText 11 ""

  Goto N11

N11:	   
ifFileExists "$INSTDIR\User-bazaar.*k3" "Y12" "N12"

Y12:

  SectionSetFlags 12 0

  SectionSetText 12 ""

  Goto N12

N12:	   
ifFileExists "$INSTDIR\user-obj_canal.*k3" "Y13" "N13"

Y13:

  SectionSetFlags 13 0

  SectionSetText 13 ""

  Goto N13

N13:	   
ifFileExists "$INSTDIR\User - CapturedBase.*k3" "Y14" "N14"

Y14:

  SectionSetFlags 14 0

  SectionSetText 14 ""

  Goto N14

N14:	   
ifFileExists "$INSTDIR\User-dasboot.*k3" "Y15" "N15"

Y15:

  SectionSetFlags 15 0

  SectionSetText 15 ""

  Goto N15

N15:	   
ifFileExists "$INSTDIR\user-objdesertbase_final.*k3" "Y16" "N16"

Y16:

  SectionSetFlags 16 0

  SectionSetText 16 ""

  Goto N16

N16:	   
ifFileExists "$INSTDIR\User-Desert-Assault.*k3" "Y17" "N17"

Y17:

  SectionSetFlags 17 0

  SectionSetText 17 ""

  Goto N17

N17:	   
ifFileExists "$INSTDIR\User-Despair.*k3" "Y18" "N18"

Y18:

  SectionSetFlags 18 0

  SectionSetText 18 ""

  Goto N18

N18:	   
ifFileExists "$INSTDIR\dmga2.*k3" "Y19" "N19"

Y19:

  SectionSetFlags 19 0

  SectionSetText 19 ""

  Goto N19

N19:	   
ifFileExists "$INSTDIR\User-Eaglesnest-Final.*k3" "Y20" "N20"

Y20:

  SectionSetFlags 20 0

  SectionSetText 20 ""

  Goto N20

N20:	   
ifFileExists "$INSTDIR\user-eder.*k3" "Y21" "N21"

Y21:

  SectionSetFlags 21 0

  SectionSetText 21 ""

  Goto N21

N21:	   
ifFileExists "$INSTDIR\User-obj_FallenVillage.*k3" "Y22" "N22"

Y22:

  SectionSetFlags 22 0

  SectionSetText 22 ""

  Goto N22

N22:	   
ifFileExists "$INSTDIR\fortwreck.*k3" "Y23" "N23"

Y23:

  SectionSetFlags 23 0

  SectionSetText 23 ""

  Goto N23

N23:	   
ifFileExists "$INSTDIR\gloomcove.*k3" "Y24" "N24"

Y24:

  SectionSetFlags 24 0

  SectionSetText 24 ""

  Goto N24

N24:	   
ifFileExists "$INSTDIR\User-Greece_1943_SP.*k3" "Y25" "N25"

Y25:

  SectionSetFlags 25 0

  SectionSetText 25 ""

  Goto N25

N25:	   
ifFileExists "$INSTDIR\obj_howitzer_v1.*k3" "Y26" "N26"

Y26:

  SectionSetFlags 26 0

  SectionSetText 26 ""

  Goto N26

N26:	   
ifFileExists "$INSTDIR\obj_Kasbah.*k3" "Y27" "N27"

Y27:

  SectionSetFlags 27 0

  SectionSetText 27 ""

  Goto N27

N27:	   
ifFileExists "$INSTDIR\ZzZ_User_La_patrouille_2(all_version).*k3" "Y28" "N28"

Y28:

  SectionSetFlags 28 0

  SectionSetText 28 ""

  Goto N28

N28:	   
ifFileExists "$INSTDIR\user_labeuze.*k3" "Y29" "N29"

Y29:

  SectionSetFlags 29 0

  SectionSetText 29 ""

  Goto N29

N29:	   
ifFileExists "$INSTDIR\User_Laboratory.*k3" "Y30" "N30"

Y30:

  SectionSetFlags 30 0

  SectionSetText 30 ""

  Goto N30

N30:	   
ifFileExists "$INSTDIR\user-Las Chotas.*k3" "Y31" "N31"

Y31:

  SectionSetFlags 31 0

  SectionSetText 31 ""

  Goto N31

N31:	   
ifFileExists "$INSTDIR\user-obj_lastcastle.*k3" "Y32" "N32"

Y32:

  SectionSetFlags 32 0

  SectionSetText 32 ""

  Goto N32

N32:	   
ifFileExists "$INSTDIR\User_Letzte_Tage.*k3" "Y33" "N33"

Y33:

  SectionSetFlags 33 0

  SectionSetText 33 ""

  Goto N33

N33:	   
ifFileExists "$INSTDIR\lol_clifftop.*k3" "Y34" "N34"

Y34:

  SectionSetFlags 34 0

  SectionSetText 34 ""

  Goto N34

N34:	   
ifFileExists "$INSTDIR\lol_v2_new_3.*k3" "Y35" "N35"

Y35:

  SectionSetFlags 35 0

  SectionSetText 35 ""

  Goto N35

N35:	   
ifFileExists "$INSTDIR\User-obj_maromg.*k3" "Y36" "N36"

Y36:

  SectionSetFlags 36 0

  SectionSetText 36 ""

  Goto N36

N36:	   
ifFileExists "$INSTDIR\obj_marseille_v1_6.*k3" "Y37" "N37"

Y37:

  SectionSetFlags 37 0

  SectionSetText 37 ""

  Goto N37

N37:	   
ifFileExists "$INSTDIR\monastere.*k3" "Y38" "N38"

Y38:

  SectionSetFlags 38 0

  SectionSetText 38 ""

  Goto N38

N38:	   
ifFileExists "$INSTDIR\OpCenter_obj.*k3" "Y39" "N39"

Y39:

  SectionSetFlags 39 0

  SectionSetText 39 ""

  Goto N39

N39:	   
ifFileExists "$INSTDIR\Opra.*k3" "Y40" "N40"

Y40:

  SectionSetFlags 40 0

  SectionSetText 40 ""

  Goto N40

N40:	   
ifFileExists "$INSTDIR\push_cityhall.*k3" "Y41" "N41"

Y41:

  SectionSetFlags 41 0

  SectionSetText 41 ""

  Goto N41

N41:	   
ifFileExists "$INSTDIR\user_resistance.*k3" "Y42" "N42"

Y42:

  SectionSetFlags 42 0

  SectionSetText 42 ""

  Goto N42

N42:	   
ifFileExists "$INSTDIR\objdm_rockbound_aa.*k3" "Y43" "N43"

Y43:

  SectionSetFlags 43 0

  SectionSetText 43 ""

  Goto N43

N43:	   
ifFileExists "$INSTDIR\Schplatzburg_obj.*k3" "Y44" "N44"

Y44:

  SectionSetFlags 44 0

  SectionSetText 44 ""

  Goto N44

N44:	   
ifFileExists "$INSTDIR\user-Snow_Camp.*k3" "Y45" "N45"

Y45:

  SectionSetFlags 45 0

  SectionSetText 45 ""

  Goto N45

N45:	   
ifFileExists "$INSTDIR\User-Stlo.*k3" "Y46" "N46"

Y46:

  SectionSetFlags 46 0

  SectionSetText 46 ""

  Goto N46

N46:	   
ifFileExists "$INSTDIR\Kmarzo-St Renan.*k3" "Y47" "N47"

Y47:

  SectionSetFlags 47 0

  SectionSetText 47 ""

  Goto N47

N47:	   
ifFileExists "$INSTDIR\stalingrad1942.*k3" "Y48" "N48"

Y48:

  SectionSetFlags 48 0

  SectionSetText 48 ""

  Goto N48

N48:	   
ifFileExists "$INSTDIR\Stalingrad_3.*k3" "Y49" "N49"

Y49:

  SectionSetFlags 49 0

  SectionSetText 49 ""

  Goto N49

N49:	   
ifFileExists "$INSTDIR\user-swordbeach.*k3" "Y50" "N50"

Y50:

  SectionSetFlags 50 0

  SectionSetText 50 ""

  Goto N50

N50:	   
ifFileExists "$INSTDIR\user_obj_teamzero.*k3" "Y51" "N51"

Y51:

  SectionSetFlags 51 0

  SectionSetText 51 ""

  Goto N51

N51:	   
ifFileExists "$INSTDIR\the_cemetary.*k3" "Y52" "N52"

Y52:

  SectionSetFlags 52 0

  SectionSetText 52 ""

  Goto N52

N52:	   
ifFileExists "$INSTDIR\Obj_TheChurch_Final.*k3" "Y53" "N53"

Y53:

  SectionSetFlags 53 0

  SectionSetText 53 ""

  Goto N53

N53:	   
ifFileExists "$INSTDIR\User-TheLostVillage.*k3" "Y54" "N54"

Y54:

  SectionSetFlags 54 0

  SectionSetText 54 ""

  Goto N54

N54:	   
ifFileExists "$INSTDIR\TheVilla.*k3" "Y55" "N55"

Y55:

  SectionSetFlags 55 0

  SectionSetText 55 ""

  Goto N55

N55:	   
ifFileExists "$INSTDIR\Tirtagaine-KechtatIII.*k3" "Y56" "N56"

Y56:

  SectionSetFlags 56 0

  SectionSetText 56 ""

  Goto N56

N56:	   
ifFileExists "$INSTDIR\Under_Siege.*k3" "Y57" "N57"

Y57:

  SectionSetFlags 57 0

  SectionSetText 57 ""

  Goto N57

N57:	   
ifFileExists "$INSTDIR\V2Shelter.*k3" "Y58" "N58"

Y58:

  SectionSetFlags 58 0

  SectionSetText 58 ""

  Goto N58

N58:	   
ifFileExists "$INSTDIR\User-finalv3lab.*k3" "Y59" "N59"

Y59:

  SectionSetFlags 59 0

  SectionSetText 59 ""

  Goto N59

N59:	   
ifFileExists "$INSTDIR\wuesten-kaff-beta9.*k3" "Y60" "N60"

Y60:

  SectionSetFlags 60 0

  SectionSetText 60 ""

  Goto N60

N60:	   
ifFileExists "$INSTDIR\user-ydiss-objxfireville.*k3" "Y61" "N61"

Y61:

  SectionSetFlags 61 0

  SectionSetText 61 ""

  Goto N61

N61:	   
ifFileExists "$INSTDIR\africannightstdm.*k3" "Y62" "N62"

Y62:

  SectionSetFlags 62 0

  SectionSetText 62 ""

  Goto N62

N62:	   
ifFileExists "$INSTDIR\ammo_factory.*k3" "Y63" "N63"

Y63:

  SectionSetFlags 63 0

  SectionSetText 63 ""

  Goto N63

N63:	   
ifFileExists "$INSTDIR\Arnhem.*k3" "Y64" "N64"

Y64:

  SectionSetFlags 64 0

  SectionSetText 64 ""

  Goto N64

N64:	   
ifFileExists "$INSTDIR\bob_carentan.*k3" "Y65" "N65"

Y65:

  SectionSetFlags 65 0

  SectionSetText 65 ""

  Goto N65

N65:	   
ifFileExists "$INSTDIR\Map_AA_bombedv.*k3" "Y66" "N66"

Y66:

  SectionSetFlags 66 0

  SectionSetText 66 ""

  Goto N66

N66:	   
ifFileExists "$INSTDIR\User-Broken_Silence.*k3" "Y67" "N67"

Y67:

  SectionSetFlags 67 0

  SectionSetText 67 ""

  Goto N67

N67:	   
ifFileExists "$INSTDIR\BSunrise3-3.*k3" "Y68" "N68"

Y68:

  SectionSetFlags 68 0

  SectionSetText 68 ""

  Goto N68

N68:	   
ifFileExists "$INSTDIR\bullettrain.*k3" "Y69" "N69"

Y69:

  SectionSetFlags 69 0

  SectionSetText 69 ""

  Goto N69

N69:	   
ifFileExists "$INSTDIR\AR_Bunkeranlage_V1.*k3" "Y70" "N70"

Y70:

  SectionSetFlags 70 0

  SectionSetText 70 ""

  Goto N70

N70:	   
ifFileExists "$INSTDIR\User-CanalTown_V2.*k3" "Y71" "N71"

Y71:

  SectionSetFlags 71 0

  SectionSetText 71 ""

  Goto N71

N71:	   
ifFileExists "$INSTDIR\user-casablanca.*k3" "Y72" "N72"

Y72:

  SectionSetFlags 72 0

  SectionSetText 72 ""

  Goto N72

N72:	   
ifFileExists "$INSTDIR\communique.*k3" "Y73" "N73"

Y73:

  SectionSetFlags 73 0

  SectionSetText 73 ""

  Goto N73

N73:	   
ifFileExists "$INSTDIR\dm_dorf.*k3" "Y74" "N74"

Y74:

  SectionSetFlags 74 0

  SectionSetText 74 ""

  Goto N74

N74:	   
ifFileExists "$INSTDIR\dm_dorf14.*k3" "Y75" "N75"

Y75:

  SectionSetFlags 75 0

  SectionSetText 75 ""

  Goto N75

N75:	   
ifFileExists "$INSTDIR\duenkirchen.*k3" "Y76" "N76"

Y76:

  SectionSetFlags 76 0

  SectionSetText 76 ""

  Goto N76

N76:	   
ifFileExists "$INSTDIR\UserW5-MOHDust.*k3" "Y77" "N77"

Y77:

  SectionSetFlags 77 0

  SectionSetText 77 ""

  Goto N77

N77:	   
ifFileExists "$INSTDIR\User-dm_FallenVillage.*k3" "Y78" "N78"

Y78:

  SectionSetFlags 78 0

  SectionSetText 78 ""

  Goto N78

N78:	   
ifFileExists "$INSTDIR\user-Forschungslabor.*k3" "Y79" "N79"

Y79:

  SectionSetFlags 79 0

  SectionSetText 79 ""

  Goto N79

N79:	   
ifFileExists "$INSTDIR\SW_dm_Gatehouse_Assault.*k3" "Y80" "N80"

Y80:

  SectionSetFlags 80 0

  SectionSetText 80 ""

  Goto N80

N80:	   
ifFileExists "$INSTDIR\hitlersfarm.*k3" "Y81" "N81"

Y81:

  SectionSetFlags 81 0

  SectionSetText 81 ""

  Goto N81

N81:	   
ifFileExists "$INSTDIR\italy1.*k3" "Y82" "N82"

Y82:

  SectionSetFlags 82 0

  SectionSetText 82 ""

  Goto N82

N82:	   
ifFileExists "$INSTDIR\user-ARG- Las Chotas v2.0 DM.*k3" "Y83" "N83"

Y83:

  SectionSetFlags 83 0

  SectionSetText 83 ""

  Goto N83

N83:	   
ifFileExists "$INSTDIR\lastcastle1.*k3" "Y84" "N84"

Y84:

  SectionSetFlags 84 0

  SectionSetText 84 ""

  Goto N84

N84:	   
ifFileExists "$INSTDIR\military_post.*k3" "Y85" "N85"

Y85:

  SectionSetFlags 85 0

  SectionSetText 85 ""

  Goto N85

N85:	   
ifFileExists "$INSTDIR\user-morocco.*k3" "Y86" "N86"

Y86:

  SectionSetFlags 86 0

  SectionSetText 86 ""

  Goto N86

N86:	   
ifFileExists "$INSTDIR\User-tdm_needle.*k3" "Y87" "N87"

Y87:

  SectionSetFlags 87 0

  SectionSetText 87 ""

  Goto N87

N87:	   
ifFileExists "$INSTDIR\Dmarean-nightbattle.*k3" "Y88" "N88"

Y88:

  SectionSetFlags 88 0

  SectionSetText 88 ""

  Goto N88

N88:	   
ifFileExists "$INSTDIR\User-OperationSealion.*k3" "Y89" "N89"

Y89:

  SectionSetFlags 89 0

  SectionSetText 89 ""

  Goto N89

N89:	   
ifFileExists "$INSTDIR\Renverse.*k3" "Y90" "N90"

Y90:

  SectionSetFlags 90 0

  SectionSetText 90 ""

  Goto N90

N90:	   
ifFileExists "$INSTDIR\dm_routenord.*k3" "Y91" "N91"

Y91:

  SectionSetFlags 91 0

  SectionSetText 91 ""

  Goto N91

N91:	   
ifFileExists "$INSTDIR\User-MP_Sandsturm_DM.*k3" "Y92" "N92"

Y92:

  SectionSetFlags 92 0

  SectionSetText 92 ""

  Goto N92

N92:	   
ifFileExists "$INSTDIR\SmallCity.*k3" "Y93" "N93"

Y93:

  SectionSetFlags 93 0

  SectionSetText 93 ""

  Goto N93

N93:	   
ifFileExists "$INSTDIR\User-Stalingrad2Full.*k3" "Y94" "N94"

Y94:

  SectionSetFlags 94 0

  SectionSetText 94 ""

  Goto N94

N94:	   
ifFileExists "$INSTDIR\user-stalingradsnow.*k3" "Y95" "N95"

Y95:

  SectionSetFlags 95 0

  SectionSetText 95 ""

  Goto N95

N95:	   
ifFileExists "$INSTDIR\User-Kirby_Stalingrad_Unbound2.*k3" "Y96" "N96"

Y96:

  SectionSetFlags 96 0

  SectionSetText 96 ""

  Goto N96

N96:	   
ifFileExists "$INSTDIR\Strike_at_Dawn-Return To Algiers.*k3" "Y97" "N97"

Y97:

  SectionSetFlags 97 0

  SectionSetText 97 ""

  Goto N97

N97:	   
ifFileExists "$INSTDIR\the_overpass.*k3" "Y98" "N98"

Y98:

  SectionSetFlags 98 0

  SectionSetText 98 ""

  Goto N98

N98:	   
ifFileExists "$INSTDIR\dmarena-towers.*k3" "Y99" "N99"

Y99:

  SectionSetFlags 99 0

  SectionSetText 99 ""

  Goto N99

N99:	   
ifFileExists "$INSTDIR\toysoldiers.*k3" "Y100" "N100"

Y100:

  SectionSetFlags 100 0

  SectionSetText 100 ""

  Goto N100

N100:	   
ifFileExists "$INSTDIR\user-tunisian.*k3" "Y101" "N101"

Y101:

  SectionSetFlags 101 0

  SectionSetText 101 ""

  Goto N101

N101:	   
ifFileExists "$INSTDIR\user-tunisian_sh.*k3" "Y102" "N102"

Y102:

  SectionSetFlags 102 0

  SectionSetText 102 ""

  Goto N102

N102:	   
ifFileExists "$INSTDIR\ugcthorn_ak.*k3" "Y103" "N103"

Y103:

  SectionSetFlags 103 0

  SectionSetText 103 ""

  Goto N103

N103:	   
ifFileExists "$INSTDIR\urbansprawl.*k3" "Y104" "N104"

Y104:

  SectionSetFlags 104 0

  SectionSetText 104 ""

  Goto N104

N104:	   
ifFileExists "$INSTDIR\vervins.*k3" "Y105" "N105"

Y105:

  SectionSetFlags 105 0

  SectionSetText 105 ""

  Goto N105

N105:	   
ifFileExists "$INSTDIR\User_Watten_multi.*k3" "Y106" "N106"

Y106:

  SectionSetFlags 106 0

  SectionSetText 106 ""

  Goto N106

N106:	   
ifFileExists "$INSTDIR\Weihnachtsmarkt.*k3" "Y107" "N107"

Y107:

  SectionSetFlags 107 0

  SectionSetText 107 ""

  Goto N107

N107:	   
ifFileExists "$INSTDIR\User-MP_Winterschlaf_DM.*k3" "Y108" "N108"

Y108:

  SectionSetFlags 108 0

  SectionSetText 108 ""

  Goto N108

N108:	   
ifFileExists "$INSTDIR\user-ydiss-xfire.*k3" "Y109" "N109"

Y109:

  SectionSetFlags 109 0

  SectionSetText 109 ""

  Goto N109

N109:	   
ifFileExists "$INSTDIR\user-xfire2v2.*k3" "Y110" "N110"

Y110:

  SectionSetFlags 110 0

  SectionSetText 110 ""

  Goto N110

N110:
ifFileExists "$INSTDIR\farpointstorage.*k3" "Y2-1" "N2-1"

Y2-1:

  SectionSetFlags 111 0

  SectionSetText 111 ""

  Goto N2-1

N2-1:	 


FunctionEnd

 
 
Section "[Soft] Pk3 Manager"

SectionIn 3

IfFileExists "$DESKTOP\Pk3 Manager.exe" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=Pk3%20Manager" "$DESKTOP\[Soft] Pk3 Manager"

rename "$DESKTOP\[Soft] Pk3 Manager" "$DESKTOP\Pk3 Manager.exe"

ebanner::stop

end:

SectionEnd	   
Section "[Skin] DMW Pack"

SectionIn 3

IfFileExists "$INSTDIR\BA_skin_pack1.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=BA_skin_pack1" "$INSTDIR\[Skin] DMW Pack"

rename "$INSTDIR\[Skin] DMW Pack" "$INSTDIR\BA_skin_pack1.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Aarschot"

SectionIn 1 3



IfFileExists "$INSTDIR\User - Aarschot Obj.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User%20-%20Aarschot%20Obj" "$INSTDIR\[OBJ] Aarschot"

rename "$INSTDIR\[OBJ] Aarschot" "$INSTDIR\User - Aarschot Obj.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Abbey Beta"

SectionIn 1 3



IfFileExists "$INSTDIR\VSUK-AbbeyBeta.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=VSUK-AbbeyBeta" "$INSTDIR\[OBJ] Abbey Beta"

rename "$INSTDIR\[OBJ] Abbey Beta" "$INSTDIR\VSUK-AbbeyBeta.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] African nights"

SectionIn 1 3



IfFileExists "$INSTDIR\africannights_obj.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=africannights_obj" "$INSTDIR\[OBJ] African nights"

rename "$INSTDIR\[OBJ] African nights" "$INSTDIR\africannights_obj.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Aftermath"

SectionIn 1 3



IfFileExists "$INSTDIR\User-Aftermath.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User-Aftermath" "$INSTDIR\[OBJ] Aftermath"

rename "$INSTDIR\[OBJ] Aftermath" "$INSTDIR\User-Aftermath.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Angryfields"

SectionIn 1 3



IfFileExists "$INSTDIR\Angryfields.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=Angryfields" "$INSTDIR\[OBJ] Angryfields"

rename "$INSTDIR\[OBJ] Angryfields" "$INSTDIR\Angryfields.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] ARG Hunt"

SectionIn 1 3



IfFileExists "$INSTDIR\user-ARG-Hunt.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=user-ARG-Hunt" "$INSTDIR\[OBJ] ARG Hunt"

rename "$INSTDIR\[OBJ] ARG Hunt" "$INSTDIR\user-ARG-Hunt.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] ARG Las Chotas v2.0"

SectionIn 1 3



IfFileExists "$INSTDIR\user-ARG- Las Chotas v2.0 Obj.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=user-ARG-%20Las%20Chotas%20v2.0%20Obj" "$INSTDIR\[OBJ] ARG Las Chotas v2.0"

rename "$INSTDIR\[OBJ] ARG Las Chotas v2.0" "$INSTDIR\user-ARG- Las Chotas v2.0 Obj.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Assault 77"

SectionIn 1 3



IfFileExists "$INSTDIR\assault77.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=assault77" "$INSTDIR\[OBJ] Assault 77"

rename "$INSTDIR\[OBJ] Assault 77" "$INSTDIR\assault77.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] BA Stalingrad"

SectionIn 1 3



IfFileExists "$INSTDIR\BA_stalingrad.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=BA_stalingrad" "$INSTDIR\[OBJ] BA Stalingrad"

rename "$INSTDIR\[OBJ] BA Stalingrad" "$INSTDIR\BA_stalingrad.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Bahnhof steinhude 1939"

SectionIn 1 3



IfFileExists "$INSTDIR\obj_bahnhof_steinhude_1939.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=obj_bahnhof_steinhude_1939" "$INSTDIR\[OBJ] Bahnhof steinhude 1939"

rename "$INSTDIR\[OBJ] Bahnhof steinhude 1939" "$INSTDIR\obj_bahnhof_steinhude_1939.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Bazaar"

SectionIn 1 3



IfFileExists "$INSTDIR\User-bazaar.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User-bazaar" "$INSTDIR\[OBJ] Bazaar"

rename "$INSTDIR\[OBJ] Bazaar" "$INSTDIR\User-bazaar.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Canal"

SectionIn 1 3



IfFileExists "$INSTDIR\user-obj_canal.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=user-obj_canal" "$INSTDIR\[OBJ] Canal"

rename "$INSTDIR\[OBJ] Canal" "$INSTDIR\user-obj_canal.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Captured Base"

SectionIn 1 3



IfFileExists "$INSTDIR\User - CapturedBase.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User%20-%20CapturedBase" "$INSTDIR\[OBJ] Captured Base"

rename "$INSTDIR\[OBJ] Captured Base" "$INSTDIR\User - CapturedBase.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Dasboot"

SectionIn 1 3



IfFileExists "$INSTDIR\User-dasboot.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User-dasboot" "$INSTDIR\[OBJ] Dasboot"

rename "$INSTDIR\[OBJ] Dasboot" "$INSTDIR\User-dasboot.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Desert Base"

SectionIn 1 3



IfFileExists "$INSTDIR\user-objdesertbase_final.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=user-objdesertbase_final" "$INSTDIR\[OBJ] Desert Base"

rename "$INSTDIR\[OBJ] Desert Base" "$INSTDIR\user-objdesertbase_final.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Desert-Assault"

SectionIn 1 3



IfFileExists "$INSTDIR\User-Desert-Assault.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User-Desert-Assault" "$INSTDIR\[OBJ] Desert-Assault"

rename "$INSTDIR\[OBJ] Desert-Assault" "$INSTDIR\User-Desert-Assault.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Despair"

SectionIn 1 3



IfFileExists "$INSTDIR\User-Despair.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User-Despair" "$INSTDIR\[OBJ] Despair"

rename "$INSTDIR\[OBJ] Despair" "$INSTDIR\User-Despair.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] dmga2"

SectionIn 1 3



IfFileExists "$INSTDIR\dmga2.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=dmga2" "$INSTDIR\[OBJ] dmga2"

rename "$INSTDIR\[OBJ] dmga2" "$INSTDIR\dmga2.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Eaglesnest-Final"

SectionIn 1 3



IfFileExists "$INSTDIR\User-Eaglesnest-Final.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User-Eaglesnest-Final" "$INSTDIR\[OBJ] Eaglesnest-Final"

rename "$INSTDIR\[OBJ] Eaglesnest-Final" "$INSTDIR\User-Eaglesnest-Final.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Eder"

SectionIn 1 3



IfFileExists "$INSTDIR\user-eder.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=user-eder" "$INSTDIR\[OBJ] Eder"

rename "$INSTDIR\[OBJ] Eder" "$INSTDIR\user-eder.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Fallen Village"

SectionIn 1 3



IfFileExists "$INSTDIR\User-obj_FallenVillage.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User-obj_FallenVillage" "$INSTDIR\[OBJ] Fallen Village"

rename "$INSTDIR\[OBJ] Fallen Village" "$INSTDIR\User-obj_FallenVillage.pk3"

ebanner::stop

end:

SectionEnd

Section "[OBJ] Fortwreck"

SectionIn 1 3



IfFileExists "$INSTDIR\fortwreck.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=fortwreck" "$INSTDIR\[OBJ] Fortwreck"

rename "$INSTDIR\[OBJ] Fortwreck" "$INSTDIR\fortwreck.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Gloomcove"

SectionIn 1 3



IfFileExists "$INSTDIR\gloomcove.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=gloomcove" "$INSTDIR\[OBJ] Gloomcove"

rename "$INSTDIR\[OBJ] Gloomcove" "$INSTDIR\gloomcove.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Greece 1943"

SectionIn 1 3



IfFileExists "$INSTDIR\User-Greece_1943_SP.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User-Greece_1943_SP" "$INSTDIR\[OBJ] Greece 1943"

rename "$INSTDIR\[OBJ] Greece 1943" "$INSTDIR\User-Greece_1943_SP.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Howitzer"

SectionIn 1 3



IfFileExists "$INSTDIR\obj_howitzer_v1.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=obj_howitzer_v1" "$INSTDIR\[OBJ] Howitzer"

rename "$INSTDIR\[OBJ] Howitzer" "$INSTDIR\obj_howitzer_v1.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Kasbah"

SectionIn 1 3



IfFileExists "$INSTDIR\obj_Kasbah.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=obj_Kasbah" "$INSTDIR\[OBJ] Kasbah"

rename "$INSTDIR\[OBJ] Kasbah" "$INSTDIR\obj_Kasbah.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] La patrouille 2"

SectionIn 1 3



IfFileExists "$INSTDIR\ZzZ_User_La_patrouille_2(all_version).*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=ZzZ_User_La_patrouille_2(all_version)" "$INSTDIR\[OBJ] La patrouille 2"

rename "$INSTDIR\[OBJ] La patrouille 2" "$INSTDIR\ZzZ_User_La_patrouille_2(all_version).pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] labeuze"

SectionIn 1 3



IfFileExists "$INSTDIR\user_labeuze.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=user_labeuze" "$INSTDIR\[OBJ] labeuze"

rename "$INSTDIR\[OBJ] labeuze" "$INSTDIR\user_labeuze.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Laboratory"

SectionIn 1 3



IfFileExists "$INSTDIR\User_Laboratory.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User_Laboratory" "$INSTDIR\[OBJ] Laboratory"

rename "$INSTDIR\[OBJ] Laboratory" "$INSTDIR\User_Laboratory.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Las Chotas"

SectionIn 1 3



IfFileExists "$INSTDIR\user-Las Chotas.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=user-Las%20Chotas" "$INSTDIR\[OBJ] Las Chotas"

rename "$INSTDIR\[OBJ] Las Chotas" "$INSTDIR\user-Las Chotas.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Last castle"

SectionIn 1 3



IfFileExists "$INSTDIR\user-obj_lastcastle.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=user-obj_lastcastle" "$INSTDIR\[OBJ] Last castle"

rename "$INSTDIR\[OBJ] Last castle" "$INSTDIR\user-obj_lastcastle.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Letzte Tage"

SectionIn 1 3



IfFileExists "$INSTDIR\User_Letzte_Tage.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User_Letzte_Tage" "$INSTDIR\[OBJ] Letzte Tage"

rename "$INSTDIR\[OBJ] Letzte Tage" "$INSTDIR\User_Letzte_Tage.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] lol Clifftop"

SectionIn 1 3



IfFileExists "$INSTDIR\lol_clifftop.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=lol_clifftop" "$INSTDIR\[OBJ] lol Clifftop"

rename "$INSTDIR\[OBJ] lol Clifftop" "$INSTDIR\lol_clifftop.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] lol_v2"

SectionIn 1 3



IfFileExists "$INSTDIR\lol_v2_new_3.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=lol_v2_new_3" "$INSTDIR\[OBJ] lol_v2"

rename "$INSTDIR\[OBJ] lol_v2" "$INSTDIR\lol_v2_new_3.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Maromg"

SectionIn 1 3



IfFileExists "$INSTDIR\User-obj_maromg.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User-obj_maromg" "$INSTDIR\[OBJ] Maromg"

rename "$INSTDIR\[OBJ] Maromg" "$INSTDIR\User-obj_maromg.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Marseille"

SectionIn 1 3



IfFileExists "$INSTDIR\obj_marseille_v1_6.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=obj_marseille_v1_6" "$INSTDIR\[OBJ] Marseille"

rename "$INSTDIR\[OBJ] Marseille" "$INSTDIR\obj_marseille_v1_6.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Monastere"

SectionIn 1 3



IfFileExists "$INSTDIR\monastere.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=monastere" "$INSTDIR\[OBJ] Monastere"

rename "$INSTDIR\[OBJ] Monastere" "$INSTDIR\monastere.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] OpCenter"

SectionIn 1 3



IfFileExists "$INSTDIR\OpCenter_obj.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=OpCenter_obj" "$INSTDIR\[OBJ] OpCenter"

rename "$INSTDIR\[OBJ] OpCenter" "$INSTDIR\OpCenter_obj.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] OpreaHouse"

SectionIn 1 3



IfFileExists "$INSTDIR\Opra.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=Opra" "$INSTDIR\[OBJ] OpreaHouse"

rename "$INSTDIR\[OBJ] OpreaHouse" "$INSTDIR\Opra.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Push cityhall"

SectionIn 1 3



IfFileExists "$INSTDIR\push_cityhall.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=push_cityhall" "$INSTDIR\[OBJ] Push cityhall"

rename "$INSTDIR\[OBJ] Push cityhall" "$INSTDIR\push_cityhall.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Resistance"

SectionIn 1 3



IfFileExists "$INSTDIR\user_resistance.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=user_resistance" "$INSTDIR\[OBJ] Resistance"

rename "$INSTDIR\[OBJ] Resistance" "$INSTDIR\user_resistance.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Rockbound"

SectionIn 1 3



IfFileExists "$INSTDIR\objdm_rockbound_aa.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=objdm_rockbound_aa" "$INSTDIR\[OBJ] Rockbound"

rename "$INSTDIR\[OBJ] Rockbound" "$INSTDIR\objdm_rockbound_aa.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Schplatzburg"

SectionIn 1 3



IfFileExists "$INSTDIR\Schplatzburg_obj.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=Schplatzburg_obj" "$INSTDIR\[OBJ] Schplatzburg"

rename "$INSTDIR\[OBJ] Schplatzburg" "$INSTDIR\Schplatzburg_obj.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Snow Camp"

SectionIn 1 3



IfFileExists "$INSTDIR\user-Snow_Camp.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=user-Snow_Camp" "$INSTDIR\[OBJ] Snow Camp"

rename "$INSTDIR\[OBJ] Snow Camp" "$INSTDIR\user-Snow_Camp.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] St lo"

SectionIn 1 3



IfFileExists "$INSTDIR\User-Stlo.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User-Stlo" "$INSTDIR\[OBJ] St lo"

rename "$INSTDIR\[OBJ] St lo" "$INSTDIR\User-Stlo.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] St Renan"

SectionIn 1 3



IfFileExists "$INSTDIR\Kmarzo-St Renan.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=Kmarzo-St%20Renan" "$INSTDIR\[OBJ] St Renan"

rename "$INSTDIR\[OBJ] St Renan" "$INSTDIR\Kmarzo-St Renan.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] stalingrad 1942"

SectionIn 1 3



IfFileExists "$INSTDIR\stalingrad1942.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=stalingrad1942" "$INSTDIR\[OBJ] stalingrad 1942"

rename "$INSTDIR\[OBJ] stalingrad 1942" "$INSTDIR\stalingrad1942.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Stalingrad 3"

SectionIn 1 3



IfFileExists "$INSTDIR\Stalingrad_3.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=Stalingrad_3" "$INSTDIR\[OBJ] Stalingrad 3"

rename "$INSTDIR\[OBJ] Stalingrad 3" "$INSTDIR\Stalingrad_3.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Sword beach"

SectionIn 1 3



IfFileExists "$INSTDIR\user-swordbeach.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=user-swordbeach" "$INSTDIR\[OBJ] Sword beach"

rename "$INSTDIR\[OBJ] Sword beach" "$INSTDIR\user-swordbeach.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Teamzero"

SectionIn 1 3



IfFileExists "$INSTDIR\user_obj_teamzero.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=user_obj_teamzero" "$INSTDIR\[OBJ] Teamzero"

rename "$INSTDIR\[OBJ] Teamzero" "$INSTDIR\user_obj_teamzero.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] The cemetary"

SectionIn 1 3



IfFileExists "$INSTDIR\the_cemetary.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=the_cemetary" "$INSTDIR\[OBJ] The cemetary"

rename "$INSTDIR\[OBJ] The cemetary" "$INSTDIR\the_cemetary.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] The Church Final"

SectionIn 1 3



IfFileExists "$INSTDIR\Obj_TheChurch_Final.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=Obj_TheChurch_Final" "$INSTDIR\[OBJ] The Church Final"

rename "$INSTDIR\[OBJ] The Church Final" "$INSTDIR\Obj_TheChurch_Final.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] The Lost Village"

SectionIn 1 3



IfFileExists "$INSTDIR\User-TheLostVillage.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User-TheLostVillage" "$INSTDIR\[OBJ] The Lost Village"

rename "$INSTDIR\[OBJ] The Lost Village" "$INSTDIR\User-TheLostVillage.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] The Villa"

SectionIn 1 3



IfFileExists "$INSTDIR\TheVilla.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=TheVilla" "$INSTDIR\[OBJ] The Villa"

rename "$INSTDIR\[OBJ] The Villa" "$INSTDIR\TheVilla.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Tirtagaine Kechtat III"

SectionIn 1 3



IfFileExists "$INSTDIR\Tirtagaine-KechtatIII.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=Tirtagaine-KechtatIII" "$INSTDIR\[OBJ] Tirtagaine Kechtat III"

rename "$INSTDIR\[OBJ] Tirtagaine Kechtat III" "$INSTDIR\Tirtagaine-KechtatIII.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Under Siege"

SectionIn 1 3



IfFileExists "$INSTDIR\Under_Siege.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=Under_Siege" "$INSTDIR\[OBJ] Under Siege"

rename "$INSTDIR\[OBJ] Under Siege" "$INSTDIR\Under_Siege.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] V2 Shelter"

SectionIn 1 3



IfFileExists "$INSTDIR\V2Shelter.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=V2Shelter" "$INSTDIR\[OBJ] V2 Shelter"

rename "$INSTDIR\[OBJ] V2 Shelter" "$INSTDIR\V2Shelter.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] V3 lab"

SectionIn 1 3



IfFileExists "$INSTDIR\User-finalv3lab.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User-finalv3lab" "$INSTDIR\[OBJ] V3 lab"

rename "$INSTDIR\[OBJ] V3 lab" "$INSTDIR\User-finalv3lab.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Wuesten kaff"

SectionIn 2 3



IfFileExists "$INSTDIR\wuesten-kaff-beta9.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=wuesten-kaff-beta9" "$INSTDIR\[OBJ] Wuesten kaff"

rename "$INSTDIR\[OBJ] Wuesten kaff" "$INSTDIR\wuesten-kaff-beta9.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[OBJ] Xfire ville"

SectionIn 2 3



IfFileExists "$INSTDIR\user-ydiss-objxfireville.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=user-ydiss-objxfireville" "$INSTDIR\[OBJ] Xfire ville"

rename "$INSTDIR\[OBJ] Xfire ville" "$INSTDIR\user-ydiss-objxfireville.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] African nights"

SectionIn 2 3



IfFileExists "$INSTDIR\africannightstdm.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=africannightstdm" "$INSTDIR\[TDM] African nights"

rename "$INSTDIR\[TDM] African nights" "$INSTDIR\africannightstdm.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Ammo factory"

SectionIn 2 3



IfFileExists "$INSTDIR\ammo_factory.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=ammo_factory" "$INSTDIR\[TDM] Ammo factory"

rename "$INSTDIR\[TDM] Ammo factory" "$INSTDIR\ammo_factory.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Arnhem"

SectionIn 2 3



IfFileExists "$INSTDIR\Arnhem.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=Arnhem" "$INSTDIR\[TDM] Arnhem"

rename "$INSTDIR\[TDM] Arnhem" "$INSTDIR\Arnhem.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Bob Carentan"

SectionIn 2 3



IfFileExists "$INSTDIR\bob_carentan.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=bob_carentan" "$INSTDIR\[TDM] Bob Carentan"

rename "$INSTDIR\[TDM] Bob Carentan" "$INSTDIR\bob_carentan.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Bombedv"

SectionIn 2 3



IfFileExists "$INSTDIR\Map_AA_bombedv.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=Map_AA_bombedv" "$INSTDIR\[TDM] Bombedv"

rename "$INSTDIR\[TDM] Bombedv" "$INSTDIR\Map_AA_bombedv.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Broken Silence"

SectionIn 2 3



IfFileExists "$INSTDIR\User-Broken_Silence.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User-Broken_Silence" "$INSTDIR\[TDM] Broken Silence"

rename "$INSTDIR\[TDM] Broken Silence" "$INSTDIR\User-Broken_Silence.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Bsunrise 3"

SectionIn 2 3



IfFileExists "$INSTDIR\BSunrise3-3.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=BSunrise3-3" "$INSTDIR\[TDM] Bsunrise 3"

rename "$INSTDIR\[TDM] Bsunrise 3" "$INSTDIR\BSunrise3-3.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Bullet train"

SectionIn 2 3



IfFileExists "$INSTDIR\bullettrain.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=bullettrain" "$INSTDIR\[TDM] Bullet train"

rename "$INSTDIR\[TDM] Bullet train" "$INSTDIR\bullettrain.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Bunkeranlage V1"

SectionIn 2 3



IfFileExists "$INSTDIR\AR_Bunkeranlage_V1.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=AR_Bunkeranlage_V1" "$INSTDIR\[TDM] Bunkeranlage V1"

rename "$INSTDIR\[TDM] Bunkeranlage V1" "$INSTDIR\AR_Bunkeranlage_V1.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Canal Town V2"

SectionIn 2 3



IfFileExists "$INSTDIR\User-CanalTown_V2.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User-CanalTown_V2" "$INSTDIR\[TDM] Canal Town V2"

rename "$INSTDIR\[TDM] Canal Town V2" "$INSTDIR\User-CanalTown_V2.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Casablanca"

SectionIn 2 3



IfFileExists "$INSTDIR\user-casablanca.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=user-casablanca" "$INSTDIR\[TDM] Casablanca"

rename "$INSTDIR\[TDM] Casablanca" "$INSTDIR\user-casablanca.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Communique"

SectionIn 2 3



IfFileExists "$INSTDIR\communique.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=communique" "$INSTDIR\[TDM] Communique"

rename "$INSTDIR\[TDM] Communique" "$INSTDIR\communique.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Dorf"

SectionIn 2 3



IfFileExists "$INSTDIR\dm_dorf.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=dm_dorf" "$INSTDIR\[TDM] Dorf"

rename "$INSTDIR\[TDM] Dorf" "$INSTDIR\dm_dorf.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Dorf 14"

SectionIn 2 3



IfFileExists "$INSTDIR\dm_dorf14.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=dm_dorf14" "$INSTDIR\[TDM] Dorf 14"

rename "$INSTDIR\[TDM] Dorf 14" "$INSTDIR\dm_dorf14.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Duenkirchen"

SectionIn 2 3



IfFileExists "$INSTDIR\duenkirchen.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=duenkirchen" "$INSTDIR\[TDM] Duenkirchen"

rename "$INSTDIR\[TDM] Duenkirchen" "$INSTDIR\duenkirchen.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Dust"

SectionIn 2 3



IfFileExists "$INSTDIR\UserW5-MOHDust.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=UserW5-MOHDust" "$INSTDIR\[TDM] Dust"

rename "$INSTDIR\[TDM] Dust" "$INSTDIR\UserW5-MOHDust.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Fallen Village"

SectionIn 2 3



IfFileExists "$INSTDIR\User-dm_FallenVillage.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User-dm_FallenVillage" "$INSTDIR\[TDM] Fallen Village"

rename "$INSTDIR\[TDM] Fallen Village" "$INSTDIR\User-dm_FallenVillage.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Forschungs labor"

SectionIn 2 3



IfFileExists "$INSTDIR\user-Forschungslabor.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=user-Forschungslabor" "$INSTDIR\[TDM] Forschungs labor"

rename "$INSTDIR\[TDM] Forschungs labor" "$INSTDIR\user-Forschungslabor.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Gatehouse Assault"

SectionIn 2 3



IfFileExists "$INSTDIR\SW_dm_Gatehouse_Assault.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=SW_dm_Gatehouse_Assault" "$INSTDIR\[TDM] Gatehouse Assault"

rename "$INSTDIR\[TDM] Gatehouse Assault" "$INSTDIR\SW_dm_Gatehouse_Assault.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Hitlers farm"

SectionIn 2 3



IfFileExists "$INSTDIR\hitlersfarm.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=hitlersfarm" "$INSTDIR\[TDM] Hitlers farm"

rename "$INSTDIR\[TDM] Hitlers farm" "$INSTDIR\hitlersfarm.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Italy"

SectionIn 2 3



IfFileExists "$INSTDIR\italy1.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=italy1" "$INSTDIR\[TDM] Italy"

rename "$INSTDIR\[TDM] Italy" "$INSTDIR\italy1.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Las Chotas v2.0"

SectionIn 2 3



IfFileExists "$INSTDIR\user-ARG- Las Chotas v2.0 DM.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=user-ARG-%20Las%20Chotas%20v2.0%20DM" "$INSTDIR\[TDM] Las Chotas v2.0"

rename "$INSTDIR\[TDM] Las Chotas v2.0" "$INSTDIR\user-ARG- Las Chotas v2.0 DM.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Last Castle"

SectionIn 2 3



IfFileExists "$INSTDIR\lastcastle1.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=lastcastle1" "$INSTDIR\[TDM] Last Castle"

rename "$INSTDIR\[TDM] Last Castle" "$INSTDIR\lastcastle1.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Military post"

SectionIn 2 3



IfFileExists "$INSTDIR\military_post.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=military_post" "$INSTDIR\[TDM] Military post"

rename "$INSTDIR\[TDM] Military post" "$INSTDIR\military_post.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Morocco"

SectionIn 2 3



IfFileExists "$INSTDIR\user-morocco.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=user-morocco" "$INSTDIR\[TDM] Morocco"

rename "$INSTDIR\[TDM] Morocco" "$INSTDIR\user-morocco.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Needle"

SectionIn 2 3



IfFileExists "$INSTDIR\User-tdm_needle.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User-tdm_needle" "$INSTDIR\[TDM] Needle"

rename "$INSTDIR\[TDM] Needle" "$INSTDIR\User-tdm_needle.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Night battle"

SectionIn 2 3



IfFileExists "$INSTDIR\Dmarean-nightbattle.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=Dmarean-nightbattle" "$INSTDIR\[TDM] Night battle"

rename "$INSTDIR\[TDM] Night battle" "$INSTDIR\Dmarean-nightbattle.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Operation Sealion"

SectionIn 2 3



IfFileExists "$INSTDIR\User-OperationSealion.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User-OperationSealion" "$INSTDIR\[TDM] Operation Sealion"

rename "$INSTDIR\[TDM] Operation Sealion" "$INSTDIR\User-OperationSealion.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Renverse"

SectionIn 2 3



IfFileExists "$INSTDIR\Renverse.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=Renverse" "$INSTDIR\[TDM] Renverse"

rename "$INSTDIR\[TDM] Renverse" "$INSTDIR\Renverse.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Route nord"

SectionIn 2 3



IfFileExists "$INSTDIR\dm_routenord.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=dm_routenord" "$INSTDIR\[TDM] Route nord"

rename "$INSTDIR\[TDM] Route nord" "$INSTDIR\dm_routenord.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Sandsturm"

SectionIn 2 3



IfFileExists "$INSTDIR\User-MP_Sandsturm_DM.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User-MP_Sandsturm_DM" "$INSTDIR\[TDM] Sandsturm"

rename "$INSTDIR\[TDM] Sandsturm" "$INSTDIR\User-MP_Sandsturm_DM.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Small City"

SectionIn 2 3



IfFileExists "$INSTDIR\SmallCity.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=SmallCity" "$INSTDIR\[TDM] Small City"

rename "$INSTDIR\[TDM] Small City" "$INSTDIR\SmallCity.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Stalingrad 2"

SectionIn 2 3



IfFileExists "$INSTDIR\User-Stalingrad2Full.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User-Stalingrad2Full" "$INSTDIR\[TDM] Stalingrad 2"

rename "$INSTDIR\[TDM] Stalingrad 2" "$INSTDIR\User-Stalingrad2Full.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Stalingrad Snow"

SectionIn 2 3



IfFileExists "$INSTDIR\user-stalingradsnow.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=user-stalingradsnow" "$INSTDIR\[TDM] Stalingrad Snow"

rename "$INSTDIR\[TDM] Stalingrad Snow" "$INSTDIR\user-stalingradsnow.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Stalingrad Unbound 2"

SectionIn 2 3



IfFileExists "$INSTDIR\User-Kirby_Stalingrad_Unbound2.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User-Kirby_Stalingrad_Unbound2" "$INSTDIR\[TDM] Stalingrad Unbound 2"

rename "$INSTDIR\[TDM] Stalingrad Unbound 2" "$INSTDIR\User-Kirby_Stalingrad_Unbound2.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Strike at Dawn Return To Algiers"

SectionIn 2 3



IfFileExists "$INSTDIR\Strike_at_Dawn-Return To Algiers.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=Strike_at_Dawn-Return%20To%20Algiers" "$INSTDIR\[TDM] Strike at Dawn Return To Algiers"

rename "$INSTDIR\[TDM] Strike at Dawn Return To Algiers" "$INSTDIR\Strike_at_Dawn-Return To Algiers.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] The overpass"

SectionIn 2 3



IfFileExists "$INSTDIR\the_overpass.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=the_overpass" "$INSTDIR\[TDM] The overpass"

rename "$INSTDIR\[TDM] The overpass" "$INSTDIR\the_overpass.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Towers"

SectionIn 2 3



IfFileExists "$INSTDIR\dmarena-towers.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=dmarena-towers" "$INSTDIR\[TDM] Towers"

rename "$INSTDIR\[TDM] Towers" "$INSTDIR\dmarena-towers.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Toy Soldiers"

SectionIn 2 3



IfFileExists "$INSTDIR\toysoldiers.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=toysoldiers" "$INSTDIR\[TDM] Toy Soldiers"

rename "$INSTDIR\[TDM] Toy Soldiers" "$INSTDIR\toysoldiers.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Tunisian"

SectionIn 2 3



IfFileExists "$INSTDIR\user-tunisian.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=user-tunisian" "$INSTDIR\[TDM] Tunisian"

rename "$INSTDIR\[TDM] Tunisian" "$INSTDIR\user-tunisian.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Tunisian sh"

SectionIn 2 3



IfFileExists "$INSTDIR\user-tunisian_sh.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=user-tunisian_sh" "$INSTDIR\[TDM] Tunisian sh"

rename "$INSTDIR\[TDM] Tunisian sh" "$INSTDIR\user-tunisian_sh.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Ugcthorn ak"

SectionIn 2 3



IfFileExists "$INSTDIR\ugcthorn_ak.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=ugcthorn_ak" "$INSTDIR\[TDM] Ugcthorn ak"

rename "$INSTDIR\[TDM] Ugcthorn ak" "$INSTDIR\ugcthorn_ak.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Urban sprawl"

SectionIn 2 3



IfFileExists "$INSTDIR\urbansprawl.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=urbansprawl" "$INSTDIR\[TDM] Urban sprawl"

rename "$INSTDIR\[TDM] Urban sprawl" "$INSTDIR\urbansprawl.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Vervins"

SectionIn 2 3



IfFileExists "$INSTDIR\vervins.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=vervins" "$INSTDIR\[TDM] Vervins"

rename "$INSTDIR\[TDM] Vervins" "$INSTDIR\vervins.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Watten"

SectionIn 2 3



IfFileExists "$INSTDIR\User_Watten_multi.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User_Watten_multi" "$INSTDIR\[TDM] Watten"

rename "$INSTDIR\[TDM] Watten" "$INSTDIR\User_Watten_multi.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Weihnachtsmarkt"

SectionIn 2 3



IfFileExists "$INSTDIR\Weihnachtsmarkt.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=Weihnachtsmarkt" "$INSTDIR\[TDM] Weihnachtsmarkt"

rename "$INSTDIR\[TDM] Weihnachtsmarkt" "$INSTDIR\Weihnachtsmarkt.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Winterschlaf"

SectionIn 2 3



IfFileExists "$INSTDIR\User-MP_Winterschlaf_DM.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=User-MP_Winterschlaf_DM" "$INSTDIR\[TDM] Winterschlaf"

rename "$INSTDIR\[TDM] Winterschlaf" "$INSTDIR\User-MP_Winterschlaf_DM.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Xfire"

SectionIn 2 3



IfFileExists "$INSTDIR\user-ydiss-xfire.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=user-ydiss-xfire" "$INSTDIR\[TDM] Xfire"

rename "$INSTDIR\[TDM] Xfire" "$INSTDIR\user-ydiss-xfire.pk3"

ebanner::stop

end:

SectionEnd	   
Section "[TDM] Xfire 2vs2"

SectionIn 2 3



IfFileExists "$INSTDIR\user-xfire2v2.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=user-xfire2v2" "$INSTDIR\[TDM] Xfire 2vs2"

rename "$INSTDIR\[TDM] Xfire 2vs2" "$INSTDIR\user-xfire2v2.pk3"

ebanner::stop

end:

SectionEnd 

Section "[OBJ] Farpoint Storage"

SectionIn 1 3

IfFileExists "$INSTDIR\farpointstorage.*k3" end

ebanner::show /NOUNLOAD /VALIGN=Center "$TEMP\fantasyvirtual.jpg"

!insertmacro NSISDLSMOOTH_DOWNLOAD "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=farpointstorage" "$INSTDIR\[OBJ] Farpoint Storage"

rename "$INSTDIR\[OBJ] Farpoint Storage" "$INSTDIR\farpointstorage.pk3"

ebanner::stop

end:

SectionEnd


