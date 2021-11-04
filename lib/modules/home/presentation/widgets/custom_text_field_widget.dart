import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String labelText;
  final String prefix;
  final TextEditingController controller;
  final Function(String) onChanged;

  const CustomTextFieldWidget({
    Key? key,
    required this.labelText,
    required this.prefix,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ], // O
        decoration: InputDecoration(
            labelText: labelText,
            prefix: Text(prefix),
            icon: const Icon(Icons.attach_money)),
      ),
    );
  }
}
