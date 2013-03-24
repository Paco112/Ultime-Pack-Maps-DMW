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
;--------------------------------
;General

  ;Name and file
  !define VERSION "1.8.1.0"
  
  VIProductVersion "${VERSION}"
  VIAddVersionKey "Comments" "Site Officiel : www.ultime-pack.new.fr"
                                
  VIAddVersionKey "CompanyName" "[Dog-Cie] Paco{112}"
  VIAddVersionKey "LegalCopyright" "© BRAULT François"
  VIAddVersionKey "FileDescription" "Certified by DMW"
  VIAddVersionKey "FileVersion" "${VERSION}"

  Name "Ultime Pack Maps DMW v1.8.2b"
  BrandingText "[Dog-Cie] Paco{112}"
  
  ;Default installation folder

  InstallDir "$PROGRAMFILES\EA GAMES\MOHAA\main"
  InstallDirRegKey HKLM "Software\Ultime_Pack_Maps_DMW" "MAIN"
  

			 		
;--------------------------------

;Interface Settings


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


	!define MUI_FINISHPAGE_LINK "www.ultime-pack.new.fr .::Site Officiel::."
       	!define MUI_FINISHPAGE_LINK_LOCATION "http://www.ultime-pack.new.fr"


  !insertmacro MUI_PAGE_FINISH


InstType "Maps Objectives"
InstType "Maps Team DeathMatch"
InstType "All Maps"
InstType "None (Aucune)"


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
  
;--------------------------------

Function .onInit

; minimize all fenetres

    FindWindow $0 "Shell_TrayWnd"
    SendMessage $0 ${WM_COMMAND} 415 0

InitPluginsDir

CreateDirectory "$PROGRAMFILES\Ultime Pack Maps DMW\"

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
              
InetLoad::load "http://www.dog-cie.com/info.ini" "$PROGRAMFILES\Ultime Pack Maps DMW\info.ini"

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
ifFileExists "$INSTDIR\User - CapturedBase.*k3" "Y13" "N13"

Y13:

  SectionSetFlags 13 0

  SectionSetText 13 ""

  Goto N13

N13:       
ifFileExists "$INSTDIR\User-dasboot.*k3" "Y14" "N14"

Y14:

  SectionSetFlags 14 0

  SectionSetText 14 ""

  Goto N14

N14:       
ifFileExists "$INSTDIR\user-objdesertbase_final.*k3" "Y15" "N15"

Y15:

  SectionSetFlags 15 0

  SectionSetText 15 ""

  Goto N15

N15:       
ifFileExists "$INSTDIR\User-Desert-Assault.*k3" "Y16" "N16"

Y16:

  SectionSetFlags 16 0

  SectionSetText 16 ""

  Goto N16

N16:       
ifFileExists "$INSTDIR\User-Despair.*k3" "Y17" "N17"

Y17:

  SectionSetFlags 17 0

  SectionSetText 17 ""

  Goto N17

N17:       
ifFileExists "$INSTDIR\dmga2.*k3" "Y18" "N18"

Y18:

  SectionSetFlags 18 0

  SectionSetText 18 ""

  Goto N18

N18:       
ifFileExists "$INSTDIR\User-Eaglesnest-Final.*k3" "Y19" "N19"

Y19:

  SectionSetFlags 19 0

  SectionSetText 19 ""

  Goto N19

N19:       
ifFileExists "$INSTDIR\user-eder.*k3" "Y20" "N20"

Y20:

  SectionSetFlags 20 0

  SectionSetText 20 ""

  Goto N20

N20:       
ifFileExists "$INSTDIR\User-obj_FallenVillage.*k3" "Y21" "N21"

Y21:

  SectionSetFlags 21 0

  SectionSetText 21 ""

  Goto N21

N21:       
ifFileExists "$INSTDIR\fortwreck.*k3" "Y22" "N22"

Y22:

  SectionSetFlags 22 0

  SectionSetText 22 ""

  Goto N22

N22:       
ifFileExists "$INSTDIR\gloomcove.*k3" "Y23" "N23"

Y23:

  SectionSetFlags 23 0

  SectionSetText 23 ""

  Goto N23

N23:       
ifFileExists "$INSTDIR\User-Greece_1943_SP.*k3" "Y24" "N24"

Y24:

  SectionSetFlags 24 0

  SectionSetText 24 ""

  Goto N24

N24:       
ifFileExists "$INSTDIR\obj_howitzer_v1.*k3" "Y25" "N25"

Y25:

  SectionSetFlags 25 0

  SectionSetText 25 ""

  Goto N25

N25:       
ifFileExists "$INSTDIR\obj_Kasbah.*k3" "Y26" "N26"

Y26:

  SectionSetFlags 26 0

  SectionSetText 26 ""

  Goto N26

N26:       
ifFileExists "$INSTDIR\ZzZ_User_La_patrouille_2(all_version).*k3" "Y27" "N27"

Y27:

  SectionSetFlags 27 0

  SectionSetText 27 ""

  Goto N27

N27:       
ifFileExists "$INSTDIR\user_labeuze.*k3" "Y28" "N28"

Y28:

  SectionSetFlags 28 0

  SectionSetText 28 ""

  Goto N28

N28:       
ifFileExists "$INSTDIR\User_Laboratory.*k3" "Y29" "N29"

Y29:

  SectionSetFlags 29 0

  SectionSetText 29 ""

  Goto N29

N29:       
ifFileExists "$INSTDIR\user-Las Chotas.*k3" "Y30" "N30"

Y30:

  SectionSetFlags 30 0

  SectionSetText 30 ""

  Goto N30

N30:       
ifFileExists "$INSTDIR\user-obj_lastcastle.*k3" "Y31" "N31"

Y31:

  SectionSetFlags 31 0

  SectionSetText 31 ""

  Goto N31

N31:       
ifFileExists "$INSTDIR\User_Letzte_Tage.*k3" "Y32" "N32"

Y32:

  SectionSetFlags 32 0

  SectionSetText 32 ""

  Goto N32

N32:       
ifFileExists "$INSTDIR\lol_clifftop.*k3" "Y33" "N33"

Y33:

  SectionSetFlags 33 0

  SectionSetText 33 ""

  Goto N33

N33:       
ifFileExists "$INSTDIR\lol_v2_new_3.*k3" "Y34" "N34"

Y34:

  SectionSetFlags 34 0

  SectionSetText 34 ""

  Goto N34

N34:       
ifFileExists "$INSTDIR\User-obj_maromg.*k3" "Y35" "N35"

Y35:

  SectionSetFlags 35 0

  SectionSetText 35 ""

  Goto N35

N35:       
ifFileExists "$INSTDIR\obj_marseille_v1_6.*k3" "Y36" "N36"

Y36:

  SectionSetFlags 36 0

  SectionSetText 36 ""

  Goto N36

N36:       
ifFileExists "$INSTDIR\monastere.*k3" "Y37" "N37"

Y37:

  SectionSetFlags 37 0

  SectionSetText 37 ""

  Goto N37

N37:       
ifFileExists "$INSTDIR\OpCenter_obj.*k3" "Y38" "N38"

Y38:

  SectionSetFlags 38 0

  SectionSetText 38 ""

  Goto N38

N38:       
ifFileExists "$INSTDIR\OpreaHouse.*k3" "Y39" "N39"

Y39:

  SectionSetFlags 39 0

  SectionSetText 39 ""

  Goto N39

N39:       
ifFileExists "$INSTDIR\push_cityhall.*k3" "Y40" "N40"

Y40:

  SectionSetFlags 40 0

  SectionSetText 40 ""

  Goto N40

N40:       
ifFileExists "$INSTDIR\user_resistance.*k3" "Y41" "N41"

Y41:

  SectionSetFlags 41 0

  SectionSetText 41 ""

  Goto N41

N41:       
ifFileExists "$INSTDIR\objdm_rockbound_aa.*k3" "Y42" "N42"

Y42:

  SectionSetFlags 42 0

  SectionSetText 42 ""

  Goto N42

N42:       
ifFileExists "$INSTDIR\Schplatzburg_obj.*k3" "Y43" "N43"

Y43:

  SectionSetFlags 43 0

  SectionSetText 43 ""

  Goto N43

N43:       
ifFileExists "$INSTDIR\user-Snow_Camp.*k3" "Y44" "N44"

Y44:

  SectionSetFlags 44 0

  SectionSetText 44 ""

  Goto N44

N44:       
ifFileExists "$INSTDIR\User-Stlo.*k3" "Y45" "N45"

Y45:

  SectionSetFlags 45 0

  SectionSetText 45 ""

  Goto N45

N45:       
ifFileExists "$INSTDIR\Kmarzo-St Renan.*k3" "Y46" "N46"

Y46:

  SectionSetFlags 46 0

  SectionSetText 46 ""

  Goto N46

N46:       
ifFileExists "$INSTDIR\stalingrad1942.*k3" "Y47" "N47"

Y47:

  SectionSetFlags 47 0

  SectionSetText 47 ""

  Goto N47

N47:       
ifFileExists "$INSTDIR\Stalingrad_3.*k3" "Y48" "N48"

Y48:

  SectionSetFlags 48 0

  SectionSetText 48 ""

  Goto N48

N48:       
ifFileExists "$INSTDIR\user-swordbeach.*k3" "Y49" "N49"

Y49:

  SectionSetFlags 49 0

  SectionSetText 49 ""

  Goto N49

N49:       
ifFileExists "$INSTDIR\user_obj_teamzero.*k3" "Y50" "N50"

Y50:

  SectionSetFlags 50 0

  SectionSetText 50 ""

  Goto N50

N50:       
ifFileExists "$INSTDIR\the_cemetary.*k3" "Y51" "N51"

Y51:

  SectionSetFlags 51 0

  SectionSetText 51 ""

  Goto N51

N51:       
ifFileExists "$INSTDIR\User-TheLostVillage.*k3" "Y52" "N52"

Y52:

  SectionSetFlags 52 0

  SectionSetText 52 ""

  Goto N52

N52:       
ifFileExists "$INSTDIR\TheVilla.*k3" "Y53" "N53"

Y53:

  SectionSetFlags 53 0

  SectionSetText 53 ""

  Goto N53

N53:       
ifFileExists "$INSTDIR\Tirtagaine-KechtatIII.*k3" "Y54" "N54"

Y54:

  SectionSetFlags 54 0

  SectionSetText 54 ""

  Goto N54

N54:       
ifFileExists "$INSTDIR\Under_Siege.*k3" "Y55" "N55"

Y55:

  SectionSetFlags 55 0

  SectionSetText 55 ""

  Goto N55

N55:       
ifFileExists "$INSTDIR\V2Shelter.*k3" "Y56" "N56"

Y56:

  SectionSetFlags 56 0

  SectionSetText 56 ""

  Goto N56

N56:       
ifFileExists "$INSTDIR\User-finalv3lab.*k3" "Y57" "N57"

Y57:

  SectionSetFlags 57 0

  SectionSetText 57 ""

  Goto N57

N57:       
ifFileExists "$INSTDIR\wuesten-kaff-beta9.*k3" "Y58" "N58"

Y58:

  SectionSetFlags 58 0

  SectionSetText 58 ""

  Goto N58

N58:       
ifFileExists "$INSTDIR\user-ydiss-xfire.*k3" "Y59" "N59"

Y59:

  SectionSetFlags 59 0

  SectionSetText 59 ""

  Goto N59

N59:       
ifFileExists "$INSTDIR\africannightstdm.*k3" "Y60" "N60"

Y60:

  SectionSetFlags 60 0

  SectionSetText 60 ""

  Goto N60

N60:       
ifFileExists "$INSTDIR\ammo_factory.*k3" "Y61" "N61"

Y61:

  SectionSetFlags 61 0

  SectionSetText 61 ""

  Goto N61

N61:       
ifFileExists "$INSTDIR\Arnhem.*k3" "Y62" "N62"

Y62:

  SectionSetFlags 62 0

  SectionSetText 62 ""

  Goto N62

N62:       
ifFileExists "$INSTDIR\bob_carentan.*k3" "Y63" "N63"

Y63:

  SectionSetFlags 63 0

  SectionSetText 63 ""

  Goto N63

N63:       
ifFileExists "$INSTDIR\Map_AA_bombedv.*k3" "Y64" "N64"

Y64:

  SectionSetFlags 64 0

  SectionSetText 64 ""

  Goto N64

N64:       
ifFileExists "$INSTDIR\User-Broken_Silence.*k3" "Y65" "N65"

Y65:

  SectionSetFlags 65 0

  SectionSetText 65 ""

  Goto N65

N65:       
ifFileExists "$INSTDIR\BSunrise3-3.*k3" "Y66" "N66"

Y66:

  SectionSetFlags 66 0

  SectionSetText 66 ""

  Goto N66

N66:       
ifFileExists "$INSTDIR\bullettrain.*k3" "Y67" "N67"

Y67:

  SectionSetFlags 67 0

  SectionSetText 67 ""

  Goto N67

N67:       
ifFileExists "$INSTDIR\AR_Bunkeranlage_V1.*k3" "Y68" "N68"

Y68:

  SectionSetFlags 68 0

  SectionSetText 68 ""

  Goto N68

N68:       
ifFileExists "$INSTDIR\user-obj_canal.*k3" "Y69" "N69"

Y69:

  SectionSetFlags 69 0

  SectionSetText 69 ""

  Goto N69

N69:       
ifFileExists "$INSTDIR\User-CanalTown_V2.*k3" "Y70" "N70"

Y70:

  SectionSetFlags 70 0

  SectionSetText 70 ""

  Goto N70

N70:       
ifFileExists "$INSTDIR\user-casablanca.*k3" "Y71" "N71"

Y71:

  SectionSetFlags 71 0

  SectionSetText 71 ""

  Goto N71

N71:       
ifFileExists "$INSTDIR\communique.*k3" "Y72" "N72"

Y72:

  SectionSetFlags 72 0

  SectionSetText 72 ""

  Goto N72

N72:       
ifFileExists "$INSTDIR\dm_dorf.*k3" "Y73" "N73"

Y73:

  SectionSetFlags 73 0

  SectionSetText 73 ""

  Goto N73

N73:       
ifFileExists "$INSTDIR\dm_dorf14.*k3" "Y74" "N74"

Y74:

  SectionSetFlags 74 0

  SectionSetText 74 ""

  Goto N74

N74:       
ifFileExists "$INSTDIR\duenkirchen.*k3" "Y75" "N75"

Y75:

  SectionSetFlags 75 0

  SectionSetText 75 ""

  Goto N75

N75:       
ifFileExists "$INSTDIR\UserW5-MOHDust.*k3" "Y76" "N76"

Y76:

  SectionSetFlags 76 0

  SectionSetText 76 ""

  Goto N76

N76:       
ifFileExists "$INSTDIR\User-dm_FallenVillage.*k3" "Y77" "N77"

Y77:

  SectionSetFlags 77 0

  SectionSetText 77 ""

  Goto N77

N77:       
ifFileExists "$INSTDIR\user-Forschungslabor.*k3" "Y78" "N78"

Y78:

  SectionSetFlags 78 0

  SectionSetText 78 ""

  Goto N78

N78:       
ifFileExists "$INSTDIR\SW_dm_Gatehouse_Assault.*k3" "Y79" "N79"

Y79:

  SectionSetFlags 79 0

  SectionSetText 79 ""

  Goto N79

N79:       
ifFileExists "$INSTDIR\hitlersfarm.*k3" "Y80" "N80"

Y80:

  SectionSetFlags 80 0

  SectionSetText 80 ""

  Goto N80

N80:       
ifFileExists "$INSTDIR\italy1.*k3" "Y81" "N81"

Y81:

  SectionSetFlags 81 0

  SectionSetText 81 ""

  Goto N81

N81:       
ifFileExists "$INSTDIR\user-ARG- Las Chotas v2.0 DM.*k3" "Y82" "N82"

Y82:

  SectionSetFlags 82 0

  SectionSetText 82 ""

  Goto N82

N82:       
ifFileExists "$INSTDIR\lastcastle1.*k3" "Y83" "N83"

Y83:

  SectionSetFlags 83 0

  SectionSetText 83 ""

  Goto N83

N83:       
ifFileExists "$INSTDIR\military_post.*k3" "Y84" "N84"

Y84:

  SectionSetFlags 84 0

  SectionSetText 84 ""

  Goto N84

N84:       
ifFileExists "$INSTDIR\user-morocco.*k3" "Y85" "N85"

Y85:

  SectionSetFlags 85 0

  SectionSetText 85 ""

  Goto N85

N85:       
ifFileExists "$INSTDIR\User-tdm_needle.*k3" "Y86" "N86"

Y86:

  SectionSetFlags 86 0

  SectionSetText 86 ""

  Goto N86

N86:       
ifFileExists "$INSTDIR\Dmarean-nightbattle.*k3" "Y87" "N87"

Y87:

  SectionSetFlags 87 0

  SectionSetText 87 ""

  Goto N87

N87:       
ifFileExists "$INSTDIR\User-OperationSealion.*k3" "Y88" "N88"

Y88:

  SectionSetFlags 88 0

  SectionSetText 88 ""

  Goto N88

N88:       
ifFileExists "$INSTDIR\Renverse.*k3" "Y89" "N89"

Y89:

  SectionSetFlags 89 0

  SectionSetText 89 ""

  Goto N89

N89:       
ifFileExists "$INSTDIR\dm_routenord.*k3" "Y90" "N90"

Y90:

  SectionSetFlags 90 0

  SectionSetText 90 ""

  Goto N90

N90:       
ifFileExists "$INSTDIR\User-MP_Sandsturm_DM.*k3" "Y91" "N91"

Y91:

  SectionSetFlags 91 0

  SectionSetText 91 ""

  Goto N91

N91:       
ifFileExists "$INSTDIR\SmallCity.*k3" "Y92" "N92"

Y92:

  SectionSetFlags 92 0

  SectionSetText 92 ""

  Goto N92

N92:       
ifFileExists "$INSTDIR\User-Stalingrad2Full.*k3" "Y93" "N93"

Y93:

  SectionSetFlags 93 0

  SectionSetText 93 ""

  Goto N93

N93:       
ifFileExists "$INSTDIR\user-stalingradsnow.*k3" "Y94" "N94"

Y94:

  SectionSetFlags 94 0

  SectionSetText 94 ""

  Goto N94

N94:       
ifFileExists "$INSTDIR\User-Kirby_Stalingrad_Unbound2.*k3" "Y95" "N95"

Y95:

  SectionSetFlags 95 0

  SectionSetText 95 ""

  Goto N95

N95:       
ifFileExists "$INSTDIR\Strike_at_Dawn-Return To Algiers.*k3" "Y96" "N96"

Y96:

  SectionSetFlags 96 0

  SectionSetText 96 ""

  Goto N96

N96:       
ifFileExists "$INSTDIR\Obj_TheChurch_Final.*k3" "Y97" "N97"

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
ifFileExists "$INSTDIR\user-xfire2v2.*k3" "Y109" "N109"

Y109:

  SectionSetFlags 109 0

  SectionSetText 109 ""

  Goto N109

N109:      
ifFileExists "$INSTDIR\user-ydiss-objxfireville.*k3" "Y110" "N110"

Y110:

  SectionSetFlags 110 0

  SectionSetText 110 ""

  Goto N110

N110:    

FunctionEnd
  
 
 
Section "[Soft] Pk3 Manager"

SectionIn 3

InetLoad::load /popup "[Soft] Pk3 Manager" "http://www.dog-cie.com/telechargement/Pk3 Manager.exe" "$DESKTOP\Pk3 Manager.exe"

SectionEnd     
Section "[Skin] DMW Pack"

SectionIn 3

InetLoad::load /popup   "[Skin] DMW Pack" "http://www.dog-cie.com/telechargement/BA_skin_pack1.zip" "$INSTDIR\BA_skin_pack1.zip"

ZipDLL::extractfile "$INSTDIR\BA_skin_pack1.zip" "$INSTDIR\" "BA_skin_pack1.pk3"

Delete "$INSTDIR\BA_skin_pack1.zip"

SectionEnd     
Section "[OBJ] Aarschot"

SectionIn 1 3

InetLoad::load /popup "[OBJ] Aarschot" "http://www.dog-cie.com/map obj/User - Aarschot Obj.zip" "$INSTDIR\User - Aarschot Obj.zip"

ZipDLL::extractfile "$INSTDIR\User - Aarschot Obj.zip" "$INSTDIR\" "User - Aarschot Obj.pk3"

Delete "$INSTDIR\User - Aarschot Obj.zip"

SectionEnd     
Section "[OBJ] Abbey Beta "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Abbey Beta " "http://www.dog-cie.com/map obj/VSUK-AbbeyBeta.zip" "$INSTDIR\VSUK-AbbeyBeta.zip"

ZipDLL::extractfile "$INSTDIR\VSUK-AbbeyBeta.zip" "$INSTDIR\" "VSUK-AbbeyBeta.pk3"

Delete "$INSTDIR\VSUK-AbbeyBeta.zip"

SectionEnd     
Section "[OBJ] African nights"

SectionIn 1 3

InetLoad::load /popup "[OBJ] African nights" "http://www.dog-cie.com/map obj/africannights_obj.zip" "$INSTDIR\africannights_obj.zip"

ZipDLL::extractfile "$INSTDIR\africannights_obj.zip" "$INSTDIR\" "africannights_obj.pk3"

Delete "$INSTDIR\africannights_obj.zip"

SectionEnd     
Section "[OBJ] Aftermath "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Aftermath " "http://www.dog-cie.com/map obj/User-Aftermath.zip" "$INSTDIR\User-Aftermath.zip"

ZipDLL::extractfile "$INSTDIR\User-Aftermath.zip" "$INSTDIR\" "User-Aftermath.pk3"

Delete "$INSTDIR\User-Aftermath.zip"

SectionEnd     
Section "[OBJ] Angryfields "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Angryfields " "http://www.dog-cie.com/map obj/Angryfields.zip" "$INSTDIR\Angryfields.zip"

ZipDLL::extractfile "$INSTDIR\Angryfields.zip" "$INSTDIR\" "Angryfields.pk3"

Delete "$INSTDIR\Angryfields.zip"

SectionEnd     
Section "[OBJ] ARG Hunt "

SectionIn 1 3

InetLoad::load /popup "[OBJ] ARG Hunt " "http://www.dog-cie.com/map obj/user-ARG-Hunt.zip" "$INSTDIR\user-ARG-Hunt.zip"

ZipDLL::extractfile "$INSTDIR\user-ARG-Hunt.zip" "$INSTDIR\" "user-ARG-Hunt.pk3"

Delete "$INSTDIR\user-ARG-Hunt.zip"

SectionEnd     
Section "[OBJ] ARG Las Chotas v2.0"

SectionIn 1 3

InetLoad::load /popup "[OBJ] ARG Las Chotas v2.0" "http://www.dog-cie.com/map obj/user-ARG- Las Chotas v2.0 Obj.zip" "$INSTDIR\user-ARG- Las Chotas v2.0 Obj.zip"

ZipDLL::extractfile "$INSTDIR\user-ARG- Las Chotas v2.0 Obj.zip" "$INSTDIR\" "user-ARG- Las Chotas v2.0 Obj.pk3"

Delete "$INSTDIR\user-ARG- Las Chotas v2.0 Obj.zip"

SectionEnd     
Section "[OBJ] Assault 77 "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Assault 77 " "http://www.dog-cie.com/map obj/assault77.zip" "$INSTDIR\assault77.zip"

ZipDLL::extractfile "$INSTDIR\assault77.zip" "$INSTDIR\" "assault77.pk3"

Delete "$INSTDIR\assault77.zip"

SectionEnd     
Section "[OBJ] BA Stalingrad "

SectionIn 1 3

InetLoad::load /popup "[OBJ] BA Stalingrad " "http://www.dog-cie.com/map obj/BA_stalingrad.zip" "$INSTDIR\BA_stalingrad.zip"

ZipDLL::extractfile "$INSTDIR\BA_stalingrad.zip" "$INSTDIR\" "BA_stalingrad.pk3"

Delete "$INSTDIR\BA_stalingrad.zip"

SectionEnd     
Section "[OBJ] Bahnhof steinhude 1939 "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Bahnhof steinhude 1939 " "http://www.dog-cie.com/map obj/obj_bahnhof_steinhude_1939.zip" "$INSTDIR\obj_bahnhof_steinhude_1939.zip"

ZipDLL::extractfile "$INSTDIR\obj_bahnhof_steinhude_1939.zip" "$INSTDIR\" "obj_bahnhof_steinhude_1939.pk3"

Delete "$INSTDIR\obj_bahnhof_steinhude_1939.zip"

SectionEnd     
Section "[OBJ] Bazaar "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Bazaar " "http://www.dog-cie.com/map obj/User-bazaar.zip" "$INSTDIR\User-bazaar.zip"

ZipDLL::extractfile "$INSTDIR\User-bazaar.zip" "$INSTDIR\" "User-bazaar.pk3"

Delete "$INSTDIR\User-bazaar.zip"

SectionEnd     
Section "[OBJ] Captured Base "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Captured Base " "http://www.dog-cie.com/map obj/User - CapturedBase.zip" "$INSTDIR\User - CapturedBase.zip"

ZipDLL::extractfile "$INSTDIR\User - CapturedBase.zip" "$INSTDIR\" "User - CapturedBase.pk3"

Delete "$INSTDIR\User - CapturedBase.zip"

SectionEnd     
Section "[OBJ] Dasboot "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Dasboot " "http://www.dog-cie.com/map obj/User-dasboot.zip" "$INSTDIR\User-dasboot.zip"

ZipDLL::extractfile "$INSTDIR\User-dasboot.zip" "$INSTDIR\" "User-dasboot.pk3"

Delete "$INSTDIR\User-dasboot.zip"

SectionEnd     
Section "[OBJ] Desert Base"

SectionIn 1 3

InetLoad::load /popup "[OBJ] Desert Base" "http://www.dog-cie.com/map obj/user-objdesertbase_final.zip" "$INSTDIR\user-objdesertbase_final.zip"

ZipDLL::extractfile "$INSTDIR\user-objdesertbase_final.zip" "$INSTDIR\" "user-objdesertbase_final.pk3"

Delete "$INSTDIR\user-objdesertbase_final.zip"

SectionEnd     
Section "[OBJ] Desert-Assault "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Desert-Assault " "http://www.dog-cie.com/map obj/User-Desert-Assault.zip" "$INSTDIR\User-Desert-Assault.zip"

ZipDLL::extractfile "$INSTDIR\User-Desert-Assault.zip" "$INSTDIR\" "User-Desert-Assault.pk3"

Delete "$INSTDIR\User-Desert-Assault.zip"

SectionEnd     
Section "[OBJ] Despair "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Despair " "http://www.dog-cie.com/map obj/User-Despair.zip" "$INSTDIR\User-Despair.zip"

ZipDLL::extractfile "$INSTDIR\User-Despair.zip" "$INSTDIR\" "User-Despair.pk3"

Delete "$INSTDIR\User-Despair.zip"

SectionEnd     
Section "[OBJ] dmga2 "

SectionIn 1 3

InetLoad::load /popup "[OBJ] dmga2 " "http://www.dog-cie.com/map obj/dmga2.zip" "$INSTDIR\dmga2.zip"

ZipDLL::extractfile "$INSTDIR\dmga2.zip" "$INSTDIR\" "dmga2.pk3"

Delete "$INSTDIR\dmga2.zip"

SectionEnd     
Section "[OBJ] Eaglesnest-Final "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Eaglesnest-Final " "http://www.dog-cie.com/map obj/User-Eaglesnest-Final.zip" "$INSTDIR\User-Eaglesnest-Final.zip"

ZipDLL::extractfile "$INSTDIR\User-Eaglesnest-Final.zip" "$INSTDIR\" "User-Eaglesnest-Final.pk3"

Delete "$INSTDIR\User-Eaglesnest-Final.zip"

SectionEnd     
Section "[OBJ] Eder "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Eder " "http://www.dog-cie.com/map obj/user-eder.zip" "$INSTDIR\user-eder.zip"

ZipDLL::extractfile "$INSTDIR\user-eder.zip" "$INSTDIR\" "user-eder.pk3"

Delete "$INSTDIR\user-eder.zip"

SectionEnd     
Section "[OBJ] Fallen Village "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Fallen Village " "http://www.dog-cie.com/map obj/User-obj_FallenVillage.zip" "$INSTDIR\User-obj_FallenVillage.zip"

ZipDLL::extractfile "$INSTDIR\User-obj_FallenVillage.zip" "$INSTDIR\" "User-obj_FallenVillage.pk3"

Delete "$INSTDIR\User-obj_FallenVillage.zip"

SectionEnd     
Section "[OBJ] Fortwreck "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Fortwreck " "http://www.dog-cie.com/map obj/fortwreck.zip" "$INSTDIR\fortwreck.zip"

ZipDLL::extractfile "$INSTDIR\fortwreck.zip" "$INSTDIR\" "fortwreck.pk3"

Delete "$INSTDIR\fortwreck.zip"

SectionEnd     
Section "[OBJ] Gloomcove "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Gloomcove " "http://www.dog-cie.com/map obj/gloomcove.zip" "$INSTDIR\gloomcove.zip"

ZipDLL::extractfile "$INSTDIR\gloomcove.zip" "$INSTDIR\" "gloomcove.pk3"

Delete "$INSTDIR\gloomcove.zip"

SectionEnd     
Section "[OBJ] Greece 1943"

SectionIn 1 3

InetLoad::load /popup "[OBJ] Greece 1943" "http://www.dog-cie.com/map obj/User-Greece_1943_SP.zip" "$INSTDIR\User-Greece_1943_SP.zip"

ZipDLL::extractfile "$INSTDIR\User-Greece_1943_SP.zip" "$INSTDIR\" "User-Greece_1943_SP.pk3"

Delete "$INSTDIR\User-Greece_1943_SP.zip"

SectionEnd     
Section "[OBJ] Howitzer"

SectionIn 1 3

InetLoad::load /popup "[OBJ] Howitzer" "http://www.dog-cie.com/map obj/obj_howitzer_v1.zip" "$INSTDIR\obj_howitzer_v1.zip"

ZipDLL::extractfile "$INSTDIR\obj_howitzer_v1.zip" "$INSTDIR\" "obj_howitzer_v1.pk3"

Delete "$INSTDIR\obj_howitzer_v1.zip"

SectionEnd     
Section "[OBJ] Kasbah "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Kasbah " "http://www.dog-cie.com/map obj/obj_Kasbah.zip" "$INSTDIR\obj_Kasbah.zip"

ZipDLL::extractfile "$INSTDIR\obj_Kasbah.zip" "$INSTDIR\" "obj_Kasbah.pk3"

Delete "$INSTDIR\obj_Kasbah.zip"

SectionEnd     
Section "[OBJ] La patrouille 2"

SectionIn 1 3

InetLoad::load /popup "[OBJ] La patrouille 2" "http://www.dog-cie.com/map obj/ZzZ_User_La_patrouille_2(all_version).zip" "$INSTDIR\ZzZ_User_La_patrouille_2(all_version).zip"

ZipDLL::extractfile "$INSTDIR\ZzZ_User_La_patrouille_2(all_version).zip" "$INSTDIR\" "ZzZ_User_La_patrouille_2(all_version).pk3"

Delete "$INSTDIR\ZzZ_User_La_patrouille_2(all_version).zip"

SectionEnd     
Section "[OBJ] labeuze "

SectionIn 1 3

InetLoad::load /popup "[OBJ] labeuze " "http://www.dog-cie.com/map obj/user_labeuze.zip" "$INSTDIR\user_labeuze.zip"

ZipDLL::extractfile "$INSTDIR\user_labeuze.zip" "$INSTDIR\" "user_labeuze.pk3"

Delete "$INSTDIR\user_labeuze.zip"

SectionEnd     
Section "[OBJ] Laboratory "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Laboratory " "http://www.dog-cie.com/map obj/User_Laboratory.zip" "$INSTDIR\User_Laboratory.zip"

ZipDLL::extractfile "$INSTDIR\User_Laboratory.zip" "$INSTDIR\" "User_Laboratory.pk3"

Delete "$INSTDIR\User_Laboratory.zip"

SectionEnd     
Section "[OBJ] Las Chotas "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Las Chotas " "http://www.dog-cie.com/map obj/user-Las Chotas.zip" "$INSTDIR\user-Las Chotas.zip"

ZipDLL::extractfile "$INSTDIR\user-Las Chotas.zip" "$INSTDIR\" "user-Las Chotas.pk3"

Delete "$INSTDIR\user-Las Chotas.zip"

SectionEnd     
Section "[OBJ] Last castle "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Last castle " "http://www.dog-cie.com/map obj/user-obj_lastcastle.zip" "$INSTDIR\user-obj_lastcastle.zip"

ZipDLL::extractfile "$INSTDIR\user-obj_lastcastle.zip" "$INSTDIR\" "user-obj_lastcastle.pk3"

Delete "$INSTDIR\user-obj_lastcastle.zip"

SectionEnd     
Section "[OBJ] Letzte Tage "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Letzte Tage " "http://www.dog-cie.com/map obj/User_Letzte_Tage.zip" "$INSTDIR\User_Letzte_Tage.zip"

ZipDLL::extractfile "$INSTDIR\User_Letzte_Tage.zip" "$INSTDIR\" "User_Letzte_Tage.pk3"

Delete "$INSTDIR\User_Letzte_Tage.zip"

SectionEnd     
Section "[OBJ] lol Clifftop "

SectionIn 1 3

InetLoad::load /popup "[OBJ] lol Clifftop " "http://www.dog-cie.com/map obj/lol_clifftop.zip" "$INSTDIR\lol_clifftop.zip"

ZipDLL::extractfile "$INSTDIR\lol_clifftop.zip" "$INSTDIR\" "lol_clifftop.pk3"

Delete "$INSTDIR\lol_clifftop.zip"

SectionEnd     
Section "[OBJ] lol_v2"

SectionIn 1 3

InetLoad::load /popup "[OBJ] lol_v2" "http://www.dog-cie.com/map obj/lol_v2_new_3.zip" "$INSTDIR\lol_v2_new_3.zip"

ZipDLL::extractfile "$INSTDIR\lol_v2_new_3.zip" "$INSTDIR\" "lol_v2_new_3.pk3"

Delete "$INSTDIR\lol_v2_new_3.zip"

SectionEnd     
Section "[OBJ] Maromg "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Maromg " "http://www.dog-cie.com/map obj/User-obj_maromg.zip" "$INSTDIR\User-obj_maromg.zip"

ZipDLL::extractfile "$INSTDIR\User-obj_maromg.zip" "$INSTDIR\" "User-obj_maromg.pk3"

Delete "$INSTDIR\User-obj_maromg.zip"

SectionEnd     
Section "[OBJ] Marseille"

SectionIn 1 3

InetLoad::load /popup "[OBJ] Marseille" "http://www.dog-cie.com/map obj/obj_marseille_v1_6.zip" "$INSTDIR\obj_marseille_v1_6.zip"

ZipDLL::extractfile "$INSTDIR\obj_marseille_v1_6.zip" "$INSTDIR\" "obj_marseille_v1_6.pk3"

Delete "$INSTDIR\obj_marseille_v1_6.zip"

SectionEnd     
Section "[OBJ] Monastere "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Monastere " "http://www.dog-cie.com/map obj/monastere.zip" "$INSTDIR\monastere.zip"

ZipDLL::extractfile "$INSTDIR\monastere.zip" "$INSTDIR\" "monastere.pk3"

Delete "$INSTDIR\monastere.zip"

SectionEnd     
Section "[OBJ] OpCenter"

SectionIn 1 3

InetLoad::load /popup "[OBJ] OpCenter" "http://www.dog-cie.com/map obj/OpCenter_obj.zip" "$INSTDIR\OpCenter_obj.zip"

ZipDLL::extractfile "$INSTDIR\OpCenter_obj.zip" "$INSTDIR\" "OpCenter_obj.pk3"

Delete "$INSTDIR\OpCenter_obj.zip"

SectionEnd     
Section "[OBJ] OpreaHouse "

SectionIn 1 3

InetLoad::load /popup "[OBJ] OpreaHouse " "http://www.dog-cie.com/map obj/OpreaHouse.zip" "$INSTDIR\OpreaHouse.zip"

ZipDLL::extractfile "$INSTDIR\OpreaHouse.zip" "$INSTDIR\" "OpreaHouse.pk3"

Delete "$INSTDIR\OpreaHouse.zip"

SectionEnd     
Section "[OBJ] Push cityhall "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Push cityhall " "http://www.dog-cie.com/map obj/push_cityhall.zip" "$INSTDIR\push_cityhall.zip"

ZipDLL::extractfile "$INSTDIR\push_cityhall.zip" "$INSTDIR\" "push_cityhall.pk3"

Delete "$INSTDIR\push_cityhall.zip"

SectionEnd     
Section "[OBJ] Resistance "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Resistance " "http://www.dog-cie.com/map obj/user_resistance.zip" "$INSTDIR\user_resistance.zip"

ZipDLL::extractfile "$INSTDIR\user_resistance.zip" "$INSTDIR\" "user_resistance.pk3"

Delete "$INSTDIR\user_resistance.zip"

SectionEnd     
Section "[OBJ] Rockbound"

SectionIn 1 3

InetLoad::load /popup "[OBJ] Rockbound" "http://www.dog-cie.com/map obj/objdm_rockbound_aa.zip" "$INSTDIR\objdm_rockbound_aa.zip"

ZipDLL::extractfile "$INSTDIR\objdm_rockbound_aa.zip" "$INSTDIR\" "objdm_rockbound_aa.pk3"

Delete "$INSTDIR\objdm_rockbound_aa.zip"

SectionEnd     
Section "[OBJ] Schplatzburg"

SectionIn 1 3

InetLoad::load /popup "[OBJ] Schplatzburg" "http://www.dog-cie.com/map obj/Schplatzburg_obj.zip" "$INSTDIR\Schplatzburg_obj.zip"

ZipDLL::extractfile "$INSTDIR\Schplatzburg_obj.zip" "$INSTDIR\" "Schplatzburg_obj.pk3"

Delete "$INSTDIR\Schplatzburg_obj.zip"

SectionEnd     
Section "[OBJ] Snow Camp "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Snow Camp " "http://www.dog-cie.com/map obj/user-Snow_Camp.zip" "$INSTDIR\user-Snow_Camp.zip"

ZipDLL::extractfile "$INSTDIR\user-Snow_Camp.zip" "$INSTDIR\" "user-Snow_Camp.pk3"

Delete "$INSTDIR\user-Snow_Camp.zip"

SectionEnd     
Section "[OBJ] St lo "

SectionIn 1 3

InetLoad::load /popup "[OBJ] St lo " "http://www.dog-cie.com/map obj/User-Stlo.zip" "$INSTDIR\User-Stlo.zip"

ZipDLL::extractfile "$INSTDIR\User-Stlo.zip" "$INSTDIR\" "User-Stlo.pk3"

Delete "$INSTDIR\User-Stlo.zip"

SectionEnd     
Section "[OBJ] St Renan "

SectionIn 1 3

InetLoad::load /popup "[OBJ] St Renan " "http://www.dog-cie.com/map obj/Kmarzo-St Renan.zip" "$INSTDIR\Kmarzo-St Renan.zip"

ZipDLL::extractfile "$INSTDIR\Kmarzo-St Renan.zip" "$INSTDIR\" "Kmarzo-St Renan.pk3"

Delete "$INSTDIR\Kmarzo-St Renan.zip"

SectionEnd     
Section "[OBJ] stalingrad 1942 "

SectionIn 1 3

InetLoad::load /popup "[OBJ] stalingrad 1942 " "http://www.dog-cie.com/map obj/stalingrad1942.zip" "$INSTDIR\stalingrad1942.zip"

ZipDLL::extractfile "$INSTDIR\stalingrad1942.zip" "$INSTDIR\" "stalingrad1942.pk3"

Delete "$INSTDIR\stalingrad1942.zip"

SectionEnd     
Section "[OBJ] Stalingrad 3 "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Stalingrad 3 " "http://www.dog-cie.com/map obj/Stalingrad_3.zip" "$INSTDIR\Stalingrad_3.zip"

ZipDLL::extractfile "$INSTDIR\Stalingrad_3.zip" "$INSTDIR\" "Stalingrad_3.pk3"

Delete "$INSTDIR\Stalingrad_3.zip"

SectionEnd     
Section "[OBJ] Sword beach "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Sword beach " "http://www.dog-cie.com/map obj/user-swordbeach.zip" "$INSTDIR\user-swordbeach.zip"

ZipDLL::extractfile "$INSTDIR\user-swordbeach.zip" "$INSTDIR\" "user-swordbeach.pk3"

Delete "$INSTDIR\user-swordbeach.zip"

SectionEnd     
Section "[OBJ] Teamzero "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Teamzero " "http://www.dog-cie.com/map obj/user_obj_teamzero.zip" "$INSTDIR\user_obj_teamzero.zip"

ZipDLL::extractfile "$INSTDIR\user_obj_teamzero.zip" "$INSTDIR\" "user_obj_teamzero.pk3"

Delete "$INSTDIR\user_obj_teamzero.zip"

SectionEnd     
Section "[OBJ] The cemetary "

SectionIn 1 3

InetLoad::load /popup "[OBJ] The cemetary " "http://www.dog-cie.com/map obj/the_cemetary.zip" "$INSTDIR\the_cemetary.zip"

ZipDLL::extractfile "$INSTDIR\the_cemetary.zip" "$INSTDIR\" "the_cemetary.pk3"

Delete "$INSTDIR\the_cemetary.zip"

SectionEnd     
Section "[OBJ] The Lost Village "

SectionIn 1 3

InetLoad::load /popup "[OBJ] The Lost Village " "http://www.dog-cie.com/map obj/User-TheLostVillage.zip" "$INSTDIR\User-TheLostVillage.zip"

ZipDLL::extractfile "$INSTDIR\User-TheLostVillage.zip" "$INSTDIR\" "User-TheLostVillage.pk3"

Delete "$INSTDIR\User-TheLostVillage.zip"

SectionEnd     
Section "[OBJ] The Villa "

SectionIn 1 3

InetLoad::load /popup "[OBJ] The Villa " "http://www.dog-cie.com/map obj/TheVilla.zip" "$INSTDIR\TheVilla.zip"

ZipDLL::extractfile "$INSTDIR\TheVilla.zip" "$INSTDIR\" "TheVilla.pk3"

Delete "$INSTDIR\TheVilla.zip"

SectionEnd     
Section "[OBJ] Tirtagaine Kechtat III "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Tirtagaine Kechtat III " "http://www.dog-cie.com/map obj/Tirtagaine-KechtatIII.zip" "$INSTDIR\Tirtagaine-KechtatIII.zip"

ZipDLL::extractfile "$INSTDIR\Tirtagaine-KechtatIII.zip" "$INSTDIR\" "Tirtagaine-KechtatIII.pk3"

Delete "$INSTDIR\Tirtagaine-KechtatIII.zip"

SectionEnd     
Section "[OBJ] Under Siege "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Under Siege " "http://www.dog-cie.com/map obj/Under_Siege.zip" "$INSTDIR\Under_Siege.zip"

ZipDLL::extractfile "$INSTDIR\Under_Siege.zip" "$INSTDIR\" "Under_Siege.pk3"

Delete "$INSTDIR\Under_Siege.zip"

SectionEnd     
Section "[OBJ] V2 Shelter "

SectionIn 1 3

InetLoad::load /popup "[OBJ] V2 Shelter " "http://www.dog-cie.com/map obj/V2Shelter.zip" "$INSTDIR\V2Shelter.zip"

ZipDLL::extractfile "$INSTDIR\V2Shelter.zip" "$INSTDIR\" "V2Shelter.pk3"

Delete "$INSTDIR\V2Shelter.zip"

SectionEnd     
Section "[OBJ] V3 lab"

SectionIn 1 3

InetLoad::load /popup "[OBJ] V3 lab" "http://www.dog-cie.com/map obj/User-finalv3lab.zip" "$INSTDIR\User-finalv3lab.zip"

ZipDLL::extractfile "$INSTDIR\User-finalv3lab.zip" "$INSTDIR\" "User-finalv3lab.pk3"

Delete "$INSTDIR\User-finalv3lab.zip"

SectionEnd     
Section "[OBJ] Wuesten kaff"

SectionIn 1 3

InetLoad::load /popup "[OBJ] Wuesten kaff" "http://www.dog-cie.com/map obj/wuesten-kaff-beta9.zip" "$INSTDIR\wuesten-kaff-beta9.zip"

ZipDLL::extractfile "$INSTDIR\wuesten-kaff-beta9.zip" "$INSTDIR\" "wuesten-kaff-beta9.pk3"

Delete "$INSTDIR\wuesten-kaff-beta9.zip"

SectionEnd     
Section "[OBJ] Xfire "

SectionIn 1 3

InetLoad::load /popup "[OBJ] Xfire " "http://www.dog-cie.com/map obj/user-ydiss-xfire.zip" "$INSTDIR\user-ydiss-xfire.zip"

ZipDLL::extractfile "$INSTDIR\user-ydiss-xfire.zip" "$INSTDIR\" "user-ydiss-xfire.pk3"

Delete "$INSTDIR\user-ydiss-xfire.zip"

SectionEnd     
Section "[TDM] African nights"

SectionIn 2 3

InetLoad::load /popup "[TDM] African nights" "http://www.dog-cie.com/map dm/africannightstdm.zip" "$INSTDIR\africannightstdm.zip"

ZipDLL::extractfile "$INSTDIR\africannightstdm.zip" "$INSTDIR\" "africannightstdm.pk3"

Delete "$INSTDIR\africannightstdm.zip"

SectionEnd     
Section "[TDM] Ammo factory "

SectionIn 2 3

InetLoad::load /popup "[TDM] Ammo factory " "http://www.dog-cie.com/map dm/ammo_factory.zip" "$INSTDIR\ammo_factory.zip"

ZipDLL::extractfile "$INSTDIR\ammo_factory.zip" "$INSTDIR\" "ammo_factory.pk3"

Delete "$INSTDIR\ammo_factory.zip"

SectionEnd     
Section "[TDM] Arnhem "

SectionIn 2 3

InetLoad::load /popup "[TDM] Arnhem " "http://www.dog-cie.com/map dm/Arnhem.zip" "$INSTDIR\Arnhem.zip"

ZipDLL::extractfile "$INSTDIR\Arnhem.zip" "$INSTDIR\" "Arnhem.pk3"

Delete "$INSTDIR\Arnhem.zip"

SectionEnd     
Section "[TDM] Bob Carentan "

SectionIn 2 3

InetLoad::load /popup "[TDM] Bob Carentan " "http://www.dog-cie.com/map dm/bob_carentan.zip" "$INSTDIR\bob_carentan.zip"

ZipDLL::extractfile "$INSTDIR\bob_carentan.zip" "$INSTDIR\" "bob_carentan.pk3"

Delete "$INSTDIR\bob_carentan.zip"

SectionEnd     
Section "[TDM] Bombedv "

SectionIn 2 3

InetLoad::load /popup "[TDM] Bombedv " "http://www.dog-cie.com/map dm/Map_AA_bombedv.zip" "$INSTDIR\Map_AA_bombedv.zip"

ZipDLL::extractfile "$INSTDIR\Map_AA_bombedv.zip" "$INSTDIR\" "Map_AA_bombedv.pk3"

Delete "$INSTDIR\Map_AA_bombedv.zip"

SectionEnd     
Section "[TDM] Broken Silence "

SectionIn 2 3

InetLoad::load /popup "[TDM] Broken Silence " "http://www.dog-cie.com/map dm/User-Broken_Silence.zip" "$INSTDIR\User-Broken_Silence.zip"

ZipDLL::extractfile "$INSTDIR\User-Broken_Silence.zip" "$INSTDIR\" "User-Broken_Silence.pk3"

Delete "$INSTDIR\User-Broken_Silence.zip"

SectionEnd     
Section "[TDM] Bsunrise 3 "

SectionIn 2 3

InetLoad::load /popup "[TDM] Bsunrise 3 " "http://www.dog-cie.com/map dm/BSunrise3-3.zip" "$INSTDIR\BSunrise3-3.zip"

ZipDLL::extractfile "$INSTDIR\BSunrise3-3.zip" "$INSTDIR\" "BSunrise3-3.pk3"

Delete "$INSTDIR\BSunrise3-3.zip"

SectionEnd     
Section "[TDM] Bullet train "

SectionIn 2 3

InetLoad::load /popup "[TDM] Bullet train " "http://www.dog-cie.com/map dm/bullettrain.zip" "$INSTDIR\bullettrain.zip"

ZipDLL::extractfile "$INSTDIR\bullettrain.zip" "$INSTDIR\" "bullettrain.pk3"

Delete "$INSTDIR\bullettrain.zip"

SectionEnd     
Section "[TDM] Bunkeranlage V1 "

SectionIn 2 3

InetLoad::load /popup "[TDM] Bunkeranlage V1 " "http://www.dog-cie.com/map dm/AR_Bunkeranlage_V1.zip" "$INSTDIR\AR_Bunkeranlage_V1.zip"

ZipDLL::extractfile "$INSTDIR\AR_Bunkeranlage_V1.zip" "$INSTDIR\" "AR_Bunkeranlage_V1.pk3"

Delete "$INSTDIR\AR_Bunkeranlage_V1.zip"

SectionEnd     
Section "[TDM] Canal "

SectionIn 2 3

InetLoad::load /popup "[TDM] Canal " "http://www.dog-cie.com/map dm/user-obj_canal.zip" "$INSTDIR\user-obj_canal.zip"

ZipDLL::extractfile "$INSTDIR\user-obj_canal.zip" "$INSTDIR\" "user-obj_canal.pk3"

Delete "$INSTDIR\user-obj_canal.zip"

SectionEnd     
Section "[TDM] Canal Town V2 "

SectionIn 2 3

InetLoad::load /popup "[TDM] Canal Town V2 " "http://www.dog-cie.com/map dm/User-CanalTown_V2.zip" "$INSTDIR\User-CanalTown_V2.zip"

ZipDLL::extractfile "$INSTDIR\User-CanalTown_V2.zip" "$INSTDIR\" "User-CanalTown_V2.pk3"

Delete "$INSTDIR\User-CanalTown_V2.zip"

SectionEnd     
Section "[TDM] Casablanca "

SectionIn 2 3

InetLoad::load /popup "[TDM] Casablanca " "http://www.dog-cie.com/map dm/user-casablanca.zip" "$INSTDIR\user-casablanca.zip"

ZipDLL::extractfile "$INSTDIR\user-casablanca.zip" "$INSTDIR\" "user-casablanca.pk3"

Delete "$INSTDIR\user-casablanca.zip"

SectionEnd     
Section "[TDM] Communique "

SectionIn 2 3

InetLoad::load /popup "[TDM] Communique " "http://www.dog-cie.com/map dm/communique.zip" "$INSTDIR\communique.zip"

ZipDLL::extractfile "$INSTDIR\communique.zip" "$INSTDIR\" "communique.pk3"

Delete "$INSTDIR\communique.zip"

SectionEnd     
Section "[TDM] Dorf "

SectionIn 2 3

InetLoad::load /popup "[TDM] Dorf " "http://www.dog-cie.com/map dm/dm_dorf.zip" "$INSTDIR\dm_dorf.zip"

ZipDLL::extractfile "$INSTDIR\dm_dorf.zip" "$INSTDIR\" "dm_dorf.pk3"

Delete "$INSTDIR\dm_dorf.zip"

SectionEnd     
Section "[TDM] Dorf 14 "

SectionIn 2 3

InetLoad::load /popup "[TDM] Dorf 14 " "http://www.dog-cie.com/map dm/dm_dorf14.zip" "$INSTDIR\dm_dorf14.zip"

ZipDLL::extractfile "$INSTDIR\dm_dorf14.zip" "$INSTDIR\" "dm_dorf14.pk3"

Delete "$INSTDIR\dm_dorf14.zip"

SectionEnd     
Section "[TDM] Duenkirchen "

SectionIn 2 3

InetLoad::load /popup "[TDM] Duenkirchen " "http://www.dog-cie.com/map dm/duenkirchen.zip" "$INSTDIR\duenkirchen.zip"

ZipDLL::extractfile "$INSTDIR\duenkirchen.zip" "$INSTDIR\" "duenkirchen.pk3"

Delete "$INSTDIR\duenkirchen.zip"

SectionEnd     
Section "[TDM] Dust "

SectionIn 2 3

InetLoad::load /popup "[TDM] Dust " "http://www.dog-cie.com/map dm/UserW5-MOHDust.zip" "$INSTDIR\UserW5-MOHDust.zip"

ZipDLL::extractfile "$INSTDIR\UserW5-MOHDust.zip" "$INSTDIR\" "UserW5-MOHDust.pk3"

Delete "$INSTDIR\UserW5-MOHDust.zip"

SectionEnd     
Section "[TDM] Fallen Village"

SectionIn 2 3

InetLoad::load /popup "[TDM] Fallen Village" "http://www.dog-cie.com/map dm/User-dm_FallenVillage.zip" "$INSTDIR\User-dm_FallenVillage.zip"

ZipDLL::extractfile "$INSTDIR\User-dm_FallenVillage.zip" "$INSTDIR\" "User-dm_FallenVillage.pk3"

Delete "$INSTDIR\User-dm_FallenVillage.zip"

SectionEnd     
Section "[TDM] Forschungs labor "

SectionIn 2 3

InetLoad::load /popup "[TDM] Forschungs labor " "http://www.dog-cie.com/map dm/user-Forschungslabor.zip" "$INSTDIR\user-Forschungslabor.zip"

ZipDLL::extractfile "$INSTDIR\user-Forschungslabor.zip" "$INSTDIR\" "user-Forschungslabor.pk3"

Delete "$INSTDIR\user-Forschungslabor.zip"

SectionEnd     
Section "[TDM] Gatehouse Assault "

SectionIn 2 3

InetLoad::load /popup "[TDM] Gatehouse Assault " "http://www.dog-cie.com/map dm/SW_dm_Gatehouse_Assault.zip" "$INSTDIR\SW_dm_Gatehouse_Assault.zip"

ZipDLL::extractfile "$INSTDIR\SW_dm_Gatehouse_Assault.zip" "$INSTDIR\" "SW_dm_Gatehouse_Assault.pk3"

Delete "$INSTDIR\SW_dm_Gatehouse_Assault.zip"

SectionEnd     
Section "[TDM] Hitlers farm "

SectionIn 2 3

InetLoad::load /popup "[TDM] Hitlers farm " "http://www.dog-cie.com/map dm/hitlersfarm.zip" "$INSTDIR\hitlersfarm.zip"

ZipDLL::extractfile "$INSTDIR\hitlersfarm.zip" "$INSTDIR\" "hitlersfarm.pk3"

Delete "$INSTDIR\hitlersfarm.zip"

SectionEnd     
Section "[TDM] Italy"

SectionIn 2 3

InetLoad::load /popup "[TDM] Italy" "http://www.dog-cie.com/map dm/italy1.zip" "$INSTDIR\italy1.zip"

ZipDLL::extractfile "$INSTDIR\italy1.zip" "$INSTDIR\" "italy1.pk3"

Delete "$INSTDIR\italy1.zip"

SectionEnd     
Section "[TDM] Las Chotas v2.0 "

SectionIn 2 3

InetLoad::load /popup "[TDM] Las Chotas v2.0 " "http://www.dog-cie.com/map dm/user-ARG- Las Chotas v2.0 DM.zip" "$INSTDIR\user-ARG- Las Chotas v2.0 DM.zip"

ZipDLL::extractfile "$INSTDIR\user-ARG- Las Chotas v2.0 DM.zip" "$INSTDIR\" "user-ARG- Las Chotas v2.0 DM.pk3"

Delete "$INSTDIR\user-ARG- Las Chotas v2.0 DM.zip"

SectionEnd     
Section "[TDM] Last Castle "

SectionIn 2 3

InetLoad::load /popup "[TDM] Last Castle " "http://www.dog-cie.com/map dm/lastcastle1.zip" "$INSTDIR\lastcastle1.zip"

ZipDLL::extractfile "$INSTDIR\lastcastle1.zip" "$INSTDIR\" "lastcastle1.pk3"

Delete "$INSTDIR\lastcastle1.zip"

SectionEnd     
Section "[TDM] Military post "

SectionIn 2 3

InetLoad::load /popup "[TDM] Military post " "http://www.dog-cie.com/map dm/military_post.zip" "$INSTDIR\military_post.zip"

ZipDLL::extractfile "$INSTDIR\military_post.zip" "$INSTDIR\" "military_post.pk3"

Delete "$INSTDIR\military_post.zip"

SectionEnd     
Section "[TDM] Morocco "

SectionIn 2 3

InetLoad::load /popup "[TDM] Morocco " "http://www.dog-cie.com/map dm/user-morocco.zip" "$INSTDIR\user-morocco.zip"

ZipDLL::extractfile "$INSTDIR\user-morocco.zip" "$INSTDIR\" "user-morocco.pk3"

Delete "$INSTDIR\user-morocco.zip"

SectionEnd     
Section "[TDM] Needle "

SectionIn 2 3

InetLoad::load /popup "[TDM] Needle " "http://www.dog-cie.com/map dm/User-tdm_needle.zip" "$INSTDIR\User-tdm_needle.zip"

ZipDLL::extractfile "$INSTDIR\User-tdm_needle.zip" "$INSTDIR\" "User-tdm_needle.pk3"

Delete "$INSTDIR\User-tdm_needle.zip"

SectionEnd     
Section "[TDM] Night battle "

SectionIn 2 3

InetLoad::load /popup "[TDM] Night battle " "http://www.dog-cie.com/map dm/Dmarean-nightbattle.zip" "$INSTDIR\Dmarean-nightbattle.zip"

ZipDLL::extractfile "$INSTDIR\Dmarean-nightbattle.zip" "$INSTDIR\" "Dmarean-nightbattle.pk3"

Delete "$INSTDIR\Dmarean-nightbattle.zip"

SectionEnd     
Section "[TDM] Operation Sealion "

SectionIn 2 3

InetLoad::load /popup "[TDM] Operation Sealion " "http://www.dog-cie.com/map dm/User-OperationSealion.zip" "$INSTDIR\User-OperationSealion.zip"

ZipDLL::extractfile "$INSTDIR\User-OperationSealion.zip" "$INSTDIR\" "User-OperationSealion.pk3"

Delete "$INSTDIR\User-OperationSealion.zip"

SectionEnd     
Section "[TDM] Renverse "

SectionIn 2 3

InetLoad::load /popup "[TDM] Renverse " "http://www.dog-cie.com/map dm/Renverse.zip" "$INSTDIR\Renverse.zip"

ZipDLL::extractfile "$INSTDIR\Renverse.zip" "$INSTDIR\" "Renverse.pk3"

Delete "$INSTDIR\Renverse.zip"

SectionEnd     
Section "[TDM] Route nord "

SectionIn 2 3

InetLoad::load /popup "[TDM] Route nord " "http://www.dog-cie.com/map dm/dm_routenord.zip" "$INSTDIR\dm_routenord.zip"

ZipDLL::extractfile "$INSTDIR\dm_routenord.zip" "$INSTDIR\" "dm_routenord.pk3"

Delete "$INSTDIR\dm_routenord.zip"

SectionEnd     
Section "[TDM] Sandsturm "

SectionIn 2 3

InetLoad::load /popup "[TDM] Sandsturm " "http://www.dog-cie.com/map dm/User-MP_Sandsturm_DM.zip" "$INSTDIR\User-MP_Sandsturm_DM.zip"

ZipDLL::extractfile "$INSTDIR\User-MP_Sandsturm_DM.zip" "$INSTDIR\" "User-MP_Sandsturm_DM.pk3"

Delete "$INSTDIR\User-MP_Sandsturm_DM.zip"

SectionEnd     
Section "[TDM] Small City "

SectionIn 2 3

InetLoad::load /popup "[TDM] Small City " "http://www.dog-cie.com/map dm/SmallCity.zip" "$INSTDIR\SmallCity.zip"

ZipDLL::extractfile "$INSTDIR\SmallCity.zip" "$INSTDIR\" "SmallCity.pk3"

Delete "$INSTDIR\SmallCity.zip"

SectionEnd     
Section "[TDM] Stalingrad 2 "

SectionIn 2 3

InetLoad::load /popup "[TDM] Stalingrad 2 " "http://www.dog-cie.com/map dm/User-Stalingrad2Full.zip" "$INSTDIR\User-Stalingrad2Full.zip"

ZipDLL::extractfile "$INSTDIR\User-Stalingrad2Full.zip" "$INSTDIR\" "User-Stalingrad2Full.pk3"

Delete "$INSTDIR\User-Stalingrad2Full.zip"

SectionEnd     
Section "[TDM] Stalingrad Snow"

SectionIn 2 3

InetLoad::load /popup "[TDM] Stalingrad Snow" "http://www.dog-cie.com/map dm/user-stalingradsnow.zip" "$INSTDIR\user-stalingradsnow.zip"

ZipDLL::extractfile "$INSTDIR\user-stalingradsnow.zip" "$INSTDIR\" "user-stalingradsnow.pk3"

Delete "$INSTDIR\user-stalingradsnow.zip"

SectionEnd     
Section "[TDM] Stalingrad Unbound 2 "

SectionIn 2 3

InetLoad::load /popup "[TDM] Stalingrad Unbound 2 " "http://www.dog-cie.com/map dm/User-Kirby_Stalingrad_Unbound2.zip" "$INSTDIR\User-Kirby_Stalingrad_Unbound2.zip"

ZipDLL::extractfile "$INSTDIR\User-Kirby_Stalingrad_Unbound2.zip" "$INSTDIR\" "User-Kirby_Stalingrad_Unbound2.pk3"

Delete "$INSTDIR\User-Kirby_Stalingrad_Unbound2.zip"

SectionEnd     
Section "[TDM] Strike at Dawn Return To Algiers "

SectionIn 2 3

InetLoad::load /popup "[TDM] Strike at Dawn Return To Algiers " "http://www.dog-cie.com/map dm/Strike_at_Dawn-Return To Algiers.zip" "$INSTDIR\Strike_at_Dawn-Return To Algiers.zip"

ZipDLL::extractfile "$INSTDIR\Strike_at_Dawn-Return To Algiers.zip" "$INSTDIR\" "Strike_at_Dawn-Return To Algiers.pk3"

Delete "$INSTDIR\Strike_at_Dawn-Return To Algiers.zip"

SectionEnd     
Section "[TDM] The Church Final "

SectionIn 2 3

InetLoad::load /popup "[TDM] The Church Final " "http://www.dog-cie.com/map dm/Obj_TheChurch_Final.zip" "$INSTDIR\Obj_TheChurch_Final.zip"

ZipDLL::extractfile "$INSTDIR\Obj_TheChurch_Final.zip" "$INSTDIR\" "Obj_TheChurch_Final.pk3"

Delete "$INSTDIR\Obj_TheChurch_Final.zip"

SectionEnd     
Section "[TDM] The overpass "

SectionIn 2 3

InetLoad::load /popup "[TDM] The overpass " "http://www.dog-cie.com/map dm/the_overpass.zip" "$INSTDIR\the_overpass.zip"

ZipDLL::extractfile "$INSTDIR\the_overpass.zip" "$INSTDIR\" "the_overpass.pk3"

Delete "$INSTDIR\the_overpass.zip"

SectionEnd     
Section "[TDM] Towers "

SectionIn 2 3

InetLoad::load /popup "[TDM] Towers " "http://www.dog-cie.com/map dm/dmarena-towers.zip" "$INSTDIR\dmarena-towers.zip"

ZipDLL::extractfile "$INSTDIR\dmarena-towers.zip" "$INSTDIR\" "dmarena-towers.pk3"

Delete "$INSTDIR\dmarena-towers.zip"

SectionEnd     
Section "[TDM] Toy Soldiers "

SectionIn 2 3

InetLoad::load /popup "[TDM] Toy Soldiers " "http://www.dog-cie.com/map dm/toysoldiers.zip" "$INSTDIR\toysoldiers.zip"

ZipDLL::extractfile "$INSTDIR\toysoldiers.zip" "$INSTDIR\" "toysoldiers.pk3"

Delete "$INSTDIR\toysoldiers.zip"

SectionEnd     
Section "[TDM] Tunisian "

SectionIn 2 3

InetLoad::load /popup "[TDM] Tunisian " "http://www.dog-cie.com/map dm/user-tunisian.zip" "$INSTDIR\user-tunisian.zip"

ZipDLL::extractfile "$INSTDIR\user-tunisian.zip" "$INSTDIR\" "user-tunisian.pk3"

Delete "$INSTDIR\user-tunisian.zip"

SectionEnd     
Section "[TDM] Tunisian sh"

SectionIn 2 3

InetLoad::load /popup "[TDM] Tunisian sh" "http://www.dog-cie.com/map dm/user-tunisian_sh.zip" "$INSTDIR\user-tunisian_sh.zip"

ZipDLL::extractfile "$INSTDIR\user-tunisian_sh.zip" "$INSTDIR\" "user-tunisian_sh.pk3"

Delete "$INSTDIR\user-tunisian_sh.zip"

SectionEnd     
Section "[TDM] Ugcthorn ak "

SectionIn 2 3

InetLoad::load /popup "[TDM] Ugcthorn ak " "http://www.dog-cie.com/map dm/ugcthorn_ak.zip" "$INSTDIR\ugcthorn_ak.zip"

ZipDLL::extractfile "$INSTDIR\ugcthorn_ak.zip" "$INSTDIR\" "ugcthorn_ak.pk3"

Delete "$INSTDIR\ugcthorn_ak.zip"

SectionEnd     
Section "[TDM] Urban sprawl "

SectionIn 2 3

InetLoad::load /popup "[TDM] Urban sprawl " "http://www.dog-cie.com/map dm/urbansprawl.zip" "$INSTDIR\urbansprawl.zip"

ZipDLL::extractfile "$INSTDIR\urbansprawl.zip" "$INSTDIR\" "urbansprawl.pk3"

Delete "$INSTDIR\urbansprawl.zip"

SectionEnd     
Section "[TDM] Vervins "

SectionIn 2 3

InetLoad::load /popup "[TDM] Vervins " "http://www.dog-cie.com/map dm/vervins.zip" "$INSTDIR\vervins.zip"

ZipDLL::extractfile "$INSTDIR\vervins.zip" "$INSTDIR\" "vervins.pk3"

Delete "$INSTDIR\vervins.zip"

SectionEnd     
Section "[TDM] Watten"

SectionIn 2 3

InetLoad::load /popup "[TDM] Watten" "http://www.dog-cie.com/map dm/User_Watten_multi.zip" "$INSTDIR\User_Watten_multi.zip"

ZipDLL::extractfile "$INSTDIR\User_Watten_multi.zip" "$INSTDIR\" "User_Watten_multi.pk3"

Delete "$INSTDIR\User_Watten_multi.zip"

SectionEnd     
Section "[TDM] Weihnachtsmarkt "

SectionIn 2 3

InetLoad::load /popup "[TDM] Weihnachtsmarkt " "http://www.dog-cie.com/map dm/Weihnachtsmarkt.zip" "$INSTDIR\Weihnachtsmarkt.zip"

ZipDLL::extractfile "$INSTDIR\Weihnachtsmarkt.zip" "$INSTDIR\" "Weihnachtsmarkt.pk3"

Delete "$INSTDIR\Weihnachtsmarkt.zip"

SectionEnd     
Section "[TDM] Winterschlaf"

SectionIn 2 3

InetLoad::load /popup "[TDM] Winterschlaf" "http://www.dog-cie.com/map dm/User-MP_Winterschlaf_DM.zip" "$INSTDIR\User-MP_Winterschlaf_DM.zip"

ZipDLL::extractfile "$INSTDIR\User-MP_Winterschlaf_DM.zip" "$INSTDIR\" "User-MP_Winterschlaf_DM.pk3"

Delete "$INSTDIR\User-MP_Winterschlaf_DM.zip"

SectionEnd     
Section "[TDM] Xfire 2vs2 "

SectionIn 2 3

InetLoad::load /popup "[TDM] Xfire 2vs2 " "http://www.dog-cie.com/map dm/user-xfire2v2.zip" "$INSTDIR\user-xfire2v2.zip"

ZipDLL::extractfile "$INSTDIR\user-xfire2v2.zip" "$INSTDIR\" "user-xfire2v2.pk3"

Delete "$INSTDIR\user-xfire2v2.zip"

SectionEnd     
Section "[TDM] Xfire ville "

SectionIn 2 3

InetLoad::load /popup "[TDM] Xfire ville " "http://www.dog-cie.com/map dm/user-ydiss-objxfireville.zip" "$INSTDIR\user-ydiss-objxfireville.zip"

ZipDLL::extractfile "$INSTDIR\user-ydiss-objxfireville.zip" "$INSTDIR\" "user-ydiss-objxfireville.pk3"

Delete "$INSTDIR\user-ydiss-objxfireville.zip"

SectionEnd   
 