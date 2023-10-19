import 'package:flutter/material.dart';

class EntryForm extends StatelessWidget {
  const EntryForm({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: true,
      decoration: InputDecoration(
        label: Text(label),
        hintText: label,
      ),
    );
  }
}
