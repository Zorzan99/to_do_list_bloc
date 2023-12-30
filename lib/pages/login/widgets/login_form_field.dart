import 'package:flutter/material.dart';
import 'package:to_do_list_bloc/core/sizes/padding_size.dart';

class LoginFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final IconData icon;
  final String hintText;

  const LoginFormField({
    Key? key,
    this.validator,
    this.controller,
    this.keyboardType,
    required this.hintText,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: const EdgeInsets.only(top: PaddingSize.l),
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
