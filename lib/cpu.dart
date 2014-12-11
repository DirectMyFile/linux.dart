library linux.cpu;

import "dart:io";

class CPU {
  int processor;
  String vendorId;
  String cpuFamily;
  String model;
  String modelName;
  int siblings;
  List<String> flags;
  
  CPU();
  
  CPU.fromCpuInfo(String block) {
    var infos = {};
    var lines = block.split("\n");
    for (var line in lines) {
      var parts = line.split(":").map((it) => it.trim()).toList();
      infos[parts[0]] = parts.length > 1 ? (parts..removeAt(0)).join(":") : "";
    }
    processor = int.parse(infos["processor"]);
    vendorId = infos["vendor_id"];
    cpuFamily = infos["cpu_family"];
    model = infos["model"];
    modelName = infos["model name"];
    siblings = int.parse(infos["siblings"]);
    flags = infos["flags"].split(" ");
  }
  
  double getUsage() {
    var file = new File("/proc/stat");
    var lines = file.readAsLinesSync();
    var line = lines.firstWhere((it) => it.startsWith("cpu${processor}"));
    var split = line.split(" ");
    var userLoad = int.parse(split[1]);
    var systemLoad = int.parse(split[3]);
    var m = int.parse(split[4]);
    return ((userLoad + systemLoad) * 100) / m;
  }
  
  static List<CPU> list() {
    var cpus = [];
    var info = new File("/proc/cpuinfo").readAsStringSync();
    var blocks = info.split("\n\n")..removeWhere((it) {
      return it.trim().isEmpty;
    });
    for (var block in blocks) {
      var cpu = new CPU.fromCpuInfo(block);
      cpus.add(cpu);
    }
    return cpus;
  }
}
