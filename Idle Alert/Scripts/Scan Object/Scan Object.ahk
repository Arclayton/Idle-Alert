; Set the script to exit the previous instance if it is run again while it is already running
	#SingleInstance, Force

; Set the script to use no environment variables
	#NoEnv

; Specifies that the 'Send' command should use the 'SendInput' method for sending keystrokes and mouse clicks
	SendMode, Input

; The script's working directory is the default directory that is used to access files and folders when an absolute path has not been specified
	SetWorkingDir, %A_ScriptDir%

; Set the script to detect and interact with windows that are normally hidden from view
	DetectHiddenWindows, On

; Set the script to run at top speed
	SetBatchLines, -1

;*************************************************************************************************************************
; Menu Tray
;*************************************************************************************************************************
	Menu, Tray, Icon, %A_ScriptDir%\Images\Detective.ico
	Menu, Tray, Tip, % "Scan Object"
;*************************************************************************************************************************
;*************************************************************************************************************************

; Declaration of global variables used throughout the execution of the script
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

;----------------------------------------------- Initialization

; Set Variables
	WinGetPos,X,Y,Width,Height,A
	xPos:=200
	yPos:=300

; Set Sound Effects
	Button_Scan = %A_ScriptDir%\Sound\Button\MP3\Scan.mp3
	Button_Press = %A_ScriptDir%\Sound\Button\MP3\Press.mp3
	Button_Click = %A_ScriptDir%\Sound\Button\MP3\Click.mp3
	Button_Exit = %A_ScriptDir%\Sound\Button\MP3\Exit.mp3

;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

;==================================================================
;------------------------------------------------------------------
; Scan Object
;------------------------------------------------------------------
;==================================================================

;----------------------------------------------- Gui Framework

; Gui Initializing
	Gui New, +AlwaysOnTop +Owner -MinimizeBox, Scan Object
	Gui, Font, s12, Verdana
	Gui, Add, Edit, cBlue w350 R16 ReadOnly +HWNDhEdit vAppend_Scan
; Gui Text Display
	Gui, Font, s13 cDefault Normal, Verdana
	Gui, Add, Text, c8B0000 x15 y340 w350 Border Center vText_Display, Choose an object to scan.
; Gui Button
	Gui, Font, Normal
	Gui, Font, s12, Normal, Verdana
	Gui, Add, Button, x13 y375 w355 h30 gScan_Object_1 Default, Scan Primary Object
	Gui, Add, Button, x13 y+5 w355 h30 gScan_Object_2, Scan Secondary Object
	Gui, Add, Button, x13 y+5 w355 h30 gClear_Clipboard, Clear Clipboard
	Gui, Add, Button, x13 y+30 w355 h30 gCheck_Object, Check Object
	Gui, Add, Button, x13 y+5 w355 h30 gGuiClose, Exit
; Gui Finalize
	Gui, Show, x%xPos% y%yPos% h585 w380
	OnClipboardChange("Update")
	Return

;----------------------------------------------- Update Edit Box

Update(type) 
	{
		Global hEdit
		If (type != 2)
			GuiControl Text, % hEdit, % Clipboard
	}

;----------------------------------------------- Scan Primary Object

Scan_Object_1:
	Gui, Submit, NoHide
	FileDelete, %A_ScriptDir%\Scan.txt
	FileDelete, %A_ScriptDir%\1st Object.txt
	FileAppend, % Append_Scan, %A_ScriptDir%\Scan.txt
	SoundPlay, %Button_Scan%
	Sleep, 150
	FileReadLine, Text_Pick, %A_ScriptDir%\Scan.txt, 5
	FileAppend, % "1"Text_Pick, %A_ScriptDir%\1st Object.txt
	GuiControl, , Text_Display, The primary object has been scanned!
	Gui, Font, s12 cGreen Normal, Verdana
	GuiControl, Font, Text_Display
	Return

;----------------------------------------------- Scan Secondary Object

Scan_Object_2:
	Gui, Submit, NoHide
	FileDelete, %A_ScriptDir%\Scan.txt
	FileDelete, %A_ScriptDir%\2nd Object.txt
	FileAppend, % Append_Scan, %A_ScriptDir%\Scan.txt
	SoundPlay, %Button_Scan%
	Sleep, 150
	FileReadLine, Text_Pick, %A_ScriptDir%\Scan.txt, 5
	FileAppend, % "2"Text_Pick, %A_ScriptDir%\2nd Object.txt
	GuiControl, , Text_Display, The secondary object has been scanned!
	Gui, Font, s12 cGreen Normal, Verdana
	GuiControl, Font, Text_Display
	Return

;----------------------------------------------- Clear Clipboard

Clear_Clipboard:
	Gui, Submit, NoHide
	SoundPlay, %Button_Press%
	Clipboard :=
	GuiControl, , Text_Display, Choose an object to scan.
	Gui, Font, s13 c8B0000 Normal, Verdana
	GuiControl, Font, Text_Display
	Return

;----------------------------------------------- Check Object

Check_Object:
	SoundPlay, %Button_Click%
	FileReadLine, Read_Picked_Object_1, %A_ScriptDir%\1st Object.txt, 1
	FileReadLine, Read_Picked_Object_2, %A_ScriptDir%\2nd Object.txt, 1
	MsgBox, 4096, Picked Object, %Read_Picked_Object_1%`n`n%Read_Picked_Object_2%
	SoundPlay, %Button_Click%
	Return

;----------------------------------------------- Exit Application

GuiClose:
	Gui, Destroy
	SoundPlay, %Button_Exit%
	If WinExist("ahk_exe Find Text.exe")
	{
		APP = %A_ScriptDir%\FindText\Find Text.exe
		WinClose, ahk_exe %APP%
		WinGet, xPID, PID, %APP%
		Process, Close, %xPID%
	}
	Sleep, 666
	ExitApp