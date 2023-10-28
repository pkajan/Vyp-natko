#include <ButtonConstants.au3>
#include <Constants.au3>
#include <Date.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#Region (=== GUI generated with help of GuiBuilderPlus 1.2.0 ===)
Global $APPNAME, $APPVERSION, $APPNAMEZ 
Global $hGUI
Global $currentTime, $newTime
Global $hAddButton, $hSubtractButton, $hTimeInput, $hTimeInputLabel, $hCountdownLabel
Global $hStartButton, $hStopButton, $hExitButton, $Label_1, $Label_2
Global $Button_1h, $Button_2h, $Button_3h, $Button_1h_sub, $Button_2h_sub, $Button_3h_sub
Global $ProgressBARL, $ProgressBARR, $ProgressBAR_text, $Checkbox_killit, $Button_killit
Global $isPaused, $isTurnedOFF, $Progress, $doNOTHING

$APPVERSION = "v6"
$APPNAME = "Vypínatko"
$APPNAMEZ = $APPNAME & " " & $APPVERSION

;minimize to tray stuff
Opt("TrayOnEventMode",1)
Opt("TrayMenuMode",1)
Opt("TrayIconHide", 0)
TraySetOnEvent($TRAY_EVENT_PRIMARYUP,"Event_TRAY_UP")
TraySetState()
TraySetToolTip($APPNAMEZ) ; Set the tooltip for the tray icon
;------------------------------------------------------
; Title...........:	Vypínatko
; Description.....:	Create the main GUI

Func _guiCreate()
	$hGUI = GUICreate($APPNAMEZ, 320, 210, -1, -1)
	$hAddButton = GUICtrlCreateButton("+5 Min", 41, 5, 80, 30)
	GUICtrlSetFont($hAddButton, 12, 700)
	$hSubtractButton = GUICtrlCreateButton("-5 Min", 148, 5, 80, 30)
	GUICtrlSetFont($hSubtractButton, 12, 700)
	$hTimeInput = GUICtrlCreateInput("60", 100, 45, 70, 25, BitOR($ES_CENTER, $ES_NUMBER))
	GUICtrlSetFont($hTimeInput, 12, 700)
	$hTimeInputLabel = GUICtrlCreateLabel("TurnOFF in", 37, 50, 55, 20)
	$hCountdownLabel = GUICtrlCreateLabel("Current time", 106, 75, 180, 20)
	GUICtrlSetFont($hCountdownLabel, 12, 700)
	$Label_2 = GUICtrlCreateLabel("TurnOFF on", 41, 75, 60, 20)
	$hStartButton = GUICtrlCreateButton("Start", 31, 105, 80, 30, $BS_CENTER)
	GUICtrlSetFont($hStartButton, 14, 800) 
	$hStopButton = GUICtrlCreateButton("Stop", 211, 105, 80, 30, $BS_CENTER)
	GUICtrlSetFont($hStopButton, 14, 800) 
	$hExitButton = GUICtrlCreateButton("Exit", 111, 155, 100, 30)
	$Label_1 = GUICtrlCreateLabel("minutes", 180, 50, 41, 16)
	$Button_1h = GUICtrlCreateButton("+1h", 240, 4, 36, 18)
	GUICtrlSetFont($Button_1h, 11, 700)
	$Button_2h = GUICtrlCreateButton("+2h", 240, 24, 36, 18)
	GUICtrlSetFont($Button_2h, 11, 700)
	$Button_3h = GUICtrlCreateButton("+3h", 240, 42, 36, 18)
	GUICtrlSetFont($Button_3h, 11, 700)
	$Button_1h_sub = GUICtrlCreateButton("-1h", 279, 4, 36, 18)
	GUICtrlSetFont($Button_1h_sub, 11, 700)
	$Button_2h_sub = GUICtrlCreateButton("-2h", 279, 24, 36, 18)
	GUICtrlSetFont($Button_2h_sub, 11, 700)
	$Button_3h_sub = GUICtrlCreateButton("-3h", 279, 42, 36, 18)
	GUICtrlSetFont($Button_3h_sub, 11, 700)
						; left, top, width, height
	$ProgressBARL = GUICtrlCreateProgress(15, 190, 125, 16)
	$ProgressBARR = GUICtrlCreateProgress(180, 190, 125, 16)
	$ProgressBAR_text = GUICtrlCreateLabel("%", 145, 190, 30, 16, $SS_CENTER, $WS_EX_TOPMOST)
	GUICtrlSetBkColor($ProgressBAR_text, $GUI_BKCOLOR_TRANSPARENT)
	GUICtrlSetFont($ProgressBAR_text, 11, 700)
	$Checkbox_killit = GUICtrlCreateCheckbox("Kill it?", 233, 140, 60, 16)
	$Button_killit = GUICtrlCreateButton("NOW", 220, 155, 65, 30, $BS_CENTER)
	GUICtrlSetFont($Button_killit, 12, 800)
EndFunc	;==>_guiCreate
#EndRegion (=== GUI generated with help of GuiBuilderPlus 1.2.0 ===)

Func Event_TRAY_UP()
	GUISetState(@SW_Show)
	GUISetState(@SW_RESTORE)
	Opt("TrayIconHide", 1)	
EndFunc

Func Event_TRAY_DOWN()
	GUISetState(@SW_Hide)
	GUISetState(@SW_Minimize)
	Opt("TrayIconHide", 0)	
EndFunc

Func TurnItOFF()
		;MsgBox(0, "Event Message", "TurnItOFF")
		Shutdown(8) ;will turn off PC
EndFunc

Func preventMinusValue()
		If GUICtrlRead($hTimeInput) < 0 Then
			GUICtrlSetData($hTimeInput, 1)
		EndIf
EndFunc

Func disableControls()
	GUICtrlSetStyle($hTimeInput, BitOR($ES_READONLY,$ES_CENTER, $ES_NUMBER)) ;time setting
	GUICtrlSetStyle($hStartButton, BitOR($ES_READONLY, $BS_CENTER, $BS_VCENTER)) ; startbutton
	GUICtrlSetStyle($Button_1h, BitOR($ES_READONLY, $BS_CENTER, $BS_VCENTER))
	GUICtrlSetState($Button_1h, $GUI_DISABLE)
	GUICtrlSetState($Button_2h, $GUI_DISABLE)
	GUICtrlSetState($Button_3h, $GUI_DISABLE)
	GUICtrlSetState($Button_1h_sub, $GUI_DISABLE)
	GUICtrlSetState($Button_2h_sub, $GUI_DISABLE)
	GUICtrlSetState($Button_3h_sub, $GUI_DISABLE)
	GUICtrlSetState($hAddButton, $GUI_DISABLE)
	GUICtrlSetState($hSubtractButton, $GUI_DISABLE)
	GUICtrlSetState($hStartButton, $GUI_DISABLE)
	GUICtrlSetState($hStopButton, $GUI_ENABLE)
	GUICtrlSetState($ProgressBARL, $GUI_SHOW)
	GUICtrlSetState($ProgressBARR, $GUI_SHOW)
	GUICtrlSetState($ProgressBAR_text, $GUI_SHOW)
	$isPaused = True
EndFunc

Func enableControls()
	GUICtrlSetStyle($hTimeInput, BitOR($ES_CENTER, $ES_NUMBER)) ;time setting
	GUICtrlSetStyle($hStartButton, BitOR($BS_CENTER, $BS_VCENTER)) ; startbutton
	GUICtrlSetStyle($Button_1h, BitOR($BS_CENTER, $BS_VCENTER))
	GUICtrlSetState($Button_1h, $GUI_ENABLE)
	GUICtrlSetState($Button_2h, $GUI_ENABLE)
	GUICtrlSetState($Button_3h, $GUI_ENABLE)
	GUICtrlSetState($Button_1h_sub, $GUI_ENABLE)
	GUICtrlSetState($Button_2h_sub, $GUI_ENABLE)
	GUICtrlSetState($Button_3h_sub, $GUI_ENABLE)
	GUICtrlSetState($hAddButton, $GUI_ENABLE)
	GUICtrlSetState($hSubtractButton, $GUI_ENABLE)
	GUICtrlSetState($hStartButton, $GUI_ENABLE)
	GUICtrlSetState($hStopButton, $GUI_DISABLE)
	GUICtrlSetState($ProgressBARL, $GUI_HIDE)
	GUICtrlSetState($ProgressBARR, $GUI_HIDE)
	GUICtrlSetState($ProgressBAR_text, $GUI_HIDE)
	$isPaused = False
EndFunc

;------------------------------------------------------
; Title...........:	_main
; Description.....:	run the main program loop
;------------------------------------------------------
Func _main()
	_guiCreate()
	GUISetState(@SW_SHOWNORMAL)
	GUICtrlSetState($hStopButton, $GUI_DISABLE)
	GUICtrlSetState($ProgressBARL, $GUI_HIDE)
	GUICtrlSetState($ProgressBARR, $GUI_HIDE)
	GUICtrlSetState($ProgressBAR_text, $GUI_HIDE)
	GUICtrlSetState($Button_killit, $GUI_DISABLE)
	
	$isPaused = False
	$isTurnedOFF = False
	Local $hTimer = TimerInit() ; Begin the timer and store the handle in a variable.
	Local $hTimer2 = TimerInit()
	Local $fDiff = 0
	Local $iProgress = 0
	$doNOTHING = true
	Opt("TrayIconHide", 1)
	
	While 1
		$currentTime = _NowCalc() ; Get current time
		$newTime = _DateAdd('n', GUICtrlRead($hTimeInput), $currentTime) ; Add X minutes

		Local $date = _DateTimeFormat($newTime, 2)
		Local $time = _DateTimeFormat($newTime, 5)

		if $isPaused == False Then
			$fDiff = TimerDiff($hTimer)
			If $fDiff >= 300 Then
				GUICtrlSetData($hCountdownLabel, $time & "  (" & $date & ")")
				$hTimer = TimerInit()
			EndIf	
		EndIf
		$StartTime = TimerInit()
		$Duration = GUICtrlRead($hTimeInput) * 60 ; time in seconds (minutes*60)
		$fDiff2 = TimerDiff($hTimer2)
		if $doNOTHING == false Then
			If $fDiff2 >= 1005 Then ;+5 for good measure :D
				$iProgress = $iProgress + 1
				$Progress = $iProgress / $Duration * 100
				
				$hTimer2 = TimerInit()
				if $Progress <= 50 Then
					GUICtrlSetData($ProgressBARL, $Progress*2)
				EndIf
				if $Progress >= 50 Then
					GUICtrlSetData($ProgressBARR, ($Progress-50)*2)
				EndIf

				GUICtrlSetData($ProgressBAR_text, Int($Progress) & "%")

				if $Progress >= 100 And $isTurnedOFF==False Then
					TurnItOFF()
					$isTurnedOFF = True
					enableControls()
					$iProgress = 0
					$Progress = 0
					GUICtrlSetData($ProgressBARL, 0)
					GUICtrlSetData($ProgressBARR, 0)
				EndIf
			EndIf
	EndIf

		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop

			Case $hAddButton
				GUICtrlSetData($hTimeInput, GUICtrlRead($hTimeInput) + 5)

			Case $hSubtractButton
				GUICtrlSetData($hTimeInput, GUICtrlRead($hTimeInput) - 5)
				preventMinusValue()

			Case $hStartButton
				disableControls()
				$doNOTHING = false

			Case $hStopButton
				enableControls()
				$iProgress = 0
				$Progress = 0
				GUICtrlSetData($ProgressBARL, 0)
				GUICtrlSetData($ProgressBARR, 0)
				$doNOTHING = true

			Case $Button_1h
				GUICtrlSetData($hTimeInput, GUICtrlRead($hTimeInput) + 60)

			Case $Button_2h
				GUICtrlSetData($hTimeInput, GUICtrlRead($hTimeInput) + 120)

			Case $Button_3h
				GUICtrlSetData($hTimeInput, GUICtrlRead($hTimeInput) + 180)

			Case $Button_1h_sub
				GUICtrlSetData($hTimeInput, GUICtrlRead($hTimeInput) - 60)
				preventMinusValue()

			Case $Button_2h_sub
				GUICtrlSetData($hTimeInput, GUICtrlRead($hTimeInput) - 120)
				preventMinusValue()

			Case $Button_3h_sub
				GUICtrlSetData($hTimeInput, GUICtrlRead($hTimeInput) - 180)
				preventMinusValue()

			Case $hExitButton
				Exit
				
			Case $Checkbox_killit
				If GUICtrlRead($Checkbox_killit) = $GUI_CHECKED Then
					; If checkbox is checked, enable the button
					GUICtrlSetState($Button_killit, $GUI_ENABLE)
				Else
					; If checkbox is unchecked, disable the button
					GUICtrlSetState($Button_killit, $GUI_DISABLE)
				EndIf 
				
			Case $Button_killit
				TurnItOFF()
				
			Case $GUI_EVENT_MINIMIZE
				; Handle minimize to tray event
				Event_TRAY_DOWN()
				
			Case $GUI_EVENT_RESTORE
				; Handle the window restore event
				Event_TRAY_UP()
				
			Case Else
				;;;
		EndSwitch
				
	WEnd
EndFunc	;==>_main

_main()
