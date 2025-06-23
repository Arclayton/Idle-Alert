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

; Set the script from exiting automatically when its last thread completes, allowing it to stay running in an idle state
	#Persistent

; Set the script to only interact if the target window activate
	#IfWinActive, ahk_class fenwindow

;*************************************************************************************************************************
; Menu Tray
;*************************************************************************************************************************
	Menu, Tray, Icon, %A_ScriptDir%\Images\Speaker.ico
	Menu, Tray, Tip, % "Ocean Waves"
;*************************************************************************************************************************
;*************************************************************************************************************************

; Declaration of global variables used throughout the execution of the script
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

;----------------------------------------------- Initialization

; Set Sound Alert
	Sound_Alert = %A_ScriptDir%\MP3\Ocean Waves.mp3

;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

;==================================================================
;------------------------------------------------------------------
; Sound Alert
;------------------------------------------------------------------
;==================================================================

;----------------------------------------------- Play Sound Alert

; Ocean Waves Alert
	SoundPlay, %Sound_Alert%
	Sleep, 100000
	ExitApp

;----------------------------------------------- Exit Application

~LButton::
	Sleep, 666
	ExitApp

~RButton::
	Sleep, 666
	ExitApp