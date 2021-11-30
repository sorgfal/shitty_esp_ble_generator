import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final RegExp formatter;
  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.label,
      required this.formatter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(isDense: true, labelText: label),
      controller: controller,
      inputFormatters: [FilteringTextInputFormatter.allow(formatter)],
    );
  }
}
