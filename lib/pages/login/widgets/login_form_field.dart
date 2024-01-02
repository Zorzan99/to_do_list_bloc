import 'package:flutter/material.dart';
import 'package:to_do_list_bloc/core/sizes/radius_size.dart';
import 'package:to_do_list_bloc/core/sizes/text_size.dart';

class GlobalFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final IconData icon;
  final IconData? suffixIcon;
  final String hintText;
  final bool obscureText;
  final VoidCallback? onTap;

  const GlobalFormField({
    Key? key,
    this.validator,
    this.controller,
    this.keyboardType,
    required this.icon,
    this.suffixIcon,
    required this.hintText,
    this.obscureText = false,
    this.onTap,
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
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(20),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        prefixIcon: Icon(icon, color: Colors.white),
        suffixIcon: IconButton(
          onPressed: onTap,
          icon: Icon(
            suffixIcon,
            color: Colors.white,
          ),
        ),
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
