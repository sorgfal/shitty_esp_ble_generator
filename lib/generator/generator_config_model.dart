import 'package:shitty_esp_ble_generator/arduino_firmware_generator/property_item.dart';

class GeneratorConfigModel {
  final String? serviceUUID;
  final String? manufacturer;
  final String? deviceName;
  final List<CharacteristicItem> characteristics;
  String? errors;
  String? scheme;
  GeneratorConfigModel({
    this.serviceUUID,
    this.manufacturer,
    this.deviceName,
    this.characteristics = const [],
    this.errors,
    this.scheme,
  });

  GeneratorConfigModel copyWith({
    String? serviceUUID,
    String? manufacturer,
    String? deviceName,
    List<CharacteristicItem>? characteristics,
    String? errors,
    String? scheme,
  }) {
    return GeneratorConfigModel(
      serviceUUID: serviceUUID ?? this.serviceUUID,
      manufacturer: manufacturer ?? this.manufacturer,
      deviceName: deviceName ?? this.deviceName,
      characteristics: characteristics ?? this.characteristics,
      errors: errors ?? this.errors,
      scheme: scheme ?? this.scheme,
    );
  }
}
