import 'package:flutter/material.dart';
import 'package:shitty_esp_ble_generator/generator/generator_config_view_model.dart';

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
      child: Column(
        children: [
          Row(
            children: [
              TextField(
                controller: viewModel.manfucaturer,
              ),
              TextField(
                controller: viewModel.deviceName,
              ),
              TextField(
                controller: viewModel.serviceUUID,
              )
            ],
          )
        ],
      ),
    );
  }
}
