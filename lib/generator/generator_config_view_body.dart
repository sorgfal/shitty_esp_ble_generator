import 'package:flutter/material.dart';
import 'package:shitty_esp_ble_generator/arduino_firmware_generator/property_item.dart';
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
                        characteristicItem: e,
                      ))
                  .toList()
                ..add(CharacteristicAdditionTile(viewModel: viewModel)),
            ))
          ],
        ),
      ),
    );
  }
}

class CharacteristicTile extends StatelessWidget {
  final CharacteristicItem characteristicItem;
  const CharacteristicTile({Key? key, required this.characteristicItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(flex: 12, child: Text(characteristicItem.name)),
            Spacer(flex: 1),
            Flexible(flex: 4, child: TypeText(type: characteristicItem.type)),
            Spacer(flex: 1),
            Flexible(
              flex: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Изменяемый"),
                  Switch(
                    value: characteristicItem.writable,
                    onChanged: (v) {},
                  ),
                  Text("Уведомляющий"),
                  Switch(
                    value: characteristicItem.notifiable,
                    onChanged: (v) {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

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

  bool _validate() {
    if (name.text.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Имя должно содержать больше 3 символов')));
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: SizedBox(
          height: 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Добавь новую характеристику'),
                  TextButton(onPressed: add, child: Text('Добавить'))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
