#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

;!!!!!!Put your #Include files above here!!!!!!
localVersion:=2
IniWrite, %localVersion%, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, Version
If FileExist("C:\Users\" A_UserName "\OSRS Script Picker.ini") {
} Else {
    IniWrite, f1, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, HkReload
    IniWrite, f2, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, HkExitApp
    IniWrite, 0, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, Time
    IniWrite, Select One, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, DefaultScript
}
UrlDownloadToFile,https://raw.githubusercontent.com/GlitchedSouls/AHK/master/GUI/version.txt,C:\Users\%A_UserName%\SPversion.txt
FileReadLine, Oversion, C:\Users\%A_UserName%\SPversion.txt,1
If (Oversion<=localVersion) {
    updateAvailable:="+Hide"
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
IniRead, DefaultScript, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, DefaultScript, Select One
IniRead, Hk, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, HkReload, f1
IniRead, Hk2, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, HkExitApp, f2
IniRead, Time, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, Time, 0
IniRead, version, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, Version
Script1:="WC" ;Change the name to the skill/activity
Script2:="FM" ;Change the name to the skill/activity
Script3:="Fletching" ;Change the name to the skill/activity
Script4:="GlassBlowing" ;Change the name to the skill/activity
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
Gui Add, Slider, x24 y152 w141 h26 +Disabled +0x10, 50
Gui Add, Text, x56 y128 w33 h20 +0x200 +Disabled, Offset:
Gui Add, Text, x96 y128 w43 h23 +0x200 +Disabled, 0
Gui Add, CheckBox, x16 y93 w52 h16 +Disabled, Enable
Gui Add, CheckBox, x184 y160 w109 h33 +Disabled, Attempt log out when timer expires
Gui Add, Text, x304 y152 w2 h91 +0x1 +0x10
Gui Add, Text, x256 y125 w85 h16 +0x200 +Disabled +Center, Options
Gui Add, Button, x320 y208 w80 h23 +Disabled, &Help!
Gui Add, Text, x16 y16 w75 h23 +0x200, Reload Hotkey:
Gui Add, Text, x16 y48 w75 h23 +0x200, ExitApp Hotkey:
Gui Add, DropDownList, hWndhDDLItems vDDLItems x280 y16 w147, %DDScript% 
Gui Add, Text, x200 y16 w74 h23 +0x200, Script to run:
Gui Add, Text, x200 y48 w74 h23 +0x200, Time to run:
Gui Add, Button, hWndhBtnStart vBtnStart ggBtnStart x24 y264 w80 h23, &Start
Gui Add, Button, hWndhBtnCancel vBtnCancel ggBtnCancel x336 y264 w80 h23, &Cancel
Gui Add, Button, hWndhBtnResetToDefault vBtnResetToDefault ggBtnResetToDefault x224 y264 w104 h23, &Reset to Default
Gui Add, Button, hWndhBtnSaveAsDefault vBtnSaveAsDefault ggBtnSaveAsDefault x112 y264 w104 h23, &Save as Default
Gui Add, CheckBox, x184 y200 w92 h23 +Disabled, Enable Logging
Gui Add, CheckBox, x312 y160 w104 h33 +Disabled, Disable Automatic Update Checks
Gui Add, Text, x48 y192 w41 h18 +0x200, Version:
Gui Add, Text, x96 y192 w38 h19 +0x200, %version%
Gui Add, Hotkey, hWndhHk vHk x112 y16 w49 h21, %Hk%
Gui Add, Hotkey, hWndhHk2 vHk2 x112 y48 w49 h21, %Hk2%
Gui Add, Edit, hWndhEdtValue vEdtValue x280 y48 w146 h22 +Number, %Time%
Gui Add, Link, x48 y216 w85 h18 %updateAvailable%, <a href="https://github.com/GlitchedSouls/AHK">Update Available</a>
Gui Show, w441 h293, OSRS Script Picker by GlitchedSoul
Return

gBtnStart:
Gui,submit
GuiControlGet,Time,,EdtValue
GuiControlGet,DDLItems,,DDLItems
If (DDLItems="Select one") {
    MsgBox,,,You must select a script!
    Gui Show, w440 h127, OSRS Script Picker by GlitchedSoul
    return
}
If (Time<0) {
    Time*=-60000
    SetTimer, GuiReload, %Time%
}
Hotkey, %Hk2%, GuiClose
Hotkey, %Hk%, GuiReload

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
Goto, GuiReload
Return

gBtnResetToDefault:
    Gui,submit,NoHide
    IniRead, Hkini, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, HkReload, f1
    IniRead, Hk2ini, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, HkExitApp, f2
    IniRead, Timeini, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, Time, 0
    GuiControl, , EdtValue, %Timeini%
    GuiControl, Choose, DDLItems, 1
    GuiControl, , HK, %Hkini%
    GuiControl, , HK2, %Hk2ini%
Return

gBtnSaveAsDefault:
    Gui,submit,NoHide
    GuiControlGet,Time,,EdtValue
    GuiControlGet,DDLItems,,DDLItems
    IniWrite, %Hk%, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, HkReload
    IniWrite, %Hk2%, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, HkExitApp
    IniWrite, %Time%, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, Time
    IniWrite, %DDLItems%, C:\Users\%A_UserName%\OSRS Script Picker.ini, Options, DefaultScript
    ToolTip, Saved
    SetTimer, deletetooltip, 2000
Return

deletetooltip:
ToolTip
return

GuiReload:
Reload

gBtnCancel:
GuiEscape:
GuiClose:
    ExitApp