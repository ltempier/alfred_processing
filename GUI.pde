import controlP5.*; //<>// //<>// //<>//

class GUI {
  ControlP5 cp5;
  PApplet parent;

  int activeColor = color(255, 128);
  int backgroundColor = color(60);

  ScrollableList deviceList;
  ScrollableList wifiList;

  Button refreshDevice;
  Button refreshWifi;
  Button submit;

  Textfield wifiPassword;

  GUI(PApplet _parent) {
    parent = _parent;
    cp5 = new ControlP5(parent);

    //devices
    deviceList = cp5.addScrollableList("devices")
      .setPosition(20, 50)
      .setSize(120, 70);
    this.customizeDropdownList(deviceList);

    refreshDevice = cp5.addButton("refreshDevices")
      .setCaptionLabel("refresh devices")
      .setValue(0)
      .setPosition(180, 50)
      .setSize(120, 20);
    this.customizeButton(refreshDevice);

    //wifi
    wifiList = cp5.addScrollableList("wifi")
      .setPosition(20, 120)
      .setSize(120, 120);
    this.customizeDropdownList(wifiList);

    refreshWifi = cp5.addButton("refreshWifi")
      .setCaptionLabel("refresh wifi")
      .setValue(0)
      .setPosition(180, 120)
      .setSize(120, 20);
    this.customizeButton(refreshWifi);

    //wifi password
    wifiPassword = cp5.addTextfield("wifiPassword")
      .setCaptionLabel("wifi password")
      .setAutoClear(false)
      .setPosition(20, 250)
      .setSize(120, 20)
      .setPasswordMode(true);
    this.customizeTextfield(wifiPassword);
    
    submit= cp5.addButton("submit")
      .setValue(0)
      .setPosition(180, 250)
      .setSize(120, 20);
    this.customizeButton(submit);
  }
  
  String getPasswordValue(){
    return wifiPassword.getText();
  }
  
  void fillWifiList(String[] networks) {
    wifiList.setItems(networks);
  }

  void fillDeviceList(String[] devices) {
    deviceList.setItems(devices);
  }

  void customizeDropdownList(ScrollableList sl) {
    sl.setItemHeight(20);
    sl.setBarHeight(20);
    sl.setColorBackground(this.backgroundColor);
    sl.setColorActive(this.activeColor);
  }

  void customizeButton(Button btn) {
    btn.setColorBackground(this.backgroundColor);
    btn.setColorActive(this.activeColor);
  }

  void customizeTextfield(Textfield txtField) {
    txtField.setColorForeground(this.backgroundColor);
    txtField.setColorBackground(this.backgroundColor);
    txtField.setColorActive(this.activeColor);
    txtField.setColorLabel(this.backgroundColor);
  }
}