import 'package:flutter/material.dart';

class TypeText extends StatelessWidget {
  final Type type;
  const TypeText({Key? key, required this.type}) : super(key: key);
  static const label = {String: "Строка", int: "Число", bool: "Булево"};

  @override
  Widget build(BuildContext context) {
    return Text(label[type].toString());
  }
}
