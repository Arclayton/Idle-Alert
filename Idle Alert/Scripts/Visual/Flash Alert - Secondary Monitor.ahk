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

; It specifically tells the script to introduce no delay after control commands
	SetControlDelay, -1

; Set the script from exiting automatically when its last thread completes, allowing it to stay running in an idle state
	#Persistent

; Set the script to only interact if the target window activate
	#IfWinActive, ahk_class fenwindow

;*************************************************************************************************************************
; Menu Tray
;*************************************************************************************************************************
	Menu, Tray, Icon, %A_ScriptDir%\Images\Flash.ico
	Menu, Tray, Tip, % "Flash Alert - Secondary Monitor"
;*************************************************************************************************************************
;*************************************************************************************************************************

; Declaration of global variables used throughout the execution of the script
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

;----------------------------------------------- Gui

	WinGet, Previous_ID, ID, A
	Gui, +LastFound
	Gui, % CLICKTHROUGH := "+E0x20"
	WinSet, Transparent, 50
	Gui, -Caption
	Gui, +AlwaysOnTop
	SysGet, vLeft, 76
	SysGet, vTop, 77
	SysGet, vWidth, 78
	SysGet, vHeight, 79
	Gui, Show, x%vLeft% y%vTop% h%A_ScreenHeight% w%A_ScreenWidth%,"AutoHotkeySnapshotApp"
	WinActivate ahk_id %Previous_ID%
	SetTimer, Flash, 500
	Return

;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

;==================================================================
;------------------------------------------------------------------
; Flash Alert
;------------------------------------------------------------------
;==================================================================

;----------------------------------------------- Flash

Flash:
	Gui, Color, 8B0000
	Sleep, 366
	Gui, Color, FFFFFF
	Return

;----------------------------------------------- Exit Application

~LButton::
	SetTimer, Flash, Off
	Gui, Destroy
	ExitApp

~RButton::
	SetTimer, Flash, Off
	Gui, Destroy
	ExitApp