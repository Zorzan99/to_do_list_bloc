import 'package:flutter/material.dart';

class HomeFormFiel extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const HomeFormFiel({
    super.key,
    required this.title,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      decoration: InputDecoration(
        hintText: title,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      controller: controller,
    );
  }
}
