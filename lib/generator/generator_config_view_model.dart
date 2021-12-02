import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shitty_esp_ble_generator/arduino_firmware_generator/esp_ble_code_builder.dart';
import 'package:shitty_esp_ble_generator/arduino_firmware_generator/esp_ble_project_builder.dart';
import 'package:shitty_esp_ble_generator/arduino_firmware_generator/property_item.dart';
import 'package:shitty_esp_ble_generator/generator/generator_config_model.dart';
import 'package:uuid/uuid.dart';
import 'dart:html' as webFile;

class GeneratorConfigViewModel extends ValueNotifier<GeneratorConfigModel> {
  GeneratorConfigViewModel(GeneratorConfigModel value) : super(value);
  Future<Map<String, String>> _generateSourceCode() async {
    value = value.copyWith(
      deviceName: deviceName.text,
      manufacturer: manufacturer.text,
      serviceUUID: serviceUUID.text,
    );
    String template = await rootBundle.loadString("assets/base.tmpl");

    return EspBleProjectBuilder(
            firmwareTemplate: template,
            deviceName: value.deviceName!,
            manufacturer: value.manufacturer!,
            serviceUUID: value.serviceUUID!,
            properties: value.characteristics)
        .build();
  }

  void startGeneration() {
    if (_validate()) {
      _generateSourceCode().then(_onGenerated);
    }
  }

  bool _validate() {
    if (serviceUUID.text.length < 12) {
      value = value.copyWith(
          errors: "UUID сервиса маловат(нужно 12 символов минимум)");
      return false;
    }
    if (deviceName.text.length < 3) {
      value =
          value.copyWith(errors: "Разве это название ? (минимум 3 символа)");
      return false;
    }
    if (manufacturer.text.length < 3) {
      value =
          value.copyWith(errors: "А как же производитель? (минимум 3 символа)");
      return false;
    }
    if (value.characteristics.isEmpty) {
      value =
          value.copyWith(errors: "А характеристики ? Оно без них не работает");
      return false;
    }
    value = value.copyWith(errors: "");

    return true;
  }

  void _onGenerated(Map<String, String> sourceCode) {
    var archive = Archive();
    sourceCode.forEach((name, code) {
      var bytes = Uint8List.fromList(code.codeUnits);
      archive.addFile(ArchiveFile.noCompress(name, bytes.length, bytes));
    });
    var zippedArchive = ZipEncoder().encode(archive);

    if (kIsWeb) {
      var blob = webFile.Blob([zippedArchive!], 'application/zip', 'native');

      var anchorElement = webFile.AnchorElement(
          href: webFile.Url.createObjectUrlFromBlob(blob).toString())
        ..setAttribute("download", "project.zip")
        ..click();
    }
  }

  final TextEditingController deviceName = TextEditingController();
  final TextEditingController manufacturer = TextEditingController();
  final TextEditingController serviceUUID = TextEditingController();

  void addCharacteristic(CharacteristicItem i) {
    value = value.copyWith(characteristics: [...value.characteristics, i]);
  }

  void deleteCharacteristic(CharacteristicItem i) {
    value = value.copyWith(
        characteristics:
            value.characteristics.where((element) => element != i).toList());
  }

  void generateUUID() {
    serviceUUID.text = Uuid().v4();
  }

  Future<void> doImport(String scheme) async {
    Map parsedJson;
    try {
      parsedJson = jsonDecode(scheme);
    } catch (e) {
      throw Exception('Неверный формат json');
    }
    if (!parsedJson.containsKey('deviceName')) {
      throw Exception('Нет deviceName');
    }
    if (!parsedJson.containsKey('manufacturer')) {
      throw Exception('Нет manufacturer');
    }
    if (!parsedJson.containsKey('serviceUUID')) {
      throw Exception('Нет serviceUUID');
    }
    if (!parsedJson.containsKey('characteristics') ||
        parsedJson['characteristics'] is! List) {
      throw Exception('Нет characteristics');
    }
    deviceName.text = parsedJson['deviceName'];
    manufacturer.text = parsedJson['manufacturer'];
    serviceUUID.text = parsedJson['serviceUUID'];
    value = value.copyWith(
        characteristics: (parsedJson['characteristics'] as List)
            .map<CharacteristicItem>((item) {
      return CharacteristicItem.fromMap(item);
    }).toList());
  }
}
