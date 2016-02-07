import sys
import arduino
import time

if __name__ == '__main__':
    board = arduino.arduinoOpen ("\\\\.\\COM11", 19200)
    time.sleep (1)
    arduino.pinMode (board, 13, "OUTPUT")
    time.sleep (1)

    while 1:
        arduino.digitalWrite (board, 13, "HIGH")
        time.sleep (1)
        arduino.digitalWrite (board, 13, "LOW")
        time.sleep (1)
        #print arduino.analogRead (board, 0)
