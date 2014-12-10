import "dart:io";

import "package:linux/leds.dart";

void main() {
  var leds = LED.list();
  
  for (var led in leds) {
    print("Name: ${led.deviceName}");
    print("Brightness: ${led.brightness}");
    print("Maximum Brightness: ${led.maxBrightness}");
    var b = led.brightness;
    print("Setting Brightness to Maximum");
    led.brightness = led.maxBrightness;
    sleep(new Duration(seconds: 5));
    print("Setting Brightness to 0");
    led.brightness = 0;
    sleep(new Duration(seconds: 5));
    print("Resetting Brightness");
    led.brightness = b;
  }
}