namespace eval Arduino {
    namespace export arduinoOpen pinMode digitalWrite digitalRead \
                     analogRead analogWrite close

    proc ::Arduino::arduinoOpen {port {baudrate 115200}} {
        set fh [open $port "RDWR"]
        fconfigure $fh -mode "$baudrate,n,8,1"
        fconfigure $fh -blocking 1 -timeout 100 -buffersize 0
        return $fh
    }

    proc ::Arduino::pinMode {board_fd pin mode} {
        set cmd [format "@0%02.2d%s" $pin $mode]
        sendData $board_fd $cmd
        return true
    }

    proc ::Arduino::digitalWrite {board_fd pin value} {
        set cmd [format "@1%02.2d%s" $pin $value]
        sendData $board_fd $cmd
        return true
    }

    proc ::Arduino::digitalRead {board_fd pin} {
        set cmd [format "@2%02.2d" $pin]
        sendData $board_fd $cmd
        return [formatPinState [getData $board_fd]]
    }

    proc ::Arduino::analogWrite {board_fd pin value} {
        set cmd [format "@3%02.2d%s" $pin $value]
        sendData $board_fd $cmd
        return true
    }

    proc ::Arduino::analogRead {board_fd pin} {
        set cmd [format "@4%02.2d" $pin]
        sendData $board_fd $cmd
        return [getData $board_fd]
    }

    proc ::Arduino::close {board_fd} {
        close $board_fd
        return true
    }

    proc ::Arduino::sendData {board_fd serial_data} {
        puts $board_fd "$serial_data"
        flush $board_fd
    }

    proc ::Arduino::getData {board_fd} {
        return [string trimright [read $board_fd] "\n"]
    }

    proc ::Arduino::formatPinState {pinValue} {
        if {$pinValue == {1}} {
            return true
    	} else {
            return false
      }
    }
}

set board [::Arduino::arduinoOpen com8:]
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
