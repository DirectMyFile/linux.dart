library linux.leds;

import "devices.dart";

class LED extends Device {
  int get brightness => getIntegerProperty("brightness");
      set brightness(int value) => setIntegerProperty("brightness", value);
  int get maxBrightness => getIntegerProperty("max_brightness");
  
  LED(String name) : super(DeviceClass.LED, name);

  static List<LED> list() => DeviceClass.LED.listNames().map((it) => new LED(it)).toList();
}
