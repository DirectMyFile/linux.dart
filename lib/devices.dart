library linux.devices;

import "dart:io";

class DeviceClass {
  static const DeviceClass LED = const DeviceClass("leds");
  
  final String name;
  
  const DeviceClass(this.name);
  
  List<String> listNames() {
    if (!new Directory("/sys/class/${name}").existsSync()) {
      return [];
    }

    return new Directory("/sys/class/${name}").listSync().where((it) => it is Directory).map((it) {
      return it.path.split("/").last;
    }).toList();
  }
}

class Device {
  final DeviceClass deviceClass;
  final String deviceName;
  
  Device(this.deviceClass, this.deviceName);

  String getStringProperty(String key) {
    var file = new File("/sys/class/${deviceClass.name}/${deviceName}/${key}");
    return file.readAsStringSync();
  }
  
  void setStringProperty(String key, String value) {
    var file = new File("/sys/class/${deviceClass.name}/${deviceName}/${key}");
    file.writeAsStringSync(value);
  }
  
  int getIntegerProperty(String key) {
    var file = new File("/sys/class/${deviceClass.name}/${deviceName}/${key}");
    return int.parse(file.readAsStringSync().trim());
  }
  
  void setIntegerProperty(String key, int value) {
    var file = new File("/sys/class/${deviceClass.name}/${deviceName}/${key}");
    file.writeAsStringSync(value.toString());
  }
}
