#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

;!!!!!!Put your #Include files above here!!!!!!
localVersion:=4
IniWrite, %localVersion%, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, Version
If FileExist("C:\Users\" A_UserName "\OSRS Script Picker.ini") {
} Else {
    IniWrite, f1, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, HkReload
    IniWrite, f2, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, HkExitApp
    IniWrite, 0, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, Time
    IniWrite, Select One, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, DefaultScript
    IniWrite, 0, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, Adv
}
IniRead, isDisabled, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, UpdateCheckDisabled,0
IniRead, OffsetValue, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, Offset,0
If (isDisabled=1) {
    updateAvailable:="+Hide"
    updateCK:="+Checked"
} else {
    request := comobjcreate("WinHttp.WinHttpRequest.5.1")
    request.open("GET", "https://raw.githubusercontent.com/GlitchedSouls/AHK/master/GUI/version.txt")
    request.send()
    Oversion:=request.responsetext
    StringTrimRight, Oversion, Oversion, 1
    If (Oversion<=localVersion) {
        updateAvailable:="+Hide"
    }
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
IniRead, EnableAdv, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, Adv, 0
If (EnableAdv=0) {
    notEnabled:="+Disabled"
} Else {
    isChecked:="+Checked"
}
IniRead, DefaultScript, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, DefaultScript, Select One
IniRead, Hk, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, HkReload, f1
IniRead, Hk2, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, HkExitApp, f2
IniRead, Time, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, Time, 0
IniRead, version, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, Version
Script1:="Script1" ;Change the name to the skill/activity
Script2:="Script2" ;Change the name to the skill/activity
Script3:="Script3" ;Change the name to the skill/activity
Script4:="Script4" ;Change the name to the skill/activity
Script5:=""
Script6:=""
Script7:=""
Script8:=""
Script9:=""
Script10:=""
Script11:=""
Script12:=""
DDScript:=DefaultScript "||" Script1 "|" Script2 "|" Script3 "|" Script4 ;"|" Script5 ;"|" Script6 ;"|" Script7 ;"|" Script8 ;"|" Script9 ;"|" Script10 ;"|" Script11 ;"|" Script12
                                                                            ;Uncomment the scrripts you want to use
                                                                            ;Comment the scrripts you dont want to use
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Gui -MinimizeBox -MaximizeBox
Gui Add, Edit, x8 y112 w426 h145 +ReadOnly -VScroll +Disabled
Gui Add, Edit, x8 y8 w162 h73 +ReadOnly -VScroll +Disabled
Gui Add, Edit, x192 y8 w241 h73 +ReadOnly -VScroll +Disabled
Gui Add, Edit, x8 y88 w64 h25 +ReadOnly -VScroll +Disabled
Gui Add, Edit, x168 y120 w256 h129 +ReadOnly -VScroll +Disabled
Gui Add, Edit, x168 y120 w256 h25 +ReadOnly -VScroll +Disabled
Gui Add, Edit, x16 y120 w153 h65 +ReadOnly -VScroll +Disabled
Gui Add, Edit, x16 y184 w153 h65 +ReadOnly -VScroll +Disabled
Gui Add, Slider, vOffset gSlider x24 y152 w141 h26 %notEnabled% ToolTipBottom Range-10-10 +0x10, %OffsetValue%
Gui Add, Text, vOffsetText x56 y128 w33 h20 +0x200 %notEnabled%, Offset:
Gui Add, Text, vOffsetValue x96 y128 w43 h23 +0x200 %notEnabled%, %OffsetValue%
Gui Add, CheckBox, vEnableAdv gEnableAdv x16 y93 w52 h16 %isChecked%, Enable
Gui Add, CheckBox, vLogOut x184 y160 w109 h33 %notEnabled%, Attempt log out when timer expires
Gui Add, Text, x304 y152 w2 h91 +0x1 +0x10
Gui Add, Text, vOptions x256 y125 w85 h16 +0x200 %notEnabled% +Center, Options
Gui Add, Button, gHelp x320 y208 w80 h23 +Disabled, &Help!
Gui Add, Text, x16 y16 w75 h23 +0x200, Reload Hotkey:
Gui Add, Text, x16 y48 w75 h23 +0x200, ExitApp Hotkey:
Gui Add, DropDownList, hWndhDDLItems vDDLItems x280 y16 w147, %DDScript% 
Gui Add, Text, x200 y16 w74 h23 +0x200, Script to run:
Gui Add, Text, x200 y48 w74 h23 +0x200, Time to run:
Gui Add, Button, hWndhBtnStart vBtnStart ggBtnStart x24 y264 w80 h23, &Start
Gui Add, Button, hWndhBtnCancel vBtnCancel ggBtnCancel x336 y264 w80 h23, &Cancel
Gui Add, Button, hWndhBtnResetToDefault vBtnResetToDefault ggBtnResetToDefault x224 y264 w104 h23, &Reset to Default
Gui Add, Button, hWndhBtnSaveAsDefault vBtnSaveAsDefault ggBtnSaveAsDefault x112 y264 w104 h23, &Save as Default
Gui Add, CheckBox, vlogging x184 y200 w92 h23 %notEnabled%, Enable Logging
Gui Add, CheckBox, vupdatecheck x312 y160 w104 h33 %notEnabled% %updateCK%, Disable Automatic Update Checks
Gui Add, Text, x48 y192 w41 h18 +0x200, Version:
Gui Add, Text, x96 y192 w38 h19 +0x200, %version%
Gui Add, Hotkey, hWndhHk vHk x112 y16 w49 h21, %Hk%
Gui Add, Hotkey, hWndhHk2 vHk2 x112 y48 w49 h21, %Hk2%
Gui Add, Edit, hWndhEdtValue vEdtValue x280 y48 w74 h22 +Number , %Time%
Gui Add, Link, x48 y216 w85 h18 %updateAvailable%, <a href="https://github.com/GlitchedSouls/AHK">Update Available</a>
Gui Add, Text, x360 y48 w65 h23 +0x200, minutes

Gui Show, w441 h293, OSRS Script Picker by GlitchedSoul
Return

gBtnStart:
Gui,submit
GuiControlGet,Time,,EdtValue
GuiControlGet,DDLItems,,DDLItems
If (DDLItems="Select one") {
    MsgBox,,,You must select a script!
    Gui Show, w441 h293, OSRS Script Picker by GlitchedSoul
    return
}
If (Time>0) {
    Time*=-60000
    SetTimer, TimesUp, %Time%
}
Hotkey, %Hk2%, GuiClosed
Hotkey, %Hk%, GuiReload
GuiControlGet, enableLogging ,, logging
GuiControlGet, OffsetValue ,, Offset
If(enableLogging) {
    GuiControlGet, isChecked ,, EnableAdv
    GuiControlGet, doLogOut ,, LogOut
    FormatTime, localTime
    LogVar:="/////////////////////////////////////////////////START///////////////////////////////////////////////// `n[" localTime "]`n[Settings] Timer: " Time "`n[Settings] Script: " DDLItems "`n[Settings] Reload: " Hk "`n[Settings] ExitApp: " Hk2 "`n[Settings] LogOut: " doLogOut "`n[Settings] Offset: " OffsetValue "`n"
    FileAppend, %LogVar%, C:\Users\%A_UserName%\Desktop\OSRSScriptPicker.log
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Use %OffsetValue% in your scripts/pass into functions if using the Offset options.
If (DDLItems=Script1){
    ;Put a function or script here
}
If (DDLItems=Script2){
    ;Put a function or script here
}
If (DDLItems=Script3){
    ;Put a function or script here
}
If (DDLItems=Script4){
    ;Put a function or script here
}
If (DDLItems=Script5){
    ;Put a function or script here
}
If (DDLItems=Script6){
    ;Put a function or script here
}
If (DDLItems=Script7){
    ;Put a function or script here
}
If (DDLItems=Script8){
    ;Put a function or script here
}
If (DDLItems=Script9){
    ;Put a function or script here
}
If (DDLItems=Script10){
    ;Put a function or script here
}
If (DDLItems=Script11){
    ;Put a function or script here
}
If (DDLItems=Script12){
    ;Put a function or script here
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Return

gBtnResetToDefault:
    Gui,submit,NoHide
    IniRead, Hkini, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, HkReload, f1
    IniRead, Hk2ini, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, HkExitApp, f2
    IniRead, Timeini, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, Time, 0
    IniRead, isChecked, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, Adv, 0
    IniRead, isDisabled, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, UpdateCheckDisabled, 0
    IniRead, OffsetValue, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, Offset, 0
    GuiControl,Enable%isChecked%, updatecheck
    GuiControl,Enable%isChecked%, logging
    GuiControl,Enable%isChecked%, LogOut
    GuiControl,Enable%isChecked%, OffsetText
    GuiControl,Enable%isChecked%, Offset
    GuiControl,Enable%isChecked%, OffsetValue
    GuiControl,Enable%isChecked%, Options
    GuiControl, , EdtValue, %Timeini%
    GuiControl, , EnableAdv, %isChecked%
    GuiControl, , updatecheck, %isDisabled%
    GuiControl, , logging, 0
    GuiControl, , LogOut, 0
    GuiControl, , Offset, %OffsetValue%
    GuiControl, , OffsetValue, %OffsetValue%
    GuiControl, Choose, DDLItems, 1
    GuiControl, , HK, %Hkini% 
    GuiControl, , HK2, %Hk2ini%
    if (isChecked=0)  {
        GuiControl, , logging, 0
        GuiControl, , LogOut, 0
        GuiControl, , Offset, 0
        GuiControl, , OffsetValue, 0
    }
Return

gBtnSaveAsDefault:
    Gui,submit,NoHide
    GuiControlGet,Time,,EdtValue
    GuiControlGet,DDLItems,,DDLItems
    GuiControlGet, isChecked ,, EnableAdv
    GuiControlGet, isDisabled ,, updatecheck
    GuiControlGet, OffsetValue ,, Offset
    IniWrite, %Hk%, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, HkReload
    IniWrite, %Hk2%, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, HkExitApp
    IniWrite, %Time%, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, Time
    IniWrite, %DDLItems%, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, DefaultScript
    IniWrite, %isChecked%, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, Adv
    IniWrite, %isDisabled%, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, UpdateCheckDisabled
    IniWrite, %OffsetValue%, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, Offset
    ToolTip, Saved
    SetTimer, deletetooltip, -2000
Return

EnableAdv:
    Gui,submit,NoHide
    GuiControlGet, isChecked ,, EnableAdv
    GuiControl,Enable%isChecked%, updatecheck
    GuiControl,Enable%isChecked%, logging
    GuiControl,Enable%isChecked%, LogOut
    GuiControl,Enable%isChecked%, OffsetText
    GuiControl,Enable%isChecked%, Offset
    GuiControl,Enable%isChecked%, OffsetValue
    GuiControl,Enable%isChecked%, Options 
    if (isChecked=0)  {
        GuiControl, , logging, 0
        GuiControl, , LogOut, 0
        GuiControl, , Offset, 0
        GuiControl, , OffsetValue, 0
    }
return

Slider:
GuiControlGet, OffsetValue ,, Offset
GuiControl,,OffsetValue,%OffsetValue%
return

deletetooltip:
ToolTip
return

Help:
;https://www.youtube.com/watch?v=dQw4w9WgXcQ
return

TimesUp:
    GuiControlGet, doLogOut ,, LogOut
    if (doLogOut) {
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;logoutfunction goes here:
        ;logout()
        ;DO NOT END WITH A RETURN
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        LogVar:="[Action] Attempting Log Out`n"
        FileAppend, %LogVar%, C:\Users\%A_UserName%\Desktop\OSRSScriptPicker.log
    }
    FormatTime, localTime
    LogVar:="End Time: " localTime "`n/////////////////////////////////////////////////END/////////////////////////////////////////////////`n"
    FileAppend, %LogVar%, C:\Users\%A_UserName%\Desktop\OSRSScriptPicker.log
Reload
return

GuiReload:
    FormatTime, localTime
    LogVar:="End Time: " localTime "`nHotKey Reload Used`n/////////////////////////////////////////////////END/////////////////////////////////////////////////`n"
    FileAppend, %LogVar%, C:\Users\%A_UserName%\Desktop\OSRSScriptPicker.log
Reload
return

gBtnCancel:
GuiClose:
GuiEscape:
ExitApp

GuiClosed:
FormatTime, localTime
LogVar:="End Time: " localTime "`nHotKey ExitApp Used`n/////////////////////////////////////////////////END/////////////////////////////////////////////////`n"
FileAppend, %LogVar%, C:\Users\%A_UserName%\Desktop\OSRSScriptPicker.log
ExitApp