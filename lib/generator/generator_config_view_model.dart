import 'package:flutter/material.dart';
import 'package:shitty_esp_ble_generator/arduino_firmware_generator/esp_ble_code_builder.dart';

import 'package:shitty_esp_ble_generator/arduino_firmware_generator/property_item.dart';
import 'package:shitty_esp_ble_generator/generator/generator_config_model.dart';

class GeneratorConfigViewModel extends ValueNotifier<GeneratorConfigModel> {
  GeneratorConfigViewModel(GeneratorConfigModel value) : super(value);
}
