import 'package:flutter/material.dart';
import 'package:shitty_esp_ble_generator/arduino_firmware_generator/property_item.dart';
import 'package:shitty_esp_ble_generator/generator/generator_config_view_model.dart';
import 'package:shitty_esp_ble_generator/widgets/custom_text_field.dart';

import 'characteristic_import_dialog.dart';

class CharacteristicAdditionTile extends StatefulWidget {
  final GeneratorConfigViewModel viewModel;
  const CharacteristicAdditionTile({Key? key, required this.viewModel})
      : super(key: key);

  @override
  State<CharacteristicAdditionTile> createState() =>
      _CharacteristicAdditionTileState();
}

class _CharacteristicAdditionTileState
    extends State<CharacteristicAdditionTile> {
  bool writable = false;
  bool notifiable = false;
  Type type = int;
  late TextEditingController name;
  @override
  void initState() {
    super.initState();
    name = TextEditingController();
  }

  add() {
    if (_validate()) {
      widget.viewModel.addCharacteristic(CharacteristicItem(name.text, type,
          writable: writable, notifiable: notifiable));
    }
  }

  import() {
    CharacteristicImportDialog.show(context, widget.viewModel);
  }

  bool _validate() {
    if (name.text.length < 3) {
      return false;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Имя должно содержать больше 3 символов')));
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: SizedBox(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Добавь новую характеристику'),
                  Spacer(),
                  TextButton(onPressed: add, child: Text('Добавить')),
                  TextButton(onPressed: import, child: Text('Импортировать')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 5,
                    child: CustomTextField(
                      label: "Имя характеристики",
                      controller: name,
                      formatter: RegExp('[a-zA-Z]'),
                    ),
                  ),
                  Spacer(flex: 1),
                  Flexible(
                      flex: 3,
                      child: DropdownButton<Type>(
                          isDense: true,
                          value: type,
                          onChanged: (Type? t) {
                            if (t != null) {
                              setState(() {
                                type = t;
                              });
                            }
                          },
                          items: const [
                            DropdownMenuItem(
                              child: Text('Строка'),
                              value: String,
                            ),
                            DropdownMenuItem(
                              child: Text('Число'),
                              value: int,
                            ),
                            DropdownMenuItem(
                              child: Text('Булево'),
                              value: bool,
                            )
                          ])),
                  Spacer(flex: 1),
                  Flexible(
                    flex: 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Изменяемый"),
                        Switch(
                          value: writable,
                          onChanged: (v) {
                            setState(() {
                              writable = v;
                            });
                          },
                        ),
                        Text("Уведомляющий"),
                        Switch(
                          value: notifiable,
                          onChanged: (v) {
                            setState(() {
                              notifiable = v;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
