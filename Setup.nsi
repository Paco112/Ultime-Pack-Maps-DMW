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

  Name "Ultime Pack Maps DMW v1.8.1"
  BrandingText "[Dog-Cie] Paco{112}"
  
  ;Default installation folder

  InstallDir "$PROGRAMFILES\EA GAMES\MOHAA\main"
  InstallDirRegKey HKLM "Software\Ultime_Pack_Maps_DMW" "MAIN"
  

			 		
;--------------------------------

;Interface Settings


  !define MUI_ABORTWARNING
  !define MUI_UNABORTWARNING
  !define MUI_COMPONENTSPAGE_NODESC
  !define MUI_CUSTOMFUNCTION_GUIINIT myGUIInit
  !define MUI_LICENSEPAGE_RADIOBUTTONS
  !define MUI_HEADERIMAGE



;--------------------------------
;Pages

    !define MUI_PAGE_CUSTOMFUNCTION_LEAVE "validateDirectory"
    !insertmacro MUI_PAGE_DIRECTORY
    !define MUI_PAGE_CUSTOMFUNCTION_PRE PreComponents

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
  
  !insertmacro MUI_LANGUAGE "English"
  !insertmacro MUI_LANGUAGE "French"
  
;--------------------------------

Function .onInit

; minimize all fenetres

    FindWindow $0 "Shell_TrayWnd"
    SendMessage $0 ${WM_COMMAND} 415 0

InitPluginsDir

CreateDirectory "$PROGRAMFILES\Ultime Pack Maps DMW\"

File "/oname=$PROGRAMFILES\Ultime Pack Maps DMW\logo.gif" "D:\Mes Projets\Pack Map\logo.gif"
newadvsplash::show /NOUNLOAD 2000 1000 500 -2 /BANNER "$PROGRAMFILES\Ultime Pack Maps DMW\logo.gif"


ReadRegStr $1 HKCU "Software\2015\MOHAA" "basepath"
WriteRegStr HKLM "Software\Ultime_Pack_Maps_DMW" "MAIN" $1\MAIN
ReadRegStr $INSTDIR HKLM "Software\Ultime_Pack_Maps_DMW" "MAIN"


CopyFiles /SILENT "$EXEDIR\Ultime Pack Maps DMW.exe" "$PROGRAMFILES\Ultime Pack Maps DMW\Ultime Pack Maps DMW.exe"
CreateShortCut "$SMPROGRAMS\Ultime Pack Maps DMW.lnk" "$PROGRAMFILES\Ultime Pack Maps DMW\Ultime Pack Maps DMW.exe"
CreateShortCut "$DESKTOP\Ultime Pack Maps DMW.lnk" "$PROGRAMFILES\Ultime Pack Maps DMW\Ultime Pack Maps DMW.exe"

ifFileExists "$PROGRAMFILES\Ultime Pack Maps DMW\skinnedbutton.dll" yes
File "/oname=$PROGRAMFILES\Ultime Pack Maps DMW\skinnedbutton.dll" "D:\Program Files\NSIS\Plugins\skinnedbutton.dll"

yes:
ifFileExists "$PROGRAMFILES\Ultime Pack Maps DMW\Update.exe" yes1
File "/oname=$PROGRAMFILES\Ultime Pack Maps DMW\Update.exe" "D:\Mes Projets\Pack Map\Update.exe"

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

ifFileExists "$DESKTOP\Pk3 Manager.exe" "a1" "a2"
a1:
  SectionSetFlags 0 0
  SectionSetText 0 ""
  Goto a2
a2:

ifFileExists "$INSTDIR\BA_skin_pack1.*k3" "a3" "a4"
a3:
  SectionSetFlags 1 0
  SectionSetText 1 ""
  Goto a4
a4:

ifFileExists "$INSTDIR\Kmarzo-St Renan.*k3" "a5" "a6"
a5:
  SectionSetFlags 2 0
  SectionSetText 2 ""
  Goto a6
a6:

IfFileExists "$INSTDIR\lol_v2_new_3.*k3" "a7" "a8"
a7:
  SectionSetFlags 3 0
  SectionSetText 3 ""
  Goto a8
a8:

IfFileExists "$INSTDIR\monastere.*k3" "a9" "a10"
a9:
  SectionSetFlags 4 0
  SectionSetText 4 ""
  Goto a10
a10:  

IfFileExists "$INSTDIR\obj_howitzer_v1.*k3" "a11" "a12"
a11:
  SectionSetFlags 5 0
  SectionSetText 5 ""
  Goto a12
a12:

IfFileExists "$INSTDIR\Obj_TheChurch_Final.*k3" "a13" "a14"
a13:
  SectionSetFlags 6 0
  SectionSetText 6 ""
  Goto a14
a14:

IfFileExists "$INSTDIR\OpCenter_obj.*k3" "a15" "a16"
a15:
  SectionSetFlags 7 0
  SectionSetText 7 ""
  Goto a16
a16:

IfFileExists "$INSTDIR\user_labeuze.*k3" "a17" "a18"
a17:
  SectionSetFlags 8 0
  SectionSetText 8 ""
  Goto a18
a18:

IfFileExists "$INSTDIR\user_obj_teamzero.*k3" "a19" "a20"
a19:
  SectionSetFlags 9 0
  SectionSetText 9 ""
  Goto a20
a20:

IfFileExists "$INSTDIR\User-dasboot.*k3" "a21" "a22"
a21:
  SectionSetFlags 10 0
  SectionSetText 10 ""
  Goto a22
a22:

IfFileExists "$INSTDIR\User-finalv3lab.*k3" "a23" "a24"
a23:
  SectionSetFlags 11 0
  SectionSetText 11 ""
  Goto a24
a24:

IfFileExists "$INSTDIR\user-obj_canal.*k3" "a25" "a26"
a25:
  SectionSetFlags 12 0
  SectionSetText 12 ""
  Goto a26
a26:

IfFileExists "$INSTDIR\User-obj_FallenVillage.*k3" "a27" "a28"
a27:
  SectionSetFlags 13 0
  SectionSetText 13 ""
  Goto a28
a28:

IfFileExists "$INSTDIR\User-Stlo.*k3" "a29" "a30"
a29:
  SectionSetFlags 14 0
  SectionSetText 14 ""
  Goto a30
a30:

IfFileExists "$INSTDIR\User-TheLostVillage.*k3" "a31" "a32"
a31:
  SectionSetFlags 15 0
  SectionSetText 15 ""
  Goto a32
a32:

IfFileExists "$INSTDIR\user-ydiss-objxfireville.*k3" "a33" "a34"
a33:
  SectionSetFlags 16 0
  SectionSetText 16 ""
  Goto a34
a34:

IfFileExists "$INSTDIR\V2Shelter.*k3" "a35" "a36"
a35:
  SectionSetFlags 17 0
  SectionSetText 17 ""
  Goto a36
a36:

IfFileExists "$INSTDIR\VSUK-AbbeyBeta.*k3" "a37" "a38"
a37:
  SectionSetFlags 18 0
  SectionSetText 18 ""
  Goto a38
a38:

IfFileExists "$INSTDIR\africannights_obj.*k3" "a39" "a40"
a39:
  SectionSetFlags 19 0
  SectionSetText 19 ""
  Goto a40
a40:

IfFileExists "$INSTDIR\assault77.*k3" "a41" "a42"
a41:
  SectionSetFlags 20 0
  SectionSetText 20 ""
  Goto a42
a42:

IfFileExists "$INSTDIR\gloomcove.*k3" "a43" "a44"
a43:
  SectionSetFlags 21 0
  SectionSetText 21 ""
  Goto a44
a44:

IfFileExists "$INSTDIR\lol_clifftop.*k3" "a45" "a46"
a45:
  SectionSetFlags 22 0
  SectionSetText 22 ""
  Goto a46
a46:

IfFileExists "$INSTDIR\obj_bahnhof_steinhude_1939.*k3" "a47" "a48"
a47:
  SectionSetFlags 23 0
  SectionSetText 23 ""
  Goto a48
a48:

IfFileExists "$INSTDIR\user-eder.*k3" "a49" "a50"
a49:
  SectionSetFlags 24 0
  SectionSetText 24 ""
  Goto a50
a50:

IfFileExists "$INSTDIR\User_Laboratory.*k3" "a51" "a52"
a51:
  SectionSetFlags 25 0
  SectionSetText 25 ""
  Goto a52
a52:

IfFileExists "$INSTDIR\Schplatzburg_obj.*k3" "a53" "a54"
a53:
  SectionSetFlags 26 0
  SectionSetText 26 ""
  Goto a54
a54:

IfFileExists "$INSTDIR\User - Aarschot Obj.*k3" "a55" "a56"
a55:
  SectionSetFlags 27 0
  SectionSetText 27 ""
  Goto a56
a56:

IfFileExists "$INSTDIR\Tirtagaine-KechtatIII.*k3" "a57" "a58"
a57:
  SectionSetFlags 28 0
  SectionSetText 28 ""
  Goto a58
a58:

IfFileExists "$INSTDIR\BA_stalingrad.*k3" "a59" "a60"
a59:
  SectionSetFlags 29 0
  SectionSetText 29 ""
  Goto a60
a60:

IfFileExists "$INSTDIR\fortwreck.*k3" "a61" "a62"
a61:
  SectionSetFlags 30 0
  SectionSetText 30 ""
  Goto a62
a62:

IfFileExists "$INSTDIR\OpreaHouse.*k3" "a63" "a64"
a63:
  SectionSetFlags 31 0
  SectionSetText 31 ""
  Goto a64
a64:

IfFileExists "$INSTDIR\push_cityhall.*k3" "a65" "a66"
a65:
  SectionSetFlags 32 0
  SectionSetText 32 ""
  Goto a66
a66:

IfFileExists "$INSTDIR\stalingrad1942.*k3" "a67" "a68"
a67:
  SectionSetFlags 33 0
  SectionSetText 33 ""
  Goto a68
a68:

IfFileExists "$INSTDIR\TheVilla.*k3" "a69" "a70"
a69:
  SectionSetFlags 34 0
  SectionSetText 34 ""
  Goto a70
a70:

IfFileExists "$INSTDIR\Under_Siege.*k3" "a71" "a72"
a71:
  SectionSetFlags 35 0
  SectionSetText 35 ""
  Goto a72
a72:

IfFileExists "$INSTDIR\User - CapturedBase.*k3" "a73" "a74"
a73:
  SectionSetFlags 36 0
  SectionSetText 36 ""
  Goto a74
a74:

IfFileExists "$INSTDIR\user_resistance.*k3" "a75" "a76"
a75:
  SectionSetFlags 37 0
  SectionSetText 37 ""
  Goto a76
a76:

IfFileExists "$INSTDIR\User_Watten_multi.*k3" "a77" "a78"
a77:
  SectionSetFlags 38 0
  SectionSetText 38 ""
  Goto a78
a78:

IfFileExists "$INSTDIR\User-Aftermath.*k3" "a79" "a80"
a79:
  SectionSetFlags 39 0
  SectionSetText 39 ""
  Goto a80
a80:

IfFileExists "$INSTDIR\User-Eaglesnest-Final.*k3" "a81" "a82"
a81:
  SectionSetFlags 40 0
  SectionSetText 40 ""
  Goto a82
a82:

IfFileExists "$INSTDIR\user-obj_lastcastle.*k3" "a83" "a84"
a83:
  SectionSetFlags 41 0
  SectionSetText 41 ""
  Goto a84
a84:

IfFileExists "$INSTDIR\user-swordbeach.*k3" "a85" "a86"
a85:
  SectionSetFlags 42 0
  SectionSetText 42 ""
  Goto a86
a86:

IfFileExists "$INSTDIR\User-obj_maromg.*k3" "a87" "a88"
a87:
  SectionSetFlags 43 0
  SectionSetText 43 ""
  Goto a88
a88:

IfFileExists "$INSTDIR\user-ARG-Hunt.*k3" "a89" "a90"
a89:
  SectionSetFlags 44 0
  SectionSetText 44 ""
  Goto a90
a90:

IfFileExists "$INSTDIR\user-ARG- Las Chotas v2.0 Obj.*k3" "a91" "a92"
a91:
  SectionSetFlags 45 0
  SectionSetText 45 ""
  Goto a92
a92:

IfFileExists "$INSTDIR\user-Las Chotas.*k3" "a93" "a94"
a93:
  SectionSetFlags 46 0
  SectionSetText 46 ""
  Goto a94
a94:

IfFileExists "$INSTDIR\africannightstdm.*k3" "a95" "a96"
a95:
  SectionSetFlags 47 0
  SectionSetText 47 ""
  Goto a96
a96:

IfFileExists "$INSTDIR\ammo_factory.*k3" "a97" "a98"
a97:
  SectionSetFlags 48 0
  SectionSetText 48 ""
  Goto a98
a98:

IfFileExists "$INSTDIR\Angryfields.*k3" "a99" "a100"
a99:
  SectionSetFlags 49 0
  SectionSetText 49 ""
  Goto a100
a100:

IfFileExists "$INSTDIR\AR_Bunkeranlage_V1.*k3" "a101" "a102"
a101:
  SectionSetFlags 50 0
  SectionSetText 50 ""
  Goto a102
a102:

IfFileExists "$INSTDIR\Arnhem.*k3" "a103" "a104"
a103:
  SectionSetFlags 51 0
  SectionSetText 51 ""
  Goto a104
a104:

IfFileExists "$INSTDIR\bob_carentan.*k3" "a105" "a106"
a105:
  SectionSetFlags 52 0
  SectionSetText 52 ""
  Goto a106
a106:

IfFileExists "$INSTDIR\BSunrise3-3.*k3" "a107" "a108"
a107:
  SectionSetFlags 53 0
  SectionSetText 53 ""
  Goto a108
a108:

IfFileExists "$INSTDIR\bullettrain.*k3" "a109" "a110"
a109:
  SectionSetFlags 54 0
  SectionSetText 54 ""
  Goto a110
a110:

IfFileExists "$INSTDIR\communique.*k3" "a111" "a112"
a111:
  SectionSetFlags 55 0
  SectionSetText 55 ""
  Goto a112
a112:

IfFileExists "$INSTDIR\dm_dorf.*k3" "a113" "a114"
a113:
  SectionSetFlags 56 0
  SectionSetText 56 ""
  Goto a114
a114:

IfFileExists "$INSTDIR\dm_dorf14.*k3" "a115" "a116"
a115:
  SectionSetFlags 57 0
  SectionSetText 57 ""
  Goto a116
a116:

IfFileExists "$INSTDIR\dm_routenord.*k3" "a117" "a118"
a117:
  SectionSetFlags 58 0
  SectionSetText 58 ""
  Goto a118
a118:

IfFileExists "$INSTDIR\Dmarean-nightbattle.*k3" "a119" "a120"
a119:
  SectionSetFlags 59 0
  SectionSetText 59 ""
  Goto a120
a120:

IfFileExists "$INSTDIR\dmarena-towers.*k3" "a121" "a122"
a121:
  SectionSetFlags 60 0
  SectionSetText 60 ""
  Goto a122
a122:

IfFileExists "$INSTDIR\dmga2.*k3" "a123" "a124"
a123:
  SectionSetFlags 61 0
  SectionSetText 61 ""
  Goto a124
a124:

IfFileExists "$INSTDIR\duenkirchen.*k3" "a125" "a126"
a125:
  SectionSetFlags 62 0
  SectionSetText 62 ""
  Goto a126
a126:

IfFileExists "$INSTDIR\hitlersfarm.*k3" "a127" "a128"
a127:
  SectionSetFlags 63 0
  SectionSetText 63 ""
  Goto a128
a128:

IfFileExists "$INSTDIR\italy1.*k3" "a129" "a130"
a129:
  SectionSetFlags 64 0
  SectionSetText 64 ""
  Goto a130
a130:

IfFileExists "$INSTDIR\lastcastle1.*k3" "a131" "a132"
a131:
  SectionSetFlags 65 0
  SectionSetText 65 ""
  Goto a132
a132:

IfFileExists "$INSTDIR\Map_AA_bombedv.*k3" "a133" "a134"
a133:
  SectionSetFlags 66 0
  SectionSetText 66 ""
  Goto a134
a134:

IfFileExists "$INSTDIR\military_post.*k3" "a135" "a136"
a135:
  SectionSetFlags 67 0
  SectionSetText 67 ""
  Goto a136
a136:

IfFileExists "$INSTDIR\Renverse.*k3" "a137" "a138"
a137:
  SectionSetFlags 68 0
  SectionSetText 68 ""
  Goto a138
a138:

IfFileExists "$INSTDIR\SmallCity.*k3" "a139" "a140"
a139:
  SectionSetFlags 69 0
  SectionSetText 69 ""
  Goto a140
a140:

IfFileExists "$INSTDIR\Strike_at_Dawn-Return To Algiers.*k3" "a141" "a142"
a141:
  SectionSetFlags 70 0
  SectionSetText 70 ""
  Goto a142
a142:

IfFileExists "$INSTDIR\SW_dm_Gatehouse_Assault.*k3" "a143" "a144"
a143:
  SectionSetFlags 71 0
  SectionSetText 71 ""
  Goto a144
a144:

IfFileExists "$INSTDIR\the_cemetary.*k3" "a145" "a146"
a145:
  SectionSetFlags 72 0
  SectionSetText 72 ""
  Goto a146
a146:

IfFileExists "$INSTDIR\the_overpass.*k3" "a147" "a148"
a147:
  SectionSetFlags 73 0
  SectionSetText 73 ""
  Goto a148
a148:

IfFileExists "$INSTDIR\ugcthorn_ak.*k3" "a149" "a150"
a149:
  SectionSetFlags 74 0
  SectionSetText 74 ""
  Goto a150
a150:

IfFileExists "$INSTDIR\urbansprawl.*k3" "a151" "a152"
a151:
  SectionSetFlags 75 0
  SectionSetText 75 ""
  Goto a152
a152:

IfFileExists "$INSTDIR\User-Broken_Silence.*k3" "a153" "a154"
a153:
  SectionSetFlags 76 0
  SectionSetText 76 ""
  Goto a154
a154:

IfFileExists "$INSTDIR\User-CanalTown_V2.*k3" "a155" "a156"
a155:
  SectionSetFlags 77 0
  SectionSetText 77 ""
  Goto a156
a156:

IfFileExists "$INSTDIR\user-casablanca.*k3" "a157" "a158"
a157:
  SectionSetFlags 78 0
  SectionSetText 78 ""
  Goto a158
a158:

IfFileExists "$INSTDIR\User-Desert-Assault.*k3" "a159" "a160"
a159:
  SectionSetFlags 79 0
  SectionSetText 79 ""
  Goto a160
a160:

IfFileExists "$INSTDIR\User-Despair.*k3" "a161" "a162"
a161:
  SectionSetFlags 80 0
  SectionSetText 80 ""
  Goto a162
a162:

IfFileExists "$INSTDIR\User-dm_FallenVillage.*k3" "a163" "a164"
a163:
  SectionSetFlags 81 0
  SectionSetText 81 ""
  Goto a164
a164:

IfFileExists "$INSTDIR\user-Forschungslabor.*k3" "a165" "a166"
a165:
  SectionSetFlags 82 0
  SectionSetText 82 ""
  Goto a166
a166:

IfFileExists "$INSTDIR\User-Kirby_Stalingrad_Unbound2.*k3" "a167" "a168"
a167:
  SectionSetFlags 83 0
  SectionSetText 83 ""
  Goto a168
a168:

IfFileExists "$INSTDIR\user-morocco.*k3" "a169" "a170"
a169:
  SectionSetFlags 84 0
  SectionSetText 84 ""
  Goto a170
a170:

IfFileExists "$INSTDIR\User-MP_Sandsturm_DM.*k3" "a171" "a172"
a171:
  SectionSetFlags 85 0
  SectionSetText 85 ""
  Goto a172
a172:

IfFileExists "$INSTDIR\User-MP_Winterschlaf_DM.*k3" "a173" "a174"
a173:
  SectionSetFlags 86 0
  SectionSetText 86 ""
  Goto a174
a174:

IfFileExists "$INSTDIR\User-OperationSealion.*k3" "a175" "a176"
a175:
  SectionSetFlags 87 0
  SectionSetText 87 ""
  Goto a176
a176:

IfFileExists "$INSTDIR\user-Snow_Camp.*k3" "a177" "a178"
a177:
  SectionSetFlags 88 0
  SectionSetText 88 ""
  Goto a178
a178:

IfFileExists "$INSTDIR\User-Stalingrad2Full.*k3" "a179" "a180"
a179:
  SectionSetFlags 89 0
  SectionSetText 89 ""
  Goto a180
a180:

IfFileExists "$INSTDIR\user-stalingradsnow.*k3" "a181" "a182"
a181:
  SectionSetFlags 90 0
  SectionSetText 90 ""
  Goto a182
a182:

IfFileExists "$INSTDIR\User-tdm_needle.*k3" "a183" "a184"
a183:
  SectionSetFlags 91 0
  SectionSetText 91 ""
  Goto a184
a184:

IfFileExists "$INSTDIR\user-tunisian.*k3" "a185" "a186"
a185:
  SectionSetFlags 92 0
  SectionSetText 92 ""
  Goto a186
a186:

IfFileExists "$INSTDIR\user-tunisian_sh.*k3" "a187" "a188"
a187:
  SectionSetFlags 93 0
  SectionSetText 93 ""
  Goto a188
a188:

IfFileExists "$INSTDIR\Weihnachtsmarkt.*k3" "a189" "a190"
a189:
  SectionSetFlags 94 0
  SectionSetText 94 ""
  Goto a190
a190:

IfFileExists "$INSTDIR\vervins.*k3" "a191" "a192"
a191:
  SectionSetFlags 95 0
  SectionSetText 95 ""
  Goto a192
a192:

IfFileExists "$INSTDIR\user-ydiss-xfire.*k3" "a193" "a194"
a193:
  SectionSetFlags 96 0
  SectionSetText 96 ""
  Goto a194
a194:

IfFileExists "$INSTDIR\user-xfire2v2.*k3" "a195" "a196"
a195:
  SectionSetFlags 97 0
  SectionSetText 97 ""
  Goto a196
a196:

IfFileExists "$INSTDIR\UserW5-MOHDust.*k3" "a197" "a198"
a197:
  SectionSetFlags 98 0
  SectionSetText 98 ""
  Goto a198
a198:

IfFileExists "$INSTDIR\user-ARG- Las Chotas v2.0 DM.*k3" "a199" "a200"
a199:
  SectionSetFlags 99 0
  SectionSetText 99 ""
  Goto a200
a200:
FunctionEnd
  

Section "Pk3 Manager (Installation sur le Bureau)"
SectionIn 3
IfFileExists "$DESKTOP\Pk3 Manager.exe" end
  InetLoad::load /popup "Pk3 Manager" "http://www.dog-cie.com/telechargement/Pk3 Manager.exe" "$DESKTOP\Pk3 Manager.exe"
end:
SectionEnd


Section "Pack Skins DMW (16 skins)"
SectionIn 3
IfFileExists "$INSTDIR\BA_skin_pack1.*k3" end
  InetLoad::load /popup   "Pack Skins DMW" "http://www.dog-cie.com/telechargement/BA_skin_pack1.zip" "$INSTDIR\BA_skin_pack1.zip"
ZipDLL::extractfile "$INSTDIR\BA_skin_pack1.zip" "$INSTDIR\" "BA_skin_pack1.pk3"
Delete "$INSTDIR\BA_skin_pack1.zip"
end:
SectionEnd


Section "St Renan"
SectionIn 1 3
IfFileExists "$INSTDIR\Kmarzo-St Renan.*k3" end
  InetLoad::load /popup "St Renan" "http://www.dog-cie.com/map obj/Kmarzo-St Renan.zip" "$INSTDIR\Kmarzo-St Renan.zip"
ZipDLL::extractfile "$INSTDIR\Kmarzo-St Renan.zip" "$INSTDIR\" "Kmarzo-St Renan.pk3"
Delete "$INSTDIR\Kmarzo-St Renan.zip"
end:
SectionEnd


Section "lol v2"
SectionIn 1 3
IfFileExists "$INSTDIR\lol_v2_new_3.*k3" end
InetLoad::load /popup   "lol v2" "http://www.dog-cie.com/map obj/lol_v2_new_3.zip" "$INSTDIR\lol_v2_new_3.zip"
ZipDLL::extractfile "$INSTDIR\lol_v2_new_3.zip" "$INSTDIR\" "lol_v2_new_3.pk3"
Delete "$INSTDIR\lol_v2_new_3.zip"    
end:
SectionEnd

Section "Monastere"
SectionIn 1 3
IfFileExists "$INSTDIR\monastere.*k3" end
InetLoad::load /popup   "Monastere" "http://www.dog-cie.com/map obj/monastere.zip" "$INSTDIR\monastere.zip"
ZipDLL::extractfile "$INSTDIR\monastere.zip" "$INSTDIR\" "monastere.pk3"
Delete "$INSTDIR\monastere.zip"    
end:
SectionEnd



Section "Howitzer v1"
SectionIn 1 3
IfFileExists "$INSTDIR\obj_howitzer_v1.*k3" end
InetLoad::load /popup   "Howitzer v1" "http://www.dog-cie.com/map obj/obj_howitzer_v1.zip" "$INSTDIR\obj_howitzer_v1.zip"
ZipDLL::extractfile "$INSTDIR\obj_howitzer_v1.zip" "$INSTDIR\" "obj_howitzer_v1.pk3"
Delete "$INSTDIR\obj_howitzer_v1.zip"
end:
SectionEnd

Section "The Church Final"
SectionIn 1 3
IfFileExists "$INSTDIR\Obj_TheChurch_Final.*k3" end
InetLoad::load /popup  "The Church Final" "http://www.dog-cie.com/map obj/Obj_TheChurch_Final.zip" "$INSTDIR\Obj_TheChurch_Final.zip"
ZipDLL::extractfile "$INSTDIR\Obj_TheChurch_Final.zip" "$INSTDIR\" "Obj_TheChurch_Final.pk3"
Delete "$INSTDIR\Obj_TheChurch_Final.zip" 
end:   
SectionEnd



Section "OpCenter"
SectionIn 1 3
IfFileExists "$INSTDIR\OpCenter_obj.*k3" end
InetLoad::load /popup  "OpCenter" "http://www.dog-cie.com/map obj/OpCenter_obj.zip" "$INSTDIR\OpCenter_obj.zip"
ZipDLL::extractfile "$INSTDIR\OpCenter_obj.zip" "$INSTDIR\" "OpCenter_obj.pk3"
Delete "$INSTDIR\OpCenter_obj.zip"
end:     
SectionEnd



Section "La Beuze"
SectionIn 1 3  
IfFileExists "$INSTDIR\user_labeuze.*k3" end
InetLoad::load /popup  "La Beuze" "http://www.dog-cie.com/map obj/user_labeuze.zip" "$INSTDIR\user_labeuze.zip"
ZipDLL::extractfile "$INSTDIR\user_labeuze.zip" "$INSTDIR\" "user_labeuze.pk3"
Delete "$INSTDIR\user_labeuze.zip"  
end:  
SectionEnd



Section "Team Zero"
SectionIn 1 3 
IfFileExists "$INSTDIR\user_obj_teamzero.*k3" end  
InetLoad::load /popup  "Team Zero" "http://www.dog-cie.com/map obj/user_obj_teamzero.zip" "$INSTDIR\user_obj_teamzero.zip"
ZipDLL::extractfile "$INSTDIR\user_obj_teamzero.zip" "$INSTDIR\" "user_obj_teamzero.pk3"
Delete "$INSTDIR\user_obj_teamzero.zip"  
end: 
SectionEnd



Section "Dasboot"
SectionIn 1 3 
IfFileExists "$INSTDIR\User-dasboot.*k3" end 
InetLoad::load /popup  "Dasboot" "http://www.dog-cie.com/map obj/User-dasboot.zip" "$INSTDIR\User-dasboot.zip"
ZipDLL::extractfile "$INSTDIR\User-dasboot.zip" "$INSTDIR\" "User-dasboot.pk3"
Delete "$INSTDIR\User-dasboot.zip" 
end:    
SectionEnd


Section "Final V3 lab"
SectionIn 1 3
IfFileExists "$INSTDIR\User-finalv3lab.*k3" end
InetLoad::load /popup  "Final V3 lab" "http://www.dog-cie.com/map obj/User-finalv3lab.zip" "$INSTDIR\User-finalv3lab.zip"
ZipDLL::extractfile "$INSTDIR\User-finalv3lab.zip" "$INSTDIR\" "User-finalv3lab.pk3"
Delete "$INSTDIR\User-finalv3lab.zip"  
end:   
SectionEnd



Section "The Canal"
SectionIn 1 3
IfFileExists "$INSTDIR\user-obj_canal.*k3" end
InetLoad::load /popup  "The Canal" "http://www.dog-cie.com/map obj/user-obj_canal.zip" "$INSTDIR\user-obj_canal.zip"
ZipDLL::extractfile "$INSTDIR\user-obj_canal.zip" "$INSTDIR\" "user-obj_canal.pk3"
Delete "$INSTDIR\user-obj_canal.zip"  
end:   
SectionEnd



Section "Fallen Village" 
SectionIn 1 3
IfFileExists "$INSTDIR\User-obj_FallenVillage.*k3" end
InetLoad::load /popup  "Fallen Village" "http://www.dog-cie.com/map obj/User-obj_FallenVillage.zip" "$INSTDIR\User-obj_FallenVillage.zip"
ZipDLL::extractfile "$INSTDIR\User-obj_FallenVillage.zip" "$INSTDIR\" "User-obj_FallenVillage.pk3"
Delete "$INSTDIR\User-obj_FallenVillage.zip" 
end:  
SectionEnd



Section "St lo"
SectionIn 1 3
IfFileExists "$INSTDIR\User-Stlo.*k3" end
InetLoad::load /popup  "St lo" "http://www.dog-cie.com/map obj/User-Stlo.zip" "$INSTDIR\User-Stlo.zip"
ZipDLL::extractfile "$INSTDIR\User-Stlo.zip" "$INSTDIR\" "User-Stlo.pk3"
Delete "$INSTDIR\User-Stlo.zip"      
end:
SectionEnd



Section "The Lost Village"
SectionIn 1 3
IfFileExists "$INSTDIR\User-TheLostVillage.*k3" end
InetLoad::load /popup  "The Lost Village" "http://www.dog-cie.com/map obj/User-TheLostVillage.zip" "$INSTDIR\User-TheLostVillage.zip"
ZipDLL::extractfile "$INSTDIR\User-TheLostVillage.zip" "$INSTDIR\" "User-TheLostVillage.pk3"
Delete "$INSTDIR\User-TheLostVillage.zip"  
end:    
SectionEnd



Section "Fire Ville"
SectionIn 1 3
IfFileExists "$INSTDIR\user-ydiss-objxfireville.*k3" end
InetLoad::load /popup  "Fire Ville" "http://www.dog-cie.com/map obj/user-ydiss-objxfireville.zip" "$INSTDIR\user-ydiss-objxfireville.zip"
ZipDLL::extractfile "$INSTDIR\user-ydiss-objxfireville.zip" "$INSTDIR\" "user-ydiss-objxfireville.pk3"
Delete "$INSTDIR\user-ydiss-objxfireville.zip"  
end:  
SectionEnd



Section "V2 Shelter"
SectionIn 1 3
IfFileExists "$INSTDIR\V2Shelter.*k3" end
InetLoad::load /popup  "V2 Shelter" "http://www.dog-cie.com/map obj/V2Shelter.zip" "$INSTDIR\V2Shelter.zip"
ZipDLL::extractfile "$INSTDIR\V2Shelter.zip" "$INSTDIR\" "V2Shelter.pk3"
Delete "$INSTDIR\V2Shelter.zip" 
end:    
SectionEnd



Section "Abbey Beta"
SectionIn 1 3
IfFileExists "$INSTDIR\VSUK-AbbeyBeta.*k3" end
InetLoad::load /popup  "Abbey Beta" "http://www.dog-cie.com/map obj/VSUK-AbbeyBeta.zip" "$INSTDIR\VSUK-AbbeyBeta.zip"
ZipDLL::extractfile "$INSTDIR\VSUK-AbbeyBeta.zip" "$INSTDIR\" "VSUK-AbbeyBeta.pk3"
Delete "$INSTDIR\VSUK-AbbeyBeta.zip" 
end:
SectionEnd



Section "African Nights"
SectionIn 1 3
IfFileExists "$INSTDIR\africannights_obj.*k3" end
InetLoad::load /popup  "African Nights" "http://www.dog-cie.com/map obj/africannights_obj.zip" "$INSTDIR\africannights_obj.zip"
ZipDLL::extractfile "$INSTDIR\africannights_obj.zip" "$INSTDIR\" "africannights_obj.pk3"
Delete "$INSTDIR\africannights_obj.zip"      
end:
SectionEnd



Section "Assault 77"
SectionIn 1 3
IfFileExists "$INSTDIR\assault77.*k3" end
InetLoad::load /popup  "Assault 77" "http://www.dog-cie.com/map obj/assault77.zip" "$INSTDIR\assault77.zip"
ZipDLL::extractfile "$INSTDIR\assault77.zip" "$INSTDIR\" "assault77.pk3"
Delete "$INSTDIR\assault77.zip" 
end:    
SectionEnd



Section "Gloom Cove"
SectionIn 1 3
IfFileExists "$INSTDIR\gloomcove.*k3" end
InetLoad::load /popup  "Gloom Cove" "http://www.dog-cie.com/map obj/gloomcove.zip" "$INSTDIR\gloomcove.zip"
ZipDLL::extractfile "$INSTDIR\gloomcove.zip" "$INSTDIR\" "gloomcove.pk3"
Delete "$INSTDIR\gloomcove.zip"
end:
SectionEnd



Section "Clifftop"
SectionIn 1 3
IfFileExists "$INSTDIR\lol_clifftop.*k3" end
InetLoad::load /popup  "Clifftop" "http://www.dog-cie.com/map obj/lol_clifftop.zip" "$INSTDIR\lol_clifftop.zip"
ZipDLL::extractfile "$INSTDIR\lol_clifftop.zip" "$INSTDIR\" "lol_clifftop.pk3"
Delete "$INSTDIR\lol_clifftop.zip"
end:     
SectionEnd



Section "Bahnhof Steinhude 1939"
SectionIn 1 3
IfFileExists "$INSTDIR\obj_bahnhof_steinhude_1939.*k3" end
InetLoad::load /popup  "Bahnhof Steinhude 1939" "http://www.dog-cie.com/map obj/obj_bahnhof_steinhude_1939.zip" "$INSTDIR\obj_bahnhof_steinhude_1939.zip"
ZipDLL::extractfile "$INSTDIR\obj_bahnhof_steinhude_1939.zip" "$INSTDIR\" "obj_bahnhof_steinhude_1939.pk3"
Delete "$INSTDIR\obj_bahnhof_steinhude_1939.zip" 
end:
SectionEnd



Section "Eder"
SectionIn 1 3
IfFileExists "$INSTDIR\user-eder.*k3" end
InetLoad::load /popup  "Eder" "http://www.dog-cie.com/map obj/user-eder.zip" "$INSTDIR\user-eder.zip"
ZipDLL::extractfile "$INSTDIR\user-eder.zip" "$INSTDIR\" "user-eder.pk3"
Delete "$INSTDIR\user-eder.zip" 
end:   
SectionEnd



Section "Laboratory" 
SectionIn 1 3
IfFileExists "$INSTDIR\User_Laboratory.*k3" end
InetLoad::load /popup  "Laboratory" "http://www.dog-cie.com/map obj/User_Laboratory.zip" "$INSTDIR\User_Laboratory.zip"
ZipDLL::extractfile "$INSTDIR\User_Laboratory.zip" "$INSTDIR\" "User_Laboratory.pk3"
Delete "$INSTDIR\User_Laboratory.zip"   
end:
SectionEnd



Section "Schplatzburg"
SectionIn 1 3
IfFileExists "$INSTDIR\Schplatzburg_obj.*k3" end
InetLoad::load /popup  "Schplatzburg" "http://www.dog-cie.com/map obj/Schplatzburg_obj.zip" "$INSTDIR\Schplatzburg_obj.zip"
ZipDLL::extractfile "$INSTDIR\Schplatzburg_obj.zip" "$INSTDIR\" "Schplatzburg_obj.pk3"
Delete "$INSTDIR\Schplatzburg_obj.zip"  
end: 
SectionEnd



Section "Aarschot Dam"
SectionIn 1 3
IfFileExists "$INSTDIR\User - Aarschot Obj.*k3" end
InetLoad::load /popup "Aarschot Dam" "http://www.dog-cie.com/map obj/User - Aarschot Obj.zip" "$INSTDIR\User - Aarschot Obj.zip"
ZipDLL::extractfile "$INSTDIR\User - Aarschot Obj.zip" "$INSTDIR\" "User - Aarschot Obj.pk3"
Delete "$INSTDIR\User - Aarschot Obj.zip"  
end: 
SectionEnd



Section "Tirtagaine Kechtat"
SectionIn 1 3
IfFileExists "$INSTDIR\Tirtagaine-KechtatIII.*k3" end
InetLoad::load /popup "Tirtagaine Kechtat" "http://www.dog-cie.com/map obj/Tirtagaine-Kechtat.zip" "$INSTDIR\Tirtagaine-Kechtat.zip"
ZipDLL::extractfile "$INSTDIR\Tirtagaine-Kechtat.zip" "$INSTDIR\" "Tirtagaine-KechtatIII.pk3"
Delete "$INSTDIR\Tirtagaine-Kechtat.zip"   
end:  
SectionEnd




Section "BA Stalingrad"
SectionIn 1 3
IfFileExists "$INSTDIR\BA_stalingrad.*k3" end
InetLoad::load /popup "BA Stalingrad" "http://www.dog-cie.com/map obj/BA_stalingrad.zip" "$INSTDIR\BA_stalingrad.zip"
ZipDLL::extractfile "$INSTDIR\BA_stalingrad.zip" "$INSTDIR\" "BA_stalingrad.pk3"
Delete "$INSTDIR\BA_stalingrad.zip"    
end:
SectionEnd




Section "Fortwreck"
SectionIn 1 3
IfFileExists "$INSTDIR\fortwreck.*k3" end
InetLoad::load /popup "Fortwreck" "http://www.dog-cie.com/map obj/fortwreck.zip" "$INSTDIR\fortwreck.zip"
ZipDLL::extractfile "$INSTDIR\fortwreck.zip" "$INSTDIR\" "fortwreck.pk3"
Delete "$INSTDIR\fortwreck.zip" 
end:    
SectionEnd




Section "Oprea House" 
SectionIn 1 3
IfFileExists "$INSTDIR\OpreaHouse.*k3" end
InetLoad::load /popup "Oprea House" "http://www.dog-cie.com/map obj/OpreaHouse.zip" "$INSTDIR\OpreaHouse.zip"
ZipDLL::extractfile "$INSTDIR\OpreaHouse.zip" "$INSTDIR\" "OpreaHouse.pk3"
Delete "$INSTDIR\OpreaHouse.zip"  
end:    
SectionEnd




Section "Push Cityhall" 
SectionIn 1 3
IfFileExists "$INSTDIR\push_cityhall.*k3" end
InetLoad::load /popup "Push Cityhall" "http://www.dog-cie.com/map obj/push_cityhall.zip" "$INSTDIR\push_cityhall.zip"
ZipDLL::extractfile "$INSTDIR\push_cityhall.zip" "$INSTDIR\" "push_cityhall.pk3"
Delete "$INSTDIR\push_cityhall.zip" 
end:    
SectionEnd




Section "Stalingrad 1942" 
SectionIn 1 3
IfFileExists "$INSTDIR\stalingrad1942.*k3" end
InetLoad::load /popup "Stalingrad 1942" "http://www.dog-cie.com/map obj/stalingrad1942.zip" "$INSTDIR\stalingrad1942.zip"
ZipDLL::extractfile "$INSTDIR\stalingrad1942.zip" "$INSTDIR\" "stalingrad1942.pk3"
Delete "$INSTDIR\stalingrad1942.zip" 
end:    
SectionEnd




Section "The Villa"
SectionIn 1 3
IfFileExists "$INSTDIR\TheVilla.*k3" end
InetLoad::load /popup "The Villa" "http://www.dog-cie.com/map obj/TheVilla.zip" "$INSTDIR\TheVilla.zip"
ZipDLL::extractfile "$INSTDIR\TheVilla.zip" "$INSTDIR\" "TheVilla.pk3"
Delete "$INSTDIR\TheVilla.zip"
end:    
SectionEnd




Section "Under Siege" 
SectionIn 1 3
IfFileExists "$INSTDIR\Under_Siege.*k3" end
InetLoad::load /popup "Under Siege" "http://www.dog-cie.com/map obj/Under_Siege.zip" "$INSTDIR\Under_Siege.zip"
ZipDLL::extractfile "$INSTDIR\Under_Siege.zip" "$INSTDIR\" "Under_Siege.pk3"
Delete "$INSTDIR\Under_Siege.zip" 
end:   
SectionEnd




Section "Captured Base" 
SectionIn 1 3
IfFileExists "$INSTDIR\User - CapturedBase.*k3" end
InetLoad::load /popup "Captured Base" "http://www.dog-cie.com/map obj/User - CapturedBase.zip" "$INSTDIR\User - CapturedBase.zip"
ZipDLL::extractfile "$INSTDIR\User - CapturedBase.zip" "$INSTDIR\" "User - CapturedBase.pk3"
Delete "$INSTDIR\User - CapturedBase.zip"
end:
SectionEnd




Section "Resistance"
SectionIn 1 3
IfFileExists "$INSTDIR\user_resistance.*k3" end
InetLoad::load /popup "Resistance" "http://www.dog-cie.com/map obj/user_resistance.zip" "$INSTDIR\user_resistance.zip"
ZipDLL::extractfile "$INSTDIR\user_resistance.zip" "$INSTDIR\" "user_resistance.pk3"
Delete "$INSTDIR\user_resistance.zip"   
end: 
SectionEnd




Section "Watten" 
SectionIn 1 3
IfFileExists "$INSTDIR\User_Watten_multi.*k3" end
InetLoad::load /popup "Watten" "http://www.dog-cie.com/map obj/User_Watten_multi.zip" "$INSTDIR\User_Watten_multi.zip"
ZipDLL::extractfile "$INSTDIR\User_Watten_multi.zip" "$INSTDIR\" "User_Watten_multi.pk3"
Delete "$INSTDIR\User_Watten_multi.zip"  
end:   
SectionEnd




Section "Aftermath"
SectionIn 1 3
IfFileExists "$INSTDIR\User-Aftermath.*k3" end
InetLoad::load /popup "Aftermath" "http://www.dog-cie.com/map obj/User-Aftermath.zip" "$INSTDIR\User-Aftermath.zip"
ZipDLL::extractfile "$INSTDIR\User-Aftermath.zip" "$INSTDIR\" "User-Aftermath.pk3"
Delete "$INSTDIR\User-Aftermath.zip"
end:  
SectionEnd




Section "Eaglesnest Final"
SectionIn 1 3
IfFileExists "$INSTDIR\User-Eaglesnest-Final.*k3" end
InetLoad::load /popup "Eaglesnest Final" "http://www.dog-cie.com/map obj/User-Eaglesnest-Final.zip" "$INSTDIR\User-Eaglesnest-Final.zip"
ZipDLL::extractfile "$INSTDIR\User-Eaglesnest-Final.zip" "$INSTDIR\" "User-Eaglesnest-Final.pk3"
Delete "$INSTDIR\User-Eaglesnest-Final.zip"   
end:  
SectionEnd




Section "Last castle"
SectionIn 1 3
IfFileExists "$INSTDIR\user-obj_lastcastle.*k3" end
InetLoad::load /popup "Last castle" "http://www.dog-cie.com/map obj/user-obj_lastcastle.zip" "$INSTDIR\user-obj_lastcastle.zip"
ZipDLL::extractfile "$INSTDIR\user-obj_lastcastle.zip" "$INSTDIR\" "user-obj_lastcastle.pk3"
Delete "$INSTDIR\user-obj_lastcastle.zip"
end:     
SectionEnd




Section "Sword beach"
SectionIn 1 3
IfFileExists "$INSTDIR\user-swordbeach.*k3" end
InetLoad::load /popup "Sword beach" "http://www.dog-cie.com/map obj/user-swordbeach.zip" "$INSTDIR\user-swordbeach.zip"
ZipDLL::extractfile "$INSTDIR\user-swordbeach.zip" "$INSTDIR\" "user-swordbeach.pk3"
Delete "$INSTDIR\user-swordbeach.zip"      
end:
SectionEnd




Section "Operation Market Garden"
SectionIn 1 3
IfFileExists "$INSTDIR\User-obj_maromg.*k3" end
InetLoad::load /popup "Operation Market Garden" "http://www.dog-cie.com/map obj/User-obj_maromg.zip" "$INSTDIR\User-obj_maromg.zip"
ZipDLL::extractfile "$INSTDIR\User-obj_maromg.zip" "$INSTDIR\" "User-obj_maromg.pk3"
Delete "$INSTDIR\User-obj_maromg.zip"   
end:   
SectionEnd




Section "ARG Hunt ( DMW Scanner 3 Only )"
SectionIn 1 3
IfFileExists "$INSTDIR\user-ARG-Hunt.*k3" end
InetLoad::load /popup "ARG Hunt" "http://www.dog-cie.com/map obj/user-ARG-Hunt.zip" "$INSTDIR\user-ARG-Hunt.zip"
ZipDLL::extractfile "$INSTDIR\user-ARG-Hunt.zip" "$INSTDIR\" "user-ARG-Hunt.pk3"
Delete "$INSTDIR\user-ARG-Hunt.zip"   
end:   
SectionEnd




Section "Las Chotas v2.0 ( DMW Scanner 3 Only )"
SectionIn 1 3
IfFileExists "$INSTDIR\user-ARG- Las Chotas v2.0 Obj.*k3" end
InetLoad::load /popup "Las Chotas v2.0" "http://www.dog-cie.com/map obj/user-ARG- Las Chotas v2.0 Obj.zip" "$INSTDIR\user-ARG- Las Chotas v2.0 Obj.zip"
ZipDLL::extractfile "$INSTDIR\user-ARG- Las Chotas v2.0 Obj.zip" "$INSTDIR\" "user-ARG- Las Chotas v2.0 Obj.pk3"
Delete "$INSTDIR\user-ARG- Las Chotas v2.0 Obj.zip"    
end:
SectionEnd




Section "Las Chotas ( DMW Scanner 3 Only )"
SectionIn 1 3
IfFileExists "$INSTDIR\user-Las Chotas.*k3" end
InetLoad::load /popup "Las Chotas" "http://www.dog-cie.com/map obj/user-Las Chotas.zip" "$INSTDIR\user-Las Chotas.zip"
ZipDLL::extractfile "$INSTDIR\user-Las Chotas.zip" "$INSTDIR\" "user-Las Chotas.pk3"
Delete "$INSTDIR\user-Las Chotas.zip"   
end:   
SectionEnd



Section "African night"
SectionIn 2 3
IfFileExists "$INSTDIR\africannightstdm.*k3" end
InetLoad::load /popup "African night" "http://www.dog-cie.com/map dm/africannightstdm.zip" "$INSTDIR\africannightstdm.zip"
ZipDLL::extractfile "$INSTDIR\africannightstdm.zip" "$INSTDIR\" "africannightstdm.pk3"
Delete "$INSTDIR\africannightstdm.zip" 
end:     
SectionEnd




Section "Ammo factory"
SectionIn 2 3
IfFileExists "$INSTDIR\ammo_factory.*k3" end
InetLoad::load /popup "Ammo factory" "http://www.dog-cie.com/map dm/ammo_factory.zip" "$INSTDIR\ammo_factory.zip"
ZipDLL::extractfile "$INSTDIR\ammo_factory.zip" "$INSTDIR\" "ammo_factory.pk3"
Delete "$INSTDIR\ammo_factory.zip" 
end:     
SectionEnd




Section "Angry fields"
SectionIn 2 3
IfFileExists "$INSTDIR\Angryfields.*k3" end
InetLoad::load /popup "Angry fields" "http://www.dog-cie.com/map dm/Angryfields.zip" "$INSTDIR\Angryfields.zip"
ZipDLL::extractfile "$INSTDIR\Angryfields.zip" "$INSTDIR\" "Angryfields.pk3"
Delete "$INSTDIR\Angryfields.zip"  
end:    
SectionEnd




Section "Bunkeranlage V1"
SectionIn 2 3
IfFileExists "$INSTDIR\AR_Bunkeranlage_V1.*k3" end
InetLoad::load /popup "Bunkeranlage V1" "http://www.dog-cie.com/map dm/AR_Bunkeranlage_V1.zip" "$INSTDIR\AR_Bunkeranlage_V1.zip"
ZipDLL::extractfile "$INSTDIR\AR_Bunkeranlage_V1.zip" "$INSTDIR\" "AR_Bunkeranlage_V1.pk3"
Delete "$INSTDIR\AR_Bunkeranlage_V1.zip"  
end:    
SectionEnd




Section "Arnhem"
SectionIn 2 3
IfFileExists "$INSTDIR\Arnhem.*k3" end
InetLoad::load /popup "Arnhem" "http://www.dog-cie.com/map dm/Arnhem.zip" "$INSTDIR\Arnhem.zip"
ZipDLL::extractfile "$INSTDIR\Arnhem.zip" "$INSTDIR\" "Arnhem.pk3"
Delete "$INSTDIR\Arnhem.zip"     
end:
SectionEnd




Section "Bob carentan"
SectionIn 2 3
IfFileExists "$INSTDIR\bob_carentan.*k3" end
InetLoad::load /popup "Bob carentan" "http://www.dog-cie.com/map dm/bob_carentan.zip" "$INSTDIR\bob_carentan.zip"
ZipDLL::extractfile "$INSTDIR\bob_carentan.zip" "$INSTDIR\" "bob_carentan.pk3"
Delete "$INSTDIR\bob_carentan.zip" 
end:     
SectionEnd




Section "BSunrise3-3"
SectionIn 2 3
IfFileExists "$INSTDIR\BSunrise3-3.*k3" end
InetLoad::load /popup "BSunrise3-3" "http://www.dog-cie.com/map dm/BSunrise3-3.zip" "$INSTDIR\BSunrise3-3.zip"
ZipDLL::extractfile "$INSTDIR\BSunrise3-3.zip" "$INSTDIR\" "BSunrise3-3.pk3"
Delete "$INSTDIR\BSunrise3-3.zip"  
end:    
SectionEnd




Section "Bullet train"
SectionIn 2 3
IfFileExists "$INSTDIR\bullettrain.*k3" end
InetLoad::load /popup "Bullet train" "http://www.dog-cie.com/map dm/bullettrain.zip" "$INSTDIR\bullettrain.zip"
ZipDLL::extractfile "$INSTDIR\bullettrain.zip" "$INSTDIR\" "bullettrain.pk3"
Delete "$INSTDIR\bullettrain.zip"  
end:    
SectionEnd




Section "Communique"
SectionIn 2 3
IfFileExists "$INSTDIR\communique.*k3" end
InetLoad::load /popup "Communique" "http://www.dog-cie.com/map dm/communique.zip" "$INSTDIR\communique.zip"
ZipDLL::extractfile "$INSTDIR\communique.zip" "$INSTDIR\" "communique.pk3"
Delete "$INSTDIR\communique.zip"  
end:    
SectionEnd




Section "Dorf"
SectionIn 2 3
IfFileExists "$INSTDIR\dm_dorf.*k3" end
InetLoad::load /popup "Dorf" "http://www.dog-cie.com/map dm/dm_dorf.zip" "$INSTDIR\dm_dorf.zip"
ZipDLL::extractfile "$INSTDIR\dm_dorf.zip" "$INSTDIR\" "dm_dorf.pk3"
Delete "$INSTDIR\dm_dorf.zip"   
end:  
SectionEnd




Section "Dorf 14"
SectionIn 2 3
IfFileExists "$INSTDIR\dm_dorf14.*k3" end
InetLoad::load /popup "Dorf 14" "http://www.dog-cie.com/map dm/dm_dorf14.zip" "$INSTDIR\dm_dorf14.zip"
ZipDLL::extractfile "$INSTDIR\dm_dorf14.zip" "$INSTDIR\" "dm_dorf14.pk3"
Delete "$INSTDIR\dm_dorf14.zip" 
end:     
SectionEnd




Section "Route nord"
SectionIn 2 3
IfFileExists "$INSTDIR\dm_routenord.*k3" end
InetLoad::load /popup "Route nord" "http://www.dog-cie.com/map dm/dm_routenord.zip" "$INSTDIR\dm_routenord.zip"
ZipDLL::extractfile "$INSTDIR\dm_routenord.zip" "$INSTDIR\" "dm_routenord.pk3"
Delete "$INSTDIR\dm_routenord.zip"   
end:   
SectionEnd




Section "Arean night battle"
SectionIn 2 3
IfFileExists "$INSTDIR\Dmarean-nightbattle.*k3" end
InetLoad::load /popup "Arean night battle" "http://www.dog-cie.com/map dm/Dmarean-nightbattle.zip" "$INSTDIR\Dmarean-nightbattle.zip"
ZipDLL::extractfile "$INSTDIR\Dmarean-nightbattle.zip" "$INSTDIR\" "Dmarean-nightbattle.pk3"
Delete "$INSTDIR\Dmarean-nightbattle.zip"   
end: 
SectionEnd




Section "Arena towers"
SectionIn 2 3
IfFileExists "$INSTDIR\dmarena-towers.*k3" end
InetLoad::load /popup "Arena towers" "http://www.dog-cie.com/map dm/dmarena-towers.zip" "$INSTDIR\dmarena-towers.zip"
ZipDLL::extractfile "$INSTDIR\dmarena-towers.zip" "$INSTDIR\" "dmarena-towers.pk3"
Delete "$INSTDIR\dmarena-towers.zip"
end:     
SectionEnd




Section "The Fight for Arnhem"
SectionIn 2 3
IfFileExists "$INSTDIR\dmga2.*k3" end
InetLoad::load /popup "dmga2" "http://www.dog-cie.com/map dm/dmga2.zip" "$INSTDIR\dmga2.zip"
ZipDLL::extractfile "$INSTDIR\dmga2.zip" "$INSTDIR\" "dmga2.pk3"
Delete "$INSTDIR\dmga2.zip"
end:    
SectionEnd




Section "duenkirchen"
SectionIn 2 3
IfFileExists "$INSTDIR\duenkirchen.*k3" end
InetLoad::load /popup "duenkirchen" "http://www.dog-cie.com/map dm/duenkirchen.zip" "$INSTDIR\duenkirchen.zip"
ZipDLL::extractfile "$INSTDIR\duenkirchen.zip" "$INSTDIR\" "duenkirchen.pk3"
Delete "$INSTDIR\duenkirchen.zip"  
end:   
SectionEnd




Section "hitlers farm"
SectionIn 2 3
IfFileExists "$INSTDIR\hitlersfarm.*k3" end
InetLoad::load /popup "hitlersfarm" "http://www.dog-cie.com/map dm/hitlersfarm.zip" "$INSTDIR\hitlersfarm.zip"
ZipDLL::extractfile "$INSTDIR\hitlersfarm.zip" "$INSTDIR\" "hitlersfarm.pk3"
Delete "$INSTDIR\hitlersfarm.zip"  
end:   
SectionEnd




Section "Italy"
SectionIn 2 3
IfFileExists "$INSTDIR\italy1.*k3" end
InetLoad::load /popup "Italy " "http://www.dog-cie.com/map dm/italy1.zip" "$INSTDIR\italy1.zip"
ZipDLL::extractfile "$INSTDIR\italy1.zip" "$INSTDIR\" "italy1.pk3"
Delete "$INSTDIR\italy1.zip"     
end:
SectionEnd




Section "last castle"
SectionIn 2 3
IfFileExists "$INSTDIR\lastcastle1.*k3" end
InetLoad::load /popup "last castle" "http://www.dog-cie.com/map dm/lastcastle1.zip" "$INSTDIR\lastcastle1.zip"
ZipDLL::extractfile "$INSTDIR\lastcastle1.zip" "$INSTDIR\" "lastcastle1.pk3"
Delete "$INSTDIR\lastcastle1.zip"  
end:  
SectionEnd




Section "AA bombedv"
SectionIn 2 3
IfFileExists "$INSTDIR\Map_AA_bombedv.*k3" end
InetLoad::load /popup "AA bombedv" "http://www.dog-cie.com/map dm/Map_AA_bombedv.zip" "$INSTDIR\Map_AA_bombedv.zip"
ZipDLL::extractfile "$INSTDIR\Map_AA_bombedv.zip" "$INSTDIR\" "Map_AA_bombedv.pk3"
Delete "$INSTDIR\Map_AA_bombedv.zip" 
end:     
SectionEnd




Section "Military post"
SectionIn 2 3
IfFileExists "$INSTDIR\military_post.*k3" end
InetLoad::load /popup "Military post" "http://www.dog-cie.com/map dm/military_post.zip" "$INSTDIR\military_post.zip"
ZipDLL::extractfile "$INSTDIR\military_post.zip" "$INSTDIR\" "military_post.pk3"
Delete "$INSTDIR\military_post.zip" 
end:    
SectionEnd




Section "Renverse"
SectionIn 2 3
IfFileExists "$INSTDIR\Renverse.*k3" end
InetLoad::load /popup "Renverse" "http://www.dog-cie.com/map dm/Renverse.zip" "$INSTDIR\Renverse.zip"
ZipDLL::extractfile "$INSTDIR\Renverse.zip" "$INSTDIR\" "Renverse.pk3"
Delete "$INSTDIR\Renverse.zip"
end:     
SectionEnd




Section "Small City"
SectionIn 2 3
IfFileExists "$INSTDIR\SmallCity.*k3" end
InetLoad::load /popup "Small City" "http://www.dog-cie.com/map dm/SmallCity.zip" "$INSTDIR\SmallCity.zip"
ZipDLL::extractfile "$INSTDIR\SmallCity.zip" "$INSTDIR\" "SmallCity.pk3"
Delete "$INSTDIR\SmallCity.zip" 
end:    
SectionEnd




Section "Strike at Dawn Return To Algiers"
SectionIn 2 3
IfFileExists "$INSTDIR\Strike_at_Dawn-Return To Algiers.*k3" end
InetLoad::load /popup "Strike at Dawn Return To Algiers" "http://www.dog-cie.com/map dm/Strike_at_Dawn-Return To Algiers.zip" "$INSTDIR\Strike_at_Dawn-Return To Algiers.zip"
ZipDLL::extractfile "$INSTDIR\Strike_at_Dawn-Return To Algiers.zip" "$INSTDIR\" "Strike_at_Dawn-Return To Algiers.pk3"
Delete "$INSTDIR\Strike_at_Dawn-Return To Algiers.zip"  
end:   
SectionEnd




Section "Gatehouse Assault"
SectionIn 2 3
IfFileExists "$INSTDIR\SW_dm_Gatehouse_Assault.*k3" end
InetLoad::load /popup "Gatehouse Assault" "http://www.dog-cie.com/map dm/SW_dm_Gatehouse_Assault.zip" "$INSTDIR\SW_dm_Gatehouse_Assault.zip"
ZipDLL::extractfile "$INSTDIR\SW_dm_Gatehouse_Assault.zip" "$INSTDIR\" "SW_dm_Gatehouse_Assault.pk3"
Delete "$INSTDIR\SW_dm_Gatehouse_Assault.zip"   
end:  
SectionEnd




Section "The cemetary"
SectionIn 2 3
IfFileExists "$INSTDIR\the_cemetary.*k3" end
InetLoad::load /popup "The cemetary" "http://www.dog-cie.com/map dm/the_cemetary.zip" "$INSTDIR\the_cemetary.zip"
ZipDLL::extractfile "$INSTDIR\the_cemetary.zip" "$INSTDIR\" "the_cemetary.pk3"
Delete "$INSTDIR\the_cemetary.zip" 
end:   
SectionEnd




Section "The overpass"
SectionIn 2 3
IfFileExists "$INSTDIR\the_overpass.*k3" end
InetLoad::load /popup "The overpass" "http://www.dog-cie.com/map dm/the_overpass.zip" "$INSTDIR\the_overpass.zip"
ZipDLL::extractfile "$INSTDIR\the_overpass.zip" "$INSTDIR\" "the_overpass.pk3"
Delete "$INSTDIR\the_overpass.zip"  
end:    
SectionEnd




Section "ugcthorn_ak"
SectionIn 2 3
IfFileExists "$INSTDIR\ugcthorn_ak.*k3" end
InetLoad::load /popup "ugcthorn_ak" "http://www.dog-cie.com/map dm/ugcthorn_ak.zip" "$INSTDIR\ugcthorn_ak.zip"
ZipDLL::extractfile "$INSTDIR\ugcthorn_ak.zip" "$INSTDIR\" "ugcthorn_ak.pk3"
Delete "$INSTDIR\ugcthorn_ak.zip"   
end:   
SectionEnd




Section "Urban sprawl"
SectionIn 2 3
IfFileExists "$INSTDIR\urbansprawl.*k3" end
InetLoad::load /popup "Urban sprawl" "http://www.dog-cie.com/map dm/urbansprawl.zip" "$INSTDIR\urbansprawl.zip"
ZipDLL::extractfile "$INSTDIR\urbansprawl.zip" "$INSTDIR\" "urbansprawl.pk3"
Delete "$INSTDIR\urbansprawl.zip" 
end:    
SectionEnd




Section "Broken Silence"
SectionIn 2 3
IfFileExists "$INSTDIR\User-Broken_Silence.*k3" end
InetLoad::load /popup "Broken Silence" "http://www.dog-cie.com/map dm/User-Broken_Silence.zip" "$INSTDIR\User-Broken_Silence.zip"
ZipDLL::extractfile "$INSTDIR\User-Broken_Silence.zip" "$INSTDIR\" "User-Broken_Silence.pk3"
Delete "$INSTDIR\User-Broken_Silence.zip"
end:      
SectionEnd




Section "Canal Town V2"
SectionIn 2 3
IfFileExists "$INSTDIR\User-CanalTown_V2.*k3" end
InetLoad::load /popup "Canal Town V2" "http://www.dog-cie.com/map dm/User-CanalTown_V2.zip" "$INSTDIR\User-CanalTown_V2.zip"
ZipDLL::extractfile "$INSTDIR\User-CanalTown_V2.zip" "$INSTDIR\" "User-CanalTown_V2.pk3"
Delete "$INSTDIR\User-CanalTown_V2.zip"  
end:  
SectionEnd




Section "Casablanca"
SectionIn 2 3
IfFileExists "$INSTDIR\user-casablanca.*k3" end
InetLoad::load /popup "Casablanca" "http://www.dog-cie.com/map dm/user-casablanca.zip" "$INSTDIR\user-casablanca.zip"
ZipDLL::extractfile "$INSTDIR\user-casablanca.zip" "$INSTDIR\" "user-casablanca.pk3"
Delete "$INSTDIR\user-casablanca.zip"  
end:    
SectionEnd




Section "Desert Assault"
SectionIn 2 3
IfFileExists "$INSTDIR\User-Desert-Assault.*k3" end
InetLoad::load /popup "Desert Assault" "http://www.dog-cie.com/map dm/User-Desert-Assault.zip" "$INSTDIR\User-Desert-Assault.zip"
ZipDLL::extractfile "$INSTDIR\User-Desert-Assault.zip" "$INSTDIR\" "User-Desert-Assault.pk3"
Delete "$INSTDIR\User-Desert-Assault.zip"  
end:   
SectionEnd




Section "Despair"
SectionIn 2 3
IfFileExists "$INSTDIR\User-Despair.*k3" end
InetLoad::load /popup "Despair" "http://www.dog-cie.com/map dm/User-Despair.zip" "$INSTDIR\User-Despair.zip"
ZipDLL::extractfile "$INSTDIR\User-Despair.zip" "$INSTDIR\" "User-Despair.pk3"
Delete "$INSTDIR\User-Despair.zip" 
end:    
SectionEnd




Section "Fallen Village"
SectionIn 2 3
IfFileExists "$INSTDIR\User-dm_FallenVillage.*k3" end
InetLoad::load /popup "Fallen Village" "http://www.dog-cie.com/map dm/User-dm_FallenVillage.zip" "$INSTDIR\User-dm_FallenVillage.zip"
ZipDLL::extractfile "$INSTDIR\User-dm_FallenVillage.zip" "$INSTDIR\" "User-dm_FallenVillage.pk3"
Delete "$INSTDIR\User-dm_FallenVillage.zip"  
end: 
SectionEnd




Section "Forschungs labor"
SectionIn 2 3
IfFileExists "$INSTDIR\user-Forschungslabor.*k3" end
InetLoad::load /popup "Forschungs labor" "http://www.dog-cie.com/map dm/user-Forschungslabor.zip" "$INSTDIR\user-Forschungslabor.zip"
ZipDLL::extractfile "$INSTDIR\user-Forschungslabor.zip" "$INSTDIR\" "user-Forschungslabor.pk3"
Delete "$INSTDIR\user-Forschungslabor.zip"
end:     
SectionEnd




Section "Stalingrad Unbound2"
SectionIn 2 3
IfFileExists "$INSTDIR\User-Kirby_Stalingrad_Unbound2.*k3" end
InetLoad::load /popup "Stalingrad Unbound2" "http://www.dog-cie.com/map dm/User-Kirby_Stalingrad_Unbound2.zip" "$INSTDIR\User-Kirby_Stalingrad_Unbound2.zip"
ZipDLL::extractfile "$INSTDIR\User-Kirby_Stalingrad_Unbound2.zip" "$INSTDIR\" "User-Kirby_Stalingrad_Unbound2.pk3"
Delete "$INSTDIR\User-Kirby_Stalingrad_Unbound2.zip" 
end:    
SectionEnd




Section "Morocco"
SectionIn 2 3
IfFileExists "$INSTDIR\user-morocco.*k3" end
InetLoad::load /popup "Morocco" "http://www.dog-cie.com/map dm/user-morocco.zip" "$INSTDIR\user-morocco.zip"
ZipDLL::extractfile "$INSTDIR\user-morocco.zip" "$INSTDIR\" "user-morocco.pk3"
Delete "$INSTDIR\user-morocco.zip" 
end:    
SectionEnd




Section "Sandsturm"
SectionIn 2 3
IfFileExists "$INSTDIR\User-MP_Sandsturm_DM.*k3" end
InetLoad::load /popup "Sandsturm" "http://www.dog-cie.com/map dm/User-MP_Sandsturm_DM.zip" "$INSTDIR\User-MP_Sandsturm_DM.zip"
ZipDLL::extractfile "$INSTDIR\User-MP_Sandsturm_DM.zip" "$INSTDIR\" "User-MP_Sandsturm_DM.pk3"
Delete "$INSTDIR\User-MP_Sandsturm_DM.zip"
end:     
SectionEnd




Section "Winterschlaf DM"
SectionIn 2 3
IfFileExists "$INSTDIR\User-MP_Winterschlaf_DM.*k3" end
InetLoad::load /popup "Winterschlaf DM" "http://www.dog-cie.com/map dm/User-MP_Winterschlaf_DM.zip" "$INSTDIR\User-MP_Winterschlaf_DM.zip"
ZipDLL::extractfile "$INSTDIR\User-MP_Winterschlaf_DM.zip" "$INSTDIR\" "User-MP_Winterschlaf_DM.pk3"
Delete "$INSTDIR\User-MP_Winterschlaf_DM.zip"  
end:   
SectionEnd




Section "Operation Sealion"
SectionIn 2 3
IfFileExists "$INSTDIR\User-OperationSealion.*k3" end
InetLoad::load /popup "Operation Sealion" "http://www.dog-cie.com/map dm/User-OperationSealion.zip" "$INSTDIR\User-OperationSealion.zip"
ZipDLL::extractfile "$INSTDIR\User-OperationSealion.zip" "$INSTDIR\" "User-OperationSealion.pk3"
Delete "$INSTDIR\User-OperationSealion.zip"   
end:
SectionEnd




Section "Snow Camp"
SectionIn 2 3
IfFileExists "$INSTDIR\user-Snow_Camp.*k3" end
InetLoad::load /popup "Snow Camp" "http://www.dog-cie.com/map dm/user-Snow_Camp.zip" "$INSTDIR\user-Snow_Camp.zip"
ZipDLL::extractfile "$INSTDIR\user-Snow_Camp.zip" "$INSTDIR\" "user-Snow_Camp.pk3"
Delete "$INSTDIR\user-Snow_Camp.zip"  
end:   
SectionEnd




Section "Stalingrad 2 Full"
SectionIn 2 3
IfFileExists "$INSTDIR\User-Stalingrad2Full.*k3" end
InetLoad::load /popup "Stalingrad 2 Full" "http://www.dog-cie.com/map dm/User-Stalingrad2Full.zip" "$INSTDIR\User-Stalingrad2Full.zip"
ZipDLL::extractfile "$INSTDIR\User-Stalingrad2Full.zip" "$INSTDIR\" "User-Stalingrad2Full.pk3"
Delete "$INSTDIR\User-Stalingrad2Full.zip" 
end:     
SectionEnd




Section "Stalingrad Snow"
SectionIn 2 3
IfFileExists "$INSTDIR\user-stalingradsnow.*k3" end
InetLoad::load /popup "Stalingrad Snow" "http://www.dog-cie.com/map dm/user-stalingradsnow.zip" "$INSTDIR\user-stalingradsnow.zip"
ZipDLL::extractfile "$INSTDIR\user-stalingradsnow.zip" "$INSTDIR\" "user-stalingradsnow.pk3"
Delete "$INSTDIR\user-stalingradsnow.zip" 
end:    
SectionEnd




Section "Needle"
SectionIn 2 3
IfFileExists "$INSTDIR\User-tdm_needle.*k3" end
InetLoad::load /popup "Needle" "http://www.dog-cie.com/map dm/User-tdm_needle.zip" "$INSTDIR\User-tdm_needle.zip"
ZipDLL::extractfile "$INSTDIR\User-tdm_needle.zip" "$INSTDIR\" "User-tdm_needle.pk3"
Delete "$INSTDIR\User-tdm_needle.zip"   
end: 
SectionEnd




Section "Tunisian"
SectionIn 2 3
IfFileExists "$INSTDIR\user-tunisian.*k3" end
InetLoad::load /popup "Tunisian" "http://www.dog-cie.com/map dm/user-tunisian.zip" "$INSTDIR\user-tunisian.zip"
ZipDLL::extractfile "$INSTDIR\user-tunisian.zip" "$INSTDIR\" "user-tunisian.pk3"
Delete "$INSTDIR\user-tunisian.zip"  
end:   
SectionEnd




Section "Tunisian Sh"
SectionIn 2 3
IfFileExists "$INSTDIR\user-tunisian_sh.*k3" end
InetLoad::load /popup "Tunisian Sh" "http://www.dog-cie.com/map dm/user-tunisian_sh.zip" "$INSTDIR\user-tunisian_sh.zip"
ZipDLL::extractfile "$INSTDIR\user-tunisian_sh.zip" "$INSTDIR\" "user-tunisian_sh.pk3"
Delete "$INSTDIR\user-tunisian_sh.zip" 
end:   
SectionEnd




Section "Weihnachts Markt"
SectionIn 2 3
IfFileExists "$INSTDIR\Weihnachtsmarkt.*k3" end
InetLoad::load /popup "Weihnachts Markt" "http://www.dog-cie.com/map dm/Weihnachtsmarkt.zip" "$INSTDIR\Weihnachtsmarkt.zip"
ZipDLL::extractfile "$INSTDIR\Weihnachtsmarkt.zip" "$INSTDIR\" "Weihnachtsmarkt.pk3"
Delete "$INSTDIR\Weihnachtsmarkt.zip" 
end:   
SectionEnd




Section "Vervins"
SectionIn 2 3
IfFileExists "$INSTDIR\vervins.*k3" end
InetLoad::load /popup "Vervins" "http://www.dog-cie.com/map dm/vervins.zip" "$INSTDIR\vervins.zip"
ZipDLL::extractfile "$INSTDIR\vervins.zip" "$INSTDIR\" "vervins.pk3"
Delete "$INSTDIR\vervins.zip" 
end:   
SectionEnd




Section "Xfire Ville"
SectionIn 2 3
IfFileExists "$INSTDIR\user-ydiss-xfire.*k3" end
InetLoad::load /popup "Xfire" "http://www.dog-cie.com/map dm/user-ydiss-xfire.zip" "$INSTDIR\user-ydiss-xfire.zip"
ZipDLL::extractfile "$INSTDIR\user-ydiss-xfire.zip" "$INSTDIR\" "user-ydiss-xfire.pk3"
Delete "$INSTDIR\user-ydiss-xfire.zip"   
end:   
SectionEnd




Section "Xfire 2vs2"
SectionIn 2 3
IfFileExists "$INSTDIR\user-xfire2v2.*k3" end
InetLoad::load /popup "Xfire" "http://www.dog-cie.com/map dm/user-xfire2v2.zip" "$INSTDIR\user-xfire2v2.zip"
ZipDLL::extractfile "$INSTDIR\user-xfire2v2.zip" "$INSTDIR\" "user-xfire2v2.pk3"
Delete "$INSTDIR\user-xfire2v2.zip"
end:      
SectionEnd




Section "Dust"
SectionIn 2 3
IfFileExists "$INSTDIR\UserW5-MOHDust.*k3" end
InetLoad::load /popup "Dust" "http://www.dog-cie.com/map dm/UserW5-MOHDust.zip" "$INSTDIR\UserW5-MOHDust.zip"
ZipDLL::extractfile "$INSTDIR\UserW5-MOHDust.zip" "$INSTDIR\" "UserW5-MOHDust.pk3"
Delete "$INSTDIR\UserW5-MOHDust.zip" 
end:   
SectionEnd




Section "Las Chotas v2.0 ( DMW Scanner 3 Only )"
SectionIn 2 3
IfFileExists "$INSTDIR\user-ARG- Las Chotas v2.0 DM.*k3" end
InetLoad::load /popup "Las Chotas v2.0" "http://www.dog-cie.com/map dm/user-ARG- Las Chotas v2.0 DM.zip" "$INSTDIR\user-ARG- Las Chotas v2.0 DM.zip"
ZipDLL::extractfile "$INSTDIR\user-ARG- Las Chotas v2.0 DM.zip" "$INSTDIR\" "user-ARG- Las Chotas v2.0 DM.pk3"
Delete "$INSTDIR\user-ARG- Las Chotas v2.0 DM.zip" 
end:    
SectionEnd
