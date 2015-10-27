import java.util.*;
import java.io.*;

class Wifi {
  ArrayList<Network> networks = new ArrayList<Network>();
  String osName;

  Wifi() {
    this.osName = System.getProperty("os.name");
    this.scan();
  }

  void scan() {
    this.networks = new ArrayList<Network>();
    if (match(this.osName, "Mac") != null ) {
      String command = "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport scan";
      String res = this.executeCommand(command);
      String[] rows = res.split("\n");
      for (int i=1; i< rows.length; i++) {
        String row = rows[i];
        String ssid = row.substring(0, 32).replaceAll("^\\s+", ""); //left trim
        String rssi = row.substring(51, 54).replaceAll("\\s+", "");
        String security = row.substring(70).replaceAll("\\s+", "");
        Network network = new Network(ssid, rssi, security);
        this.networks.add(network);
      }
    } else if (match(this.osName, "Windows")!= null) {
      println("todo");
    } else if (match(this.osName, "Linux")!= null) {
      String command = " nmcli dev wifi list";
      String res = this.executeCommand(command);
      String[] rows = res.split("\n");
      for (int i=1; i< rows.length; i++) {
        String row = rows[i];
        String ssid = row.substring(0, 34).replaceAll("^\\s+", "").replaceAll("'", ""); //left trim
        String rssi = row.substring(93, 95).replaceAll("\\s+", "");
        String security = row.substring(102, 113).replaceAll("\\s+", "");
        Network network = new Network(ssid, rssi, security);
        this.networks.add(network);
      }
    }

    Collections.sort(this.networks);
  }

  String executeCommand(String command) {
    StringBuffer output = new StringBuffer();
    Process p;
    try {
      p = Runtime.getRuntime().exec(command);
      p.waitFor();
      BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream()));
      String line = "";      
      while ((line = reader.readLine())!= null) {
        output.append(line + "\n");
      }
    } 
    catch (Exception e) {
      e.printStackTrace();
    }
    return output.toString();
  }

  Network getNetwork(int index) {
    if (index <= this.networks.size())
      return this.networks.get(index);
    throw new IllegalArgumentException("Wifi not found");
  }

  String[] getList(Boolean refresh) {
    if (refresh == true)
      this.scan();
    return this.getList();
  }

  String[] getList() {
    String[] names = new String[0];
    for (Network network : this.networks) 
      names = append(names, network.getName());
    return names;
  }
}

class Network implements Comparable<Network> {
  String ssid, password;
  int rssi, security, cipher;

  Network() {
  }

  Network (String _ssid, String _rssi, String _security) {
    this.setSsid(_ssid);
    this.setRssi(_rssi);
    this.setSecurity(_security);
  }

  void setSsid(String str) {
    this.ssid = str.replaceAll("^\\s+", ""); //trim()
  }

  void setRssi(String str) {
    str = str.replaceAll("\\s+", "");
    this.rssi = Integer.parseInt(str);
  }

  void setSecurity(String str) {
    str = str.replaceAll("\\s+", "");
    if (match(str, "WPA2") != null )
      this.security = 3;
    else if (match(str, "WPA") != null )
      this.security = 2;
    else if (match(str, "WEP")!= null)
      this.security = 1;
    else if (match(str, "NONE")!= null)
      this.security = 0;

    if (match(str, "AES")!= null && match(str, "TKIP")!= null )
      this.cipher = 3;
    else if (match(str, "TKIP")!= null)
      this.cipher = 2;    
    else if (match(str, "AES")!= null)
      this.cipher = 1;
  }

  void setPassword(String str) {
    str = str.replaceAll("\\s+", "");
    this.password = str;
  }

  int compareTo(Network network) {
    return network.rssi - this.rssi;
  }

  String getName() {
    return this.ssid;
  }
}