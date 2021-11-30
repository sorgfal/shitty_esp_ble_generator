import 'package:shitty_esp_ble_generator/arduino_firmware_generator/property_item.dart';

class GeneratorConfigModel {
  final String serviceUUID;
  final String manufacturer;
  final String deviceName;
  final List<CharacteristicItem> characteristics;
  String? errors;
  GeneratorConfigModel({
    required this.serviceUUID,
    required this.manufacturer,
    required this.deviceName,
    required this.characteristics,
    this.errors,
  });

  GeneratorConfigModel copyWith({
    String? serviceUUID,
    String? manufacturer,
    String? deviceName,
    List<CharacteristicItem>? characteristics,
    String? errors,
  }) {
    return GeneratorConfigModel(
      serviceUUID: serviceUUID ?? this.serviceUUID,
      manufacturer: manufacturer ?? this.manufacturer,
      deviceName: deviceName ?? this.deviceName,
      characteristics: characteristics ?? this.characteristics,
      errors: errors ?? this.errors,
    );
  }
}
