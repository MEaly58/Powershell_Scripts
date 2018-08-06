<#!
.SYNOPSIS
	Send people cat facts
.DESCRIPTION
	This is a gag script to open cat facts and turn the speakers on. I recommend using a shortened url and renaming the script to something less suspicies 
.NOTES
	File Name: CatFacts.ps1
	Author: Mathew Ealy
	Requires Powershell 2.0
.LINK
	https://github.com/MEaly58
#>
#Run this every 1/2 hour and in an 8 hour work day there will be approximately 3 times per day that your victim hears a cat fact
if ((Get-Random -Maximum 10000) -lt 1875) {
    Add-Type -AssemblyName System.Speech
    $SpeechSynth = New-Object System.Speech.Synthesis.SpeechSynthesizer
    $CatFact = (ConvertFrom-Json (Invoke-WebRequest -Uri 'http://catfacts-api.appspot.com/api/facts')).facts
    $SpeechSynth.Speak("did you know?")
    $SpeechSynth.Speak($CatFact)
}  
