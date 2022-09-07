::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Ver 0.01                                                             ::
:: Author: AVSGamer                                                     ::
:: Date: 07/09/2022                                                     ::
:: Description: A Bluestacks Macro to AutoHotkey file converter.        ::
:: Changelog:                                                           ::
:: Ver 0.01    - Base Version                                           ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off
SetLocal EnableDelayedExpansion
echo **************************************
echo **Welcome to BlueSMacro2AHK Ver 0.01**
echo ***********************by Khayeel*****
echo Ver 0.01 - Not a full conversion program yet, only converting prioritized inputs for now.
echo Usage:
echo 1^)_Place the Bluestacks Macro file within the same directory as this program.
echo 3^)_Run this file.
echo 4^)_Input the filename of the Bluestacks Macro file when prompted.
echo 5^)_If the file is converted succesfully it will be in the same directory as this program.
echo 6^)_Test it out!
echo .
echo .
set eType1="EventType": "KeyDown",
set eType2="EventType": "KeyUp",
set eType3="EventType": "MouseUp",
set kName="KeyName": "Alt",
set keyName=alt
set delim=}
set tStamplbl="Timestamp": 
set xCoordlbl="X": 
set yCoordlbl="Y": 
set loopIntervallbl="LoopInterval": 
set loopIntervalTmp=0
set loopInterval=0
set tStamp0=0
set tStamp1=0
set tStampTmp=0
set eventType=0
set xCoord=0
set xCoordTmp=0
set yCoord=0
set line=0
:2inputfile
set /p filename=Enter the filename of to be converted without it's file extension:
if exist "%~dp0%filename%.json" (goto :filecorrect) else (goto :inputfile)
:inputfile
echo Couldn't find file %filename% in "%~dp0"
echo .
echo .
goto :2inputfile
:filecorrect
if /i exist "%~dp0%filename%-Converted.ahk" del /q "%~dp0%filename%-Converted.ahk"
echo Please wait as file is being created!
echo ^^l::>>"%~dp0%filename%-Converted.ahk"
echo return>>"%~dp0%filename%-Converted.ahk"
echo ^^k::>>"%~dp0%filename%-Converted.ahk"
echo Start:>>"%~dp0%filename%-Converted.ahk"
for /F "usebackq tokens=*" %%A in ("%~dp0%filename%.json") do (
    set line=%%A
    if !line!==!eType1! set eventType=kdown
    if !line!==!eType2! set eventType=kup
    if !line!==!eType3! set eventType=mup
    if !line!==!kName! set keyName=alt
    set substr=!line:~0,13!
    if !substr!==!tStamplbl! if !eventType!==mup set tStamp0=!tStamp1!&& set tStampTmp=!line:"Timestamp": =!&& set tStampTmp=!tStampTmp:,=!&& set tStamp1=!tStampTmp!
    if !substr!==!tStamplbl! if !eventType!==kdown set tStamp0=!tStamp1!&& set tStamp1=!line:"Timestamp": =!
    if !substr!==!tStamplbl! if !eventType!==kup set tStamp0=!tStamp1!&& set tStamp1=!line:"Timestamp": =!
    set substr=!line:~0,5!
    if !substr!==!xCoordlbl! set xCoordTmp=!line:"X": =!&& set xCoord=!xCoordTmp:,=!
    if !substr!==!yCoordlbl! set yCoord=!line:"Y": =!
    set substr=!line:~0,16!
    if !substr!==!loopIntervallbl! set loopIntervalTmp=!line:"LoopInterval": =!&& set loopInterval=!loopIntervalTmp:,=!
    set substr=!line:~0,1!
    if !substr!==!delim! if !eventType!==mup echo Sleep, !tStamp1!-!tStamp0!>>"%~dp0%filename%-Converted.ahk" && echo Click, !xCoord! !yCoord!>>"%~dp0%filename%-Converted.ahk"
    if !substr!==!delim! if !eventType!==kdown echo Sleep, !tStamp1!-!tStamp0!>>"%~dp0%filename%-Converted.ahk" && echo Send, {Alt down}>>"%~dp0%filename%-Converted.ahk"
    if !substr!==!delim! if !eventType!==kup echo Sleep, !tStamp1!-!tStamp0!>>"%~dp0%filename%-Converted.ahk" && echo Send, {Alt up}>>"%~dp0%filename%-Converted.ahk"
    )
echo Sleep, !loopInterval!*1000>>"%~dp0%filename%-Converted.ahk"
echo Goto, Start>>"%~dp0%filename%-Converted.ahk"
endlocal
echo Conversion Complete!
PAUSE