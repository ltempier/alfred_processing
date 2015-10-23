
Device device;
GUI gui;
Wifi wifi;

void setup(){  
  size(600, 400);
  
  gui = new GUI(this);
  device = new Device(this);
  wifi = new Wifi();
  
  gui.fillDeviceList(device.getPorts());
}

void draw(){
   background(color(249,242,119));
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isGroup()) {
    println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
  } else if (theEvent.isController()) {
    
    Controller controller = theEvent.getController();
    println("event from controller : "+theEvent.getController().getValue()+" from "+controller); //<>//
  }
}