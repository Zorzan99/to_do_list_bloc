import 'package:flutter/material.dart';
import 'package:to_do_list_bloc/core/sizes/radius_size.dart';
import 'package:to_do_list_bloc/core/sizes/text_size.dart';

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
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(RadiusSize.g),
      borderSide: const BorderSide(color: Colors.white),
    );
    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(RadiusSize.g),
      borderSide: BorderSide(color: Colors.redAccent[200]!),
    );
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(20),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        prefixIcon: Icon(icon, color: Colors.white),
        errorBorder: errorBorder,
        focusedErrorBorder: border,
        errorStyle:
            TextStyle(color: Colors.redAccent[200]!, fontSize: TextSize.l),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
