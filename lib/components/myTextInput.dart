import 'package:flutter/material.dart';

class MyTextInput extends StatelessWidget {
  final String labelText;
  final TextEditingController? txtController;
  final String? Function(String?)? validator;

  const MyTextInput({super.key, required this.labelText, required this.txtController, required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      validator: validator,
      controller: txtController,
    ); 
  }
}