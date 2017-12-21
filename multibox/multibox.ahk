; Generic multiboxing script, by [VxE].
   ; To use:
   ; First, open all of the windows that you're going to be using.
   ; Then use the hotkey [Win]+[PgUp] to activate the script.
   ; You may deactivate the script at any time using the hotkey [win]+[PgDn].
   ; Make sure to double-check your window title! It is case sensitive.
WindowTitle = World of Warcraft
   ; Define hotkeys to use for multiboxing.
   ; Undefined keys will behave normally.

   ;w
   ;a
   ;s
   ;d
   ;tab
   ;esc
Hotkeys = ; a list of names of keyboard keys
(
   enter
   space
   LButton
   RButton
   1
   2
   3
   4
   5
   6
   7
   8
   9
   0
   -
   =
   q
   e
   f
   r
   t
   g
)

#UseHook
#Persistent
SetKeyDelay, -1
SetBatchLines, -1
Hotkey, IfWinActive, %WindowTitle%
Hotkey, #PgUp, Toggle, on
Hotkey, #PgDn, Toggle, on
return
Toggle:
onoff := (A_ThisHotkey = "#PgUp") ? "on" : "off"
WinGet, id, List, %WindowTitle%
Hotkey, IfWinActive, %WindowTitle%
Loop, Parse, Hotkeys, `n, `r%A_Space%%A_Tab%
{
   IfInString, A_LoopField, Button, Continue
   IfInString, A_LoopField, Wheel, Continue
   ;Hotkey, %A_LoopField%, HandleKeys, %onoff%
   Hotkey, %A_LoopField%, HandleKeys, %onoff%
   Hotkey, %A_LoopField% Up, HandleKeys, %onoff%
}
return

HandleKeys:
thk := StripModifiers(A_ThisHotkey)
updown := InStr(A_ThisHotkey, " Up") ? " up}" : " down}"
if (InStr(A_ThisHotKey, "Button")) {
   ;button := InStr(A_ThisHotKey, "L") ? LEFT : RIGHT
   CoordMode, Mouse, Relative 
   MouseGetPos, xpos, ypos
   if (InStr(A_ThisHotKey, "L")) {
      Loop, %id%
      ControlClick, X%xpos% Y%ypos%, % "ahk_id " id%A_Index%
      ;ControlClick, %xpos% %ypos%, % "ahk_id " id%A_Index%,,LEFT,,
   }
   else {
      Loop, %id%
      ControlClick, x%xpos% y%ypos%, % "ahk_id " id%A_Index%,,RIGHT,,
   }
}
else {
   Loop, %id%
   ControlSend,, {blind}{%thk%%updown%, % "ahk_id " id%A_Index%
}
return

StripModifiers(keyname) {
   Loop, Parse, keyname, %A_Space%, ~!#$^&*+<>
      return A_LoopField
}

