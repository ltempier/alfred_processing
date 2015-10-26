DeviceList deviceList; //<>//
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
}

void  devices(int n) {
  if (!isSetup)
    return;
  selectDevice = deviceList.getDevice(n);
}

void  submit(int n) {
  if (!isSetup)
    return;
  println("submit");
}