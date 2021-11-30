import 'package:shitty_esp_ble_generator/arduino_firmware_generator/property_item.dart';

class GeneratorConfigModel {
  final String serviceUUID;
  final String manufacturer;
  final String deviceName;
  final List<CharacteristicItem> characteristics;

  GeneratorConfigModel(this.serviceUUID, this.manufacturer, this.deviceName,
      this.characteristics);

  GeneratorConfigModel copyWith({
    String? serviceUUID,
    String? manufacturer,
    String? deviceName,
    List<CharacteristicItem>? characteristics,
  }) {
    return GeneratorConfigModel(
      serviceUUID ?? this.serviceUUID,
      manufacturer ?? this.manufacturer,
      deviceName ?? this.deviceName,
      characteristics ?? this.characteristics,
    );
  }
}
