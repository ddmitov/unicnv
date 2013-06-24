OutFile "utf2ansi.exe"
Caption "UTF-8 to ANSI Converter"
SilentInstall silent
Icon "ddmitov.ico"

VIProductVersion "1.0.0.0"
VIAddVersionKey FileDescription "UTF-8 to ANSI Converter"
VIAddVersionKey LegalCopyright "GPL 2"
VIAddVersionKey CompanyName "ddmitov@yahoo.com"
VIAddVersionKey FileVersion "1.0"

# You need two additional NSIS Plugins to your standard NSIS instalation:
# 1. Dialogs v.2.3 by Joel Almeida Garcia aka Lobo Lunar (lobolunarnet@yahoo.com.mx) and
# 2. Unicode v.1.0 by Aleksander Shengalts aka Instructor (Shengalts@mail.ru).
# Compiled with NSIS v.2.23.

# PLEASE NOTE!
# Filename extensions are not automatically added in the "Save Output as ANSI File" dialog box.

!include "defines.nsh"

Section "Main"

Dialogs::Open \
	"All Files (*;*.*)|*;*.*|Text Files (*.txt)|*.txt|HTML files (*.htm;*.html)|*.htm;*.html|" \
	"4" \
	"Select Input UTF-8 File" \
	$EXEDIR \
	${VAR_6}
	StrCmp $6 "0" InputCanceled SelectOutput

SelectOutput:
	Dialogs::Save \
	"All Files (*;*.*)|*;*.*|Text Files (*.txt)|*.txt|HTML files (*.htm;*.html)|*.htm;*.html|" \
	"4" \
	"Save Output as ANSI File" \
	$EXEDIR \
	${VAR_7}
	StrCmp $7 "0" OutputCanceled Convert

Convert:
	#Convert file from UTF-8 to ANSI
	StrCpy $0 "$6"
	StrCpy $1 "$7"
	StrCpy $2 AUTO

	Unicode::FileUnicode2Ansi "$0" "$1" "$2"
	Pop $3
	Goto Success

InputCanceled:
	MessageBox MB_OK|MB_ICONEXCLAMATION|MB_TOPMOST 'No input file was selected.$\nPlease select input file!'
	Goto Exit

OutputCanceled:
	MessageBox MB_OK|MB_ICONEXCLAMATION|MB_TOPMOST `No output file was selected.$\nPlease select output file!`
	Goto Exit

Success:
	MessageBox MB_OK|MB_ICONINFORMATION|MB_TOPMOST `File successfully converted!`
	Goto Exit

Exit:
SectionEnd
