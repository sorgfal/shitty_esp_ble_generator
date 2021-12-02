import 'package:shitty_esp_ble_generator/arduino_firmware_generator/dart_code_builder.dart';
import 'package:shitty_esp_ble_generator/arduino_firmware_generator/esp_ble_code_builder.dart';
import 'package:shitty_esp_ble_generator/arduino_firmware_generator/property_item.dart';
import 'package:shitty_esp_ble_generator/arduino_firmware_generator/scheme_builder.dart';

class EspBleProjectBuilder {
  final String serviceUUID;
  final String manufacturer;
  final String deviceName;
  final List<CharacteristicItem> properties;
  final String firmwareTemplate;

  late EspBleFirmwareCodeBuilder firmwareCodeBuilder;
  late SchemeBuilder schemeBuilder;
  // DartCodeBuilder dartBuilder;
  EspBleProjectBuilder({
    required this.serviceUUID,
    required this.manufacturer,
    required this.deviceName,
    required this.properties,
    required this.firmwareTemplate,
  }) {
    firmwareCodeBuilder = EspBleFirmwareCodeBuilder(
        EspBleCodePartsBuilder(properties),
        serviceUUID: serviceUUID,
        deviceName: deviceName,
        manufacturer: manufacturer,
        template: firmwareTemplate);
    schemeBuilder = SchemeBuilder(
        serviceUUID: serviceUUID,
        deviceName: deviceName,
        manufacturer: manufacturer,
        properties: properties);
  }

  Map<String, String> build() {
    Map<String, String> files = {};
    files['firmware.ino'] = firmwareCodeBuilder.build();
    files['scheme.json'] = schemeBuilder.build();
    return files;
  }
}
