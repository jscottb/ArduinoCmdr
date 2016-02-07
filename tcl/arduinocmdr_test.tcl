package require ArduinoCmdr

set board [::Arduino::arduinoOpen {\\.\COM11}]
after 2000
::Arduino::pinMode $board 13 OUTPUT
after 100

while {1} {
   ::Arduino::digitalWrite $board 13 {HIGH}
   after 1000
   ::Arduino::digitalWrite $board 13 {LOW}
   after 1000
   puts [::Arduino::analogRead $board 0]
}
