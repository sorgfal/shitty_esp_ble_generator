import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shitty_esp_ble_generator/arduino_firmware_generator/esp_ble_code_builder.dart';
import 'package:shitty_esp_ble_generator/arduino_firmware_generator/property_item.dart';
import 'package:shitty_esp_ble_generator/generator/generator_config_model.dart';
// import 'dart:html' as webFile;

class GeneratorConfigViewModel extends ValueNotifier<GeneratorConfigModel> {
  GeneratorConfigViewModel(GeneratorConfigModel value) : super(value);
  Future<String> _generateSourceCode() async {
    String template = await rootBundle.loadString("assets/base.tmpl");
    return EspBleFirmwareCodeBuilder(
            EspBleCodePartsBuilder(value.characteristics),
            deviceName: value.deviceName!,
            manufacturer: value.manufacturer!,
            serviceUUID: value.serviceUUID!,
            template: template)
        .build();
  }

  void startGeneration() {
    if (_validate()) {
      _generateSourceCode().then(_onGenerated);
    }
  }

  bool _validate() {
    if (value.serviceUUID == null) {
      value = value.copyWith(errors: "UUID сервиса пуст");
    }
    if (value.deviceName == null) {
      value = value.copyWith(errors: "Название устройства пусто!!");
    }
    if (value.manufacturer == null) {
      value = value.copyWith(errors: "А как же производитель?");
    }
    if (value.characteristics.isEmpty) {
      value =
          value.copyWith(errors: "А характеристики ? Оно без них не работает");
    }

    return false;
  }

  void _onGenerated(String sourceCode) {
    // if (kIsWeb) {
    //   var blob = webFile.Blob(["data"], 'text/plain', 'native');

    //   var anchorElement = webFile.AnchorElement(
    //       href: webFile.Url.createObjectUrlFromBlob(blob).toString())
    //     ..setAttribute("download", "sorgalEspBleFirmware.c")
    //     ..click();
    // }
  }

  final TextEditingController deviceName = TextEditingController();
  final TextEditingController manfucaturer = TextEditingController();
  final TextEditingController serviceUUID = TextEditingController();

  addCharacteristic(CharacteristicItem i) {
    value = value.copyWith(characteristics: [...value.characteristics, i]);
  }
}
