import "package:linux/cpu.dart";

void main() {
  var cpus = CPU.list();
  
  for (var cpu in cpus) {
    print("Processor: ${cpu.processor}");
    print("Model: ${cpu.model}");
    print("Model Name: ${cpu.modelName}");
    print("Siblings: ${cpu.siblings}");
    print("Load: ${cpu.getUsage()}");
  }
}