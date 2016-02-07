#
# ArduinoCmdr - A simple serial io framework for Arduino and Arduino like
#               boards.
#
# By Scott Beasley 2016
#
# Free to use and change. Enjoy :)
#

import sys
import serial

def arduinoOpen (port, baudrate = 115200):
    ser = serial.Serial (port, baudrate)
    return ser

def arduinoClose (board):
    board.close ( )

def pinMode (board, pin, mode):
    cmd = "@0" + str (pin) + mode
    sendData (board, cmd)

def digitalWrite (board, pin, value):
    cmd = "@1" + str (pin) + value
    sendData (board, cmd)

def digitalRead (board, pin):
    cmd = "@2" + str (pin)
    sendData (board, cmd)
    return formatPinState (getData ( ))

def analogWrite (board, pin, value):
    cmd = "@3" + str (pin) + value
    sendData (board, cmd)

def analogRead (board, pin):
    cmd = "@4" + str (pin)
    board.write (cmd)
    return getData (board)

def sendData (board, serial_data):
    board.write (serial_data)
    board.write ("\n")

def getData (board):
    return board.readline ( ).strip ( )

def formatPinState (pinValue):
    if pinValue == 1:
       return True
    else:
       return False
