import java.net.*;
import java.util.*;

class Wifi {
  String[] ssids = new String[0];
  Wifi() {
      this.scan();
  }

  void scan()  {
    try {
      Enumeration<NetworkInterface> nets = NetworkInterface.getNetworkInterfaces();
      for (NetworkInterface netIf : Collections.list(nets)) {
        println("Display name: "+ netIf.getDisplayName());
        println("Name: "+ netIf.getName());
      }
      println();
    } 
    catch(SocketException e) {
      println(e);
    }
  }
}