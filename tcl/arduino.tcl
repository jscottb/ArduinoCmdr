#
# ArduinoCmdr - A simple serial io framework for Arduino and Arduino like
#               boards.
#
# By Scott Beasley 2016
#
# Free to use and change. Enjoy :)
#

package provide ArduinoCmdr 1.0

namespace eval Arduino {
    namespace export arduinoOpen pinMode digitalWrite digitalRead \
                     analogRead analogWrite close

    proc ::Arduino::arduinoOpen {port {baudrate 115200}} {
        set fh [open $port "RDWR"]
        fconfigure $fh -mode "$baudrate,n,8,1"
        fconfigure $fh -blocking 1 -timeout 100 -buffersize 0
        return $fh
    }

    proc ::Arduino::arduinoClose {board} {
        close $board
        return true
    }

    proc ::Arduino::pinMode {board pin mode} {
        set cmd [format "@0%02.2d%s" $pin $mode]
        sendData $board $cmd
        return true
    }

    proc ::Arduino::digitalWrite {board pin value} {
        set cmd [format "@1%02.2d%s" $pin $value]
        sendData $board $cmd
        return true
    }

    proc ::Arduino::digitalRead {board pin} {
        set cmd [format "@2%02.2d" $pin]
        sendData $board $cmd
        return [formatPinState [getData $board]]
    }

    proc ::Arduino::analogWrite {board pin value} {
        set cmd [format "@3%02.2d%s" $pin $value]
        sendData $board $cmd
        return true
    }

    proc ::Arduino::analogRead {board pin} {
        set cmd [format "@4%02.2d" $pin]
        sendData $board $cmd
        return [getData $board]
    }

    proc ::Arduino::sendData {board serial_data} {
        puts $board "$serial_data"
        flush $board
    }

    proc ::Arduino::getData {board} {
        return [string trimright [read $board] "\n"]
    }

    proc ::Arduino::formatPinState {pinValue} {
      if {$pinValue == {1}} {
            return true
    	} else {
            return false
      }
    }
}
