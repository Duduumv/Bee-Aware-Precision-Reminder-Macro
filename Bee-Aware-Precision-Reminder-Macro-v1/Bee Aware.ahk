#Persistent
global tempoRestante := 0
global rodando := false
global Audiorefresh := 1
global Audiorunout := 1
global AbaAberta := false

global VolAlerta := 50
global VolRefresh := 30
global VolRunout := 50

SetWorkingDir %A_ScriptDir%
OnMessage(0x0201, "ArrastarJanela")

Gui, +AlwaysOnTop -Caption +ToolWindow +Border
Gui, Color, 151515

Gui, Font, s12 c8F4EB4 bold, Segoe UI
Gui, Add, Text, x0 y17 w200 Center, Precision Reminder
Gui, Font, s10 cGray bold, Segoe UI
Gui, Add, Text, x10 y2 w40 Left, Bee
Gui, Font, s10 cSilver bold, Segoe UI
Gui, Add, Text, x35 y2 w160 Left, Aware
Gui, Font, s8 cGray bold, Segoe UI
Gui, Add, Text, x75 y5 w160 Left, v1
Gui, Font, s6 cSilver bold, Segoe UI
Gui, Add, Text, x88 y7 w160 Left, by Duduu

Gui, Font, s12 cSilver, Segoe UI
Gui, Add, Text, x175 y2 gAlternarAba vBotaoEngrenagem Center w20 +BackgroundTrans, ⚙️

Gui, Font, s8 cSilver bold, Segoe UI
Gui, Add, Text, x10 y100 w180 Left, F6 Pause | F7 Start | F8 Stop
Gui, Add, Text, cSilver x0 y90 w200 0x12 Center
Gui, Font, s8 cSilver, Segoe UI

Gui, Font, s20 cWhite bold, Segoe UI
Gui, Add, Text, x0 y39 w200 Center vMostrador, Waiting...
Gui, Font, s18 cWhite bold, Segoe UI
Gui, Add, Text, x150 y69 w40 Right vTimerPequeno, 

Gui, Font, s9 c8F4EB4 bold, Segoe UI
Gui, Add, Text, x210 y10 w170 Center, AUDIO MIXER

Gui, Font, s7 cSilver bold, Segoe UI
Gui, Add, Text, x220 y95 w40 Center, ALERT
Gui, Add, Slider, x225 y30 h60 Vertical Invert vVolAlertaSlider gAjustarVolume Range0-100, %VolAlerta%
Gui, Add, Text, x220 y105 w40 Center vStatusVolume, Vol: %VolAlerta%
Gui, Add, Text, x275 y95 w45 Center, REFRESH
Gui, Add, Slider, x285 y30 h60 Vertical Invert vVolRefreshSlider gAjustarVolume Range0-100, %VolRefresh%
Gui, Add, Text, x275 y105 w45 Center vStatusVolume2, Vol: %VolRefresh%
Gui, Add, Text, x335 y95 w40 Center, RUNOUT
Gui, Add, Slider, x340 y30 h60 Vertical Invert vVolRunoutSlider gAjustarVolume Range0-100, %VolRunout%
Gui, Add, Text, x335 y105 w40 Center vStatusVolume3, Vol: %VolRunout%

Gui, Show, w200 h120 NoActivate, TimerBuff
SetTimer, BuscarImagem, 200 
return

AlternarAba:
    GuiControl, +c8F4EB4, BotaoEngrenagem
    GuiControl, Move, BotaoEngrenagem, x176 y3
    Sleep, 100
    GuiControl, +cWhite, BotaoEngrenagem
    GuiControl, Move, BotaoEngrenagem, x175 y2
    
    if (AbaAberta) {
        Gui, Show, w200 h120
        AbaAberta := false
    } else {
        Gui, Show, w385 h120 
        AbaAberta := true
    }
return

AjustarVolume:
    Gui, Submit, NoHide
    VolAlerta := VolAlertaSlider
    VolRefresh := VolRefreshSlider
    VolRunout := VolRunoutSlider
    Gui, Submit, NoHide
    VolAlerta := VolAlertaSlider
    VolRefresh := VolRefreshSlider
    VolRunout := VolRunoutSlider
    GuiControl,, StatusVolume, Vol: %VolAlerta%
    GuiControl,, StatusVolume2, Vol: %VolRefresh%
    GuiControl,, StatusVolume3, Vol: %VolRunout%
return

ArrastarJanela() {
    PostMessage, 0xA1, 2
}

BuscarImagem:
    ImageSearch, achouX, achouY, 0, 0, A_ScreenWidth, A_ScreenHeight, *25 %A_ScriptDir%\parts\imgsearch\buff.png
    if (ErrorLevel == 0) { 
        tempoRestante := 60
        if (!rodando) {
            SetTimer, AtualizarTimer, 1000
            rodando := true
        }
        ; Garante que a fonte volte ao tamanho normal no refresh 
        Gui, Font, s20 cSilver bold, Segoe UI
        GuiControl, Font, Mostrador
        GuiControl,, Mostrador, Refreshed
        GuiControl,, TimerPequeno, 
        if (Audiorefresh == 1) {
            SoundSet, %VolRefresh%
            SoundPlay, %A_ScriptDir%\parts\fx\refresh.wav
        }
    }
return

AtualizarTimer:
    if (tempoRestante > 0) {
        tempoRestante--
        if (tempoRestante > 20) {
            ; Garante fonte s20 para o cronômetro grande 
            Gui, Font, s20 cWhite bold, Segoe UI
            GuiControl, Font, Mostrador
            GuiControl,, Mostrador, %tempoRestante%
        }
        else if (tempoRestante == 20) {
            SoundSet, %VolAlerta%
            SoundPlay, %A_ScriptDir%\parts\fx\precwarn.wav
            Gui, Font, s20 cSilver bold, Segoe UI
            GuiControl, Font, Mostrador
            GuiControl,, Mostrador, Refresh
            ; Garante fonte s18 para o cronômetro pequeno 
            Gui, Font, s18 cWhite bold, Segoe UI
            GuiControl, Font, TimerPequeno
            GuiControl,, TimerPequeno, %tempoRestante%
        }
        else if (tempoRestante == 10) {
            SoundSet, %VolAlerta%
            SoundPlay, %A_ScriptDir%\parts\fx\precwarn.wav
            Gui, Font, s20 ceb4034 bold, Segoe UI
            GuiControl, Font, Mostrador
            GuiControl,, Mostrador, REFRESH
            Gui, Font, s18 cWhite bold, Segoe UI
            GuiControl, Font, TimerPequeno
            GuiControl,, TimerPequeno, %tempoRestante%
        }
        else {
            Gui, Font, s18 cWhite bold, Segoe UI
            GuiControl, Font, TimerPequeno
            GuiControl,, TimerPequeno, %tempoRestante%
        }
    }
    else {
        if (Audiorunout == 1) {
            SoundSet, %VolRunout%
            SoundPlay, %A_ScriptDir%\parts\fx\runout.wav
        }
        Gui, Font, s20 cWhite bold, Segoe UI
        GuiControl, Font, Mostrador
        GuiControl,, Mostrador, RUN OUT
        Gui, Font, s18 cWhite bold, Segoe UI
        GuiControl, Font, TimerPequeno
        GuiControl,, TimerPequeno, 0
        SetTimer, AtualizarTimer, Off
        rodando := false
    }
return

F6::Pause, On
F7::Pause, Off
F8::ExitApp