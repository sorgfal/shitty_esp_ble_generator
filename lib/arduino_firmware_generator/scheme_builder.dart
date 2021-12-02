import 'package:shitty_esp_ble_generator/arduino_firmware_generator/property_item.dart';

class SchemeBuilder {
  final List<CharacteristicItem> properties;
  final String serviceUUID;
  final String manufacturer;
  final String deviceName;

  SchemeBuilder({
    required this.properties,
    required this.serviceUUID,
    required this.manufacturer,
    required this.deviceName,
  });

  String get scheme => properties.map((e) => e.toJson()).join(", \n");

  String build() {
    var result = '''
    {
        "deviceName": "$deviceName",
        "manufacturer": "$manufacturer",
        "serviceUUID": "$serviceUUID",
        "characteristics": [
          $scheme   
      ]
    }
    ''';
    return result;
  }
}
