/**
 * Logging the robot's state
 */

import processing.serial.*;

Serial serial;  
String received;  
PrintWriter output;
String filename = "logfile.txt";
boolean logging = false;

void setup() 
{
  size(400, 600);
  print(Serial.list());
}

void draw()
{
  background(0); 
  fill(255);
  text("robot state log", 10, 30);
  text("press (s) to start", 10, 50);
  text("press (q) to quit", 10, 70);
  if(logging) {
    fill(0, 255, 23);
    text("logging", 10, 90);   
  }
  if (serial != null && serial.available() > 0) {  
    received = serial.readString();
    output.println(received);
    print(received);             
  }
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    String portName = Serial.list()[0];
    serial = new Serial(this, portName, 115200);
    filename = "" + year() + month() + day() + "-" + hour() + minute() + second() + "-log.txt"; 
    output = createWriter(filename);  
    logging = true;
  } else if (key == 'q' || key == 'Q') {
    output.flush();  // Writes the remaining data to the file
    output.close();  // Finishes the file
    serial = null;
    logging = false;
  }
}

/*

// Wiring / Arduino Code
// Code for sensing a switch status and writing the received to the serial port.

int switchPin = 4;                       // Switch connected to pin 4

void setup() {
  pinMode(switchPin, INPUT);             // Set pin 0 as an input
  Serial.begin(9600);                    // Start serial communication at 9600 bps
}

void loop() {
  if (digitalRead(switchPin) == HIGH) {  // If switch is ON,
    Serial.write(1);               // send 1 to Processing
  } else {                               // If the switch is not ON,
    Serial.write(0);               // send 0 to Processing
  }
  delay(100);                            // Wait 100 milliseconds
}

*/