import 'package:flutter/material.dart';
import 'package:shitty_esp_ble_generator/generator/generator_config_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GeneratorConfigScreen(),
    );
  }
}
