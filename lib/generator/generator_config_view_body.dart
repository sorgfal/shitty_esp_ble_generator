import 'package:flutter/material.dart';
import 'package:shitty_esp_ble_generator/arduino_firmware_generator/property_item.dart';
import 'package:shitty_esp_ble_generator/generator/characteristic_add_tile.dart';
import 'package:shitty_esp_ble_generator/generator/characteristic_tile.dart';
import 'package:shitty_esp_ble_generator/generator/generator_config_view_model.dart';
import 'package:shitty_esp_ble_generator/widgets/custom_text_field.dart';
import 'package:shitty_esp_ble_generator/widgets/type_text.dart';
import 'generator_config_model.dart';

class GeneratorConfigViewBody extends StatelessWidget {
  final GeneratorConfigViewModel viewModel;
  final GeneratorConfigModel model;
  const GeneratorConfigViewBody(
      {Key? key, required this.model, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.grey,
      ),
      child: Container(
        width: 800,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(color: Colors.grey[50]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (model.errors != null && model.errors!.isNotEmpty)
                  Expanded(child: Text(model.errors!)),
                TextButton(
                    onPressed: viewModel.startGeneration,
                    child: Text('Сгенерируй'))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: SizedBox(
                height: 60,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      flex: 10,
                      child: CustomTextField(
                        label: "Название производителя",
                        controller: viewModel.manfucaturer,
                        formatter: RegExp('[a-zA-Z]'),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Flexible(
                      flex: 10,
                      child: CustomTextField(
                        label: "Название устройства",
                        controller: viewModel.deviceName,
                        formatter: RegExp('[a-zA-Z]'),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Flexible(
                      flex: 10,
                      child: CustomTextField(
                        label: "Уникальный id (UUID v4)",
                        controller: viewModel.serviceUUID,
                        formatter: RegExp('[a-zA-Z0-9-]'),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: ListView(
              children: model.characteristics
                  .map<Widget>((e) => CharacteristicTile(
                      characteristicItem: e, viewModel: viewModel))
                  .toList()
                ..add(CharacteristicAdditionTile(viewModel: viewModel)),
            ))
          ],
        ),
      ),
    );
  }
}
