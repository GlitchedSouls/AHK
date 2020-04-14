;_________________________________________________________
;________________________________________________________|
;                                                        |
; Created by: GlitchedSoul#5555                          |
;             https://github.com/GlitchedSouls           |
;                                                        |
;························································|
; Description: Drops items in OSRS from inventory        |
;              Left to Right and Top to Bottom           |
;              Same way you read                         |
;                                                        |
;························································|
; USAGE: ·Enable Shift-Click Dropping in OSRS            |
;        ·Add to top of YOUR script:                     |
;             SetWorkingDir %A_ScriptDir%                |
;             #Include RandomBezier.ahk                  |
;             #Include InvDrop.ahk                       |
;        ·Call the drop script in YOUR OWN script with:  |
;             InvDrop(N,O)                               |
;        (N should be replaced with the ammount to drop) |
;        (O is Optional and is used to change pattern)   |
;                                                        |
;························································|
; PATTERNS: 0 = Left to right (Default)                  |
;           1 = Top to Bottom                            |
;                                                        |
;························································|
; EXAMPLE: InvDrop(27) ; this will drop everything       |
;                        but the last slot               |
;________________________________________________________|
;________________________________________________________|

InvDrop(x, y:=0) {
    Sleep, 50
    Random, s, 65, 275
    SendEvent {LShift Down}
    ; center of first inventory slot
    X1 := 1477 ;X coordinate -----------------------------------------------------<<<<<<
    Y1 := 769 ;Y coordinate  -----------------------------------------------------<<<<<<
    X2 := 0
    Y2 := 0
    If (y != 1) {
        y:= 0
    }
    Sleep, s
    Loop, %x% {
        X3 := X2 * 42 ;distance from center of 2 slots on the X axis -------------<<<<<<
        Y3 := Y2 * 36 ;distance from center of 2 slots on the Y axis -------------<<<<<<
        Random, g, -13, 13
        Random, h, -13, 13
        Random, j, 100, 250
        Random, k, 85, 140
        Random, l, 95, 190
        Random, m, 9, 19
        SetMouseDelay, m
        RandomBezier(0, 0, X1+X3+g, Y1+Y3+h, "RO T" j " OT10 OB10 OL10 OR10 P3")
        Sleep, k
        Click
        Sleep, l
        If (X2 < 3) && (y == 0) {
            X2++
        } Else If (y == 0) {
            X2 := 0
            Y2++
        } Else If (Y2 < 6) && (y == 1) {
            Y2++
        } Else {
            Y2 := 0
            X2++
        }

    }
    SendEvent {LShift Up}
}
