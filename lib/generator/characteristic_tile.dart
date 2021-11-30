import 'package:flutter/material.dart';
import 'package:shitty_esp_ble_generator/arduino_firmware_generator/property_item.dart';
import 'package:shitty_esp_ble_generator/generator/generator_config_view_model.dart';
import 'package:shitty_esp_ble_generator/widgets/type_text.dart';

class CharacteristicTile extends StatelessWidget {
  final CharacteristicItem characteristicItem;
  final GeneratorConfigViewModel viewModel;
  const CharacteristicTile(
      {Key? key, required this.characteristicItem, required this.viewModel})
      : super(key: key);

  delete() {
    viewModel.deleteCharacteristic(characteristicItem);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex: 12, child: Text(characteristicItem.name)),
            const Spacer(flex: 1),
            Expanded(flex: 4, child: TypeText(type: characteristicItem.type)),
            const Spacer(flex: 1),
            Expanded(
              flex: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("Изменяемый"),
                  Switch(
                    value: characteristicItem.writable,
                    onChanged: (v) {},
                  ),
                  const Text("Уведомляющий"),
                  Switch(
                    value: characteristicItem.notifiable,
                    onChanged: (v) {},
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: GestureDetector(
                onTap: delete,
                child: Icon(Icons.delete, color: Colors.grey[400]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
