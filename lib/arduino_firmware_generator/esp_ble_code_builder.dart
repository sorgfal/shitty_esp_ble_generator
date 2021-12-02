import 'property_item.dart';

part 'esp_ble_firmware_code_builder.dart';

class EspBleCodePartsBuilder {
  final List<CharacteristicItem> properties;

  EspBleCodePartsBuilder(this.properties);

  String _generateConstDefinitions() {
    String result = "\n// UUID CONST DEFINITION \n";
    for (var prop in properties) {
      result += prop.getUUIDConstantDefinition();
      result += "\n";
    }
    result += "//  END UUID CONST DEFINITION \n";
    return result;
  }

  String _generateBLECharacteristicPointerDefinitions() {
    String result = "\n// BLECharacteristic Pointer Definitions \n";
    for (var prop in properties) {
      result += prop.getBLECharacteristicPointerDefinition();
      result += "\n";
    }
    result += "//  END BLECharacteristic Pointer Definitions  \n";
    return result;
  }

  String _generateCallbackDefinitions() {
    String result = "\n// Callbacks  Definitions \n";
    for (var prop in properties) {
      result += prop.getCallbacksClassDefinition();
      result += "\n";
    }
    result += "//  END Callbacks  Definitions  \n";
    return result;
  }

  String _generateCharacteristicAssignmentDefinitions() {
    String result = "\n//Characteristic Assignment Definitions \n";
    for (var prop in properties) {
      result += prop.getCharacteristicAssignment();
    }
    result += "//  END Characteristic Assignment Definitions  \n";
    return result;
  }

  String generateAll() {
    String result = "";
    result += _generateConstDefinitions();
    result += _generateBLECharacteristicPointerDefinitions();
    result += _generateCallbackDefinitions();
    result += _generateCharacteristicAssignmentDefinitions();
    return result;
  }

  String _generateScheme() {
    return properties.map((e) => e.toJson()).join(", \n");
  }
}
