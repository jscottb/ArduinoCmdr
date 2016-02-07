/*
 ArduinoCmdr - A simple serial io framework for Arduino and Arduino like
               boards.

 By Scott Beasley 2016

 Free to use and change. Enjoy :)
*/

void setup ( )
{
   // Change the baud rates here if different than below
   Serial.begin (19200);
   delay (250);
}

void loop ( )
{
   byte command = 0;
   String cmd = "", pin = "", mode = "", val = "";
   int value = 0;

   if (Serial.available ( ) > 0) {
      cmd = Serial.readStringUntil ('\n');
   } else {
      return;
   }

   cmd.trim ( );
   //Serial.println (cmd);
   if (cmd.charAt (0) != '@') {
      Serial.flush ( );
      return;
   }

   command = (byte) cmd.charAt (1);
   //Serial.println (command);

   switch (command) {
      case '0':
         pin = cmd.substring (2, 4);
         val = cmd.substring (4);
         if (val == "INPUT") value = INPUT;
         else if (val == "OUTPUT") value = OUTPUT;
         else if (val == "INPUT_PULLUP") value = INPUT_PULLUP;
         pinMode (pin.toInt ( ), value);
         break;

      case '1':
         pin = cmd.substring (2, 4);
         val = cmd.substring (4);
         if (val == "HIGH") value = HIGH;
         else if (val == "LOW") value = LOW;
         else if (val == "1") value = HIGH;
         else if (val == "0") value = LOW;
         digitalWrite (pin.toInt ( ), value);
         break;

      case '2':
         pin = cmd.substring (2, 4);
         Serial.println (digitalRead (pin.toInt ( )));
         break;

      case '3':
         pin = cmd.substring (2, 4);
         val = cmd.substring (4);
         analogWrite (pin.toInt ( ), val.toInt ( ));
         break;

      case '4':
         pin = cmd.substring (2, 4);
         Serial.println (analogRead (pin.toInt ( )));
         break;

      case '9':
      default:
         Serial.flush ( );
         break;
   }

   Serial.flush ( );
}
