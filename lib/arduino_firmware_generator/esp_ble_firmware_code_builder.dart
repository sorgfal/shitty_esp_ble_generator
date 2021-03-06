part of 'esp_ble_code_builder.dart';

class EspBleFirmwareCodeBuilder {
  final String serviceUUID;
  final String manufacturer;
  final String deviceName;
  final String template;
  final EspBleCodePartsBuilder _builder;

  EspBleFirmwareCodeBuilder(this._builder,
      {required this.serviceUUID,
      required this.manufacturer,
      required this.deviceName,
      required this.template});
  String build() {
    var result = template
        .replaceAll('%serviceUUID', serviceUUID)
        .replaceAll('%manufacturer', manufacturer)
        .replaceAll('%deviceName', deviceName)
        .replaceAll('%constDefinition', _builder._generateConstDefinitions())
        .replaceAll('%scheme', _builder._generateScheme())
        .replaceAll('%BLECharacteristic',
            _builder._generateBLECharacteristicPointerDefinitions())
        .replaceAll(
            '%callbacksDefenition', _builder._generateCallbackDefinitions())
        .replaceAll('%characteristicAssignment',
            _builder._generateCharacteristicAssignmentDefinitions());
    return result;
  }
}
