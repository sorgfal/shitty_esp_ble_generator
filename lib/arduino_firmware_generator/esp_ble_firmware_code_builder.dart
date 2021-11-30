part of 'esp_ble_code_builder.dart';

class EspBleFirmwareCodeBuilder {
  final String serviceUUID;
  final String manufacturer;
  final String deviceName;

  final String _template;
  final EspBleCodePartsBuilder _builder;

  EspBleFirmwareCodeBuilder(this._builder, this.serviceUUID, this.manufacturer,
      this.deviceName, this._template);
  String build() {
    return _template
        .replaceAll('%constDefinition', _builder._generateConstDefinitions())
        .replaceAll('%BLECharacteristic',
            _builder._generateBLECharacteristicPointerDefinitions())
        .replaceAll(
            '%callbacksDefenition', _builder._generateCallbackDefinitions())
        .replaceAll('%characteristicAssignment',
            _builder._generateCharacteristicAssignmentDefinitions());
  }
}
