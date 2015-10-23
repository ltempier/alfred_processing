import processing.serial.*;
import processing.core.PApplet;

/*
*   i: get info
 *   f: set file upload
 *   w: set wifi config
 *   m: get mac address
 *   s: get ???
 */

class Device { 
  String[] ports = new String[0];
  PApplet parent;

  Device(PApplet _parent) {
    parent = _parent;
    this.scan();
  }

  void scan() {
    this.ports = new String[0];
    String[] ports = Serial.list();
    for (String port : ports) {
      try {
        Serial myPort = new Serial(parent, port, 9600);
        this.write(myPort, "i");
        delay(250);
        if (myPort.available() > 0) {
          this.ports = append(this.ports, port);
          println( myPort.readString());
        }
        myPort.clear();
        myPort.stop();
      }
      catch (Exception e) {
        //println("can't connect "+port);
      }
    }
  }

  String[] getPorts(Boolean refresh) {
    if (refresh == true)
      this.scan();
    return this.getPorts();
  }

  String[] getPorts() {
    return this.ports;
  }

  void write(Serial myPort, String str) {
    myPort.write(str.getBytes());
  }
}