 //<>//
Device device;
GUI gui;
Wifi wifi;

void setup() {  
  size(400, 400);
  wifi = new Wifi();

  
  gui = new GUI(this);
  device = new Device(this);
  gui.fillDeviceList(device.getPorts());
  gui.fillWifiList(wifi.getNetworks());
}

void draw() {
  background(color(249, 242, 119));
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isGroup()) {
    println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
  } else if (theEvent.isController()) {

    Controller controller = theEvent.getController();
    println("event from controller : "+theEvent.getController().getValue()+" from "+controller);
  }
}