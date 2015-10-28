DeviceList deviceList; //<>// //<>//
GUI gui;
Wifi wifi;
Boolean isSetup = false;

Network selectNetwork;
Device selectDevice;

void setup() {  
  size(400, 400);
  gui = new GUI(this);
  wifi = new Wifi();
  deviceList = new DeviceList(this);

  gui.fillDeviceList(deviceList.getList());
  gui.fillWifiList(wifi.getList());

  isSetup = true;
}

void draw() {
  background(color(249, 242, 119));
}

void refreshWifi(int n) {
  if (!isSetup)
    return;
  gui.fillWifiList(wifi.getList());
}

void refreshDevices(int n) {
  if (!isSetup)
    return;
  gui.fillDeviceList(deviceList.getList(true));
}

void wifi(int n) {
  if (!isSetup)
    return;
  selectNetwork = wifi.getNetwork(n);
  println("set wifi : "+selectNetwork.getName());
}

void  devices(int n) {
  if (!isSetup)
    return;
  selectDevice = deviceList.getDevice(n);
  println("set device : "+selectDevice.getName());
}

void wifiPassword(String theText) {
  println("wifiPassword " + theText);
}

void  submit(int n) {
  if (!isSetup)
    return;

  if (selectNetwork != null && selectDevice != null) {
    String password = gui.getPasswordValue();
    selectNetwork.setPassword(password);
    selectDevice.configureWifi(selectNetwork);
    
    
    
  } else {
    println("bad selection ");
  }
}