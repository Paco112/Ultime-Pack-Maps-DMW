SetCompressor /FINAL /SOLID bzip2
icon "${NSISDIR}\Contrib\Graphics\UltraModernUI\Icon2.ico"
OutFile "Update.exe"

Function .onInit

InitPluginsDir

KillProcDLL::KillProc "Ultime Pack Maps DMW.exe"

ifFileExists "$PROGRAMFILES\Ultime Pack Maps DMW\info.ini" yes no

yes:

ReadINIStr $1 "$PROGRAMFILES\Ultime Pack Maps DMW\info.ini" "Info" "url"

InetLoad::load /banner "Update" "Downloading ..." "$1" "$PROGRAMFILES\Ultime Pack Maps DMW\Ultime Pack Maps DMW.exe"

delete "$PROGRAMFILES\Ultime Pack Maps DMW\info.ini"

InetLoad::load /banner "http://www.dog-cie.com/Ultime_Pack_Maps_DMW/Download/dl.php?id=End" "$PROGRAMFILES\Ultime Pack Maps DMW\info.ini"

delete "$PROGRAMFILES\Ultime Pack Maps DMW\info.ini"

ExecShell OPEN "$PROGRAMFILES\Ultime Pack Maps DMW\Ultime Pack Maps DMW.exe"

no:

FunctionEnd

section
setautoclose true
sectionend  