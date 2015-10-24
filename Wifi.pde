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
      println("todo");
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

  String[] getNetworks(Boolean refresh) {
    if (refresh == true)
      this.scan();
    return this.getNetworks();
  }

  String[] getNetworks() {
    String[] names = new String[0];
    for (Network network : this.networks) {
      names = append(names, network.getSsid());
    }
    return names;
  }
}

class Network implements Comparable<Network> {
  String ssid, rssi, security;
  Network (String _ssid, String _rssi, String _security) {
    this.ssid = _ssid.replaceAll("^\\s+", "");
    this.rssi = _rssi.replaceAll("\\s+", "");
    this.security = _security.replaceAll("\\s+", "");
  }

  int compareTo(Network network) {
    return network.getRssi() - this.getRssi();
  }

  int getRssi() {
    return Integer.parseInt(this.rssi);
  }

  String getSsid() {
    return this.ssid;
  }
  String toString() {
    return this.ssid + " " + this.rssi + " " +this.security + " " ;
  }
}