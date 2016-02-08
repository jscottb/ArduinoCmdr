#
# ArduinoCmdr - A simple serial io framework for Arduino and Arduino like
#               boards.
#
# By Scott Beasley 2016
#
# Free to use and change. Enjoy :)
#

import sys
from serial import *

def arduinoOpen (port, baudrate = 19200):
    ser = Serial (port, baudrate,
                  bytesize=8,
                  parity=PARITY_NONE,
                  stopbits=1,
                  timeout=1)
    return ser

def arduinoClose (board):
    board.close ( )

def pinMode (board, pin, mode):
    cmd = "@0" + '{0:02d}'.format (pin) + mode
    sendData (board, cmd)

def digitalWrite (board, pin, value):
    cmd = "@1" + '{0:02d}'.format (pin) + value
    sendData (board, cmd)

def digitalRead (board, pin):
    cmd = "@2" + '{0:02d}'.format (pin)
    sendData (board, cmd)
    return formatPinState (getData ( ))

def analogWrite (board, pin, value):
    cmd = "@3" + '{0:02d}'.format (pin) + value
    sendData (board, cmd)

def analogRead (board, pin):
    cmd = "@4" + '{0:02d}'.format (pin)
    board.write (cmd)
    return getData (board)

def sendData (board, serial_data):
    board.write (serial_data)
    board.write ("\n")

# Needs work.
def getData (board):
    data_value = ""
    while 1:
        char_read = board.read (1)
        if char_read == '\n':
            break
        data_value += char_read

    return data_value

def formatPinState (pinValue):
    if pinValue == 1:
       return True
    else:
       return False
