import processing.serial.*;
import processing.core.PApplet;

class DeviceList {
  ArrayList<Device> devices = new ArrayList<Device>();
  PApplet parent;
  String devicePath = "/dev/tty";

  DeviceList(PApplet _parent) {
    this.parent = _parent;
    this.scan();
  }

  void scan() {
    this.devices.clear();
    String[] ports = Serial.list();
    for (String port : ports) {
      if (!port.startsWith(this.devicePath))
        continue;
      Device device = new Device(this.parent, port);
      if (device.isPhoton)
        this.devices.add(device);
    }
  }

  String[] getList(Boolean refresh) {  
    if (refresh == true)
      this.scan();
    return this.getList();
  }
  
  String[] getList() {  
    String[] names = new String[0];
    for (Device device : this.devices) {
      names = append(names, device.getName());
    }
    return names;
  }

  Device getDevice(int index) {
    if (index <= this.devices.size())
      return this.devices.get(index);
    throw new IllegalArgumentException("Device not found");
  }
}

/*
*   i: get info
 *   f: set file upload
 *   w: set wifi config
 *   m: get mac address
 *   s: get ???
 */
class Device {
  PApplet parent;
  String port, id, mac;
  boolean isPhoton = false;

  Device(PApplet _parent, String _port) {
    this.parent = _parent;
    this.port = _port;
    this.init();
  }

  void init() {
    this.isPhoton = true;
    try {
      Serial serial = new Serial(this.parent, this.port, 9600);
      //get photon id
      this.write(serial, "i");
      delay(250);
      if (serial.available() > 0)
        setId(serial.readString());
      else
        this.isPhoton = false;
      serial.clear();
      //get mac adress
      this.write(serial, "m");
      delay(250);
      if (serial.available() > 0)
        setMac(serial.readString());
      else
        this.isPhoton = false;

      serial.clear();
      serial.stop();
    }
    catch (Exception e) {
      this.isPhoton = false;
    }
  }

  void setId(String res) {
    String str = "Your device id is";
    if (res.startsWith(str)) {
      this.id = res.replace(str, "").replaceAll("\\s+", "");
    }
  }

  void setMac(String res) {
    String str = "Your device MAC address is";
    if (res.startsWith(str)) {
      this.mac = res.replace(str, "").replaceAll("\\s+", "");
    }
  }

  void write(String str) {
    try {
      Serial serial = new Serial(this.parent, this.port, 9600);
      this.write(serial, str);
    }
    catch (Exception e) {
    }
  }
  void write(Serial serial, String str) {
    serial.write(str.getBytes());
  }

  String getName() {
    return this.port;
  }

  void configureWifi(Network wifi) {
    try {
      Serial serial = new Serial(this.parent, this.port, 9600);
      this.write(serial, "w");
      this.waitForResponse(serial);
    }
    catch (Exception e) {
    }
  }

  void  waitForResponse(Serial serial) {
    while (serial.available() <= 0)
      delay(10);
  }
}