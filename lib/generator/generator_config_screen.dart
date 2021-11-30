import 'package:flutter/material.dart';
import 'package:shitty_esp_ble_generator/generator/generator_config_model.dart';
import 'package:shitty_esp_ble_generator/generator/generator_config_view_body.dart';
import 'package:shitty_esp_ble_generator/generator/generator_config_view_model.dart';

class GeneratorConfigScreen extends StatefulWidget {
  const GeneratorConfigScreen({Key? key}) : super(key: key);

  @override
  State<GeneratorConfigScreen> createState() => _GeneratorConfigScreenState();
}

class _GeneratorConfigScreenState extends State<GeneratorConfigScreen> {
  late GeneratorConfigViewModel viewModel;
  @override
  void initState() {
    viewModel = GeneratorConfigViewModel(GeneratorConfigModel());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<GeneratorConfigModel>(
          valueListenable: viewModel,
          builder: (ctx, GeneratorConfigModel model, child) {
            return GeneratorConfigViewBody(
              model: model,
              viewModel: viewModel,
            );
          }),
    );
  }
}
