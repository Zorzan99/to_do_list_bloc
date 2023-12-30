import 'package:flutter/material.dart';
import 'package:to_do_list_bloc/core/sizes/radius_size.dart';
import 'package:to_do_list_bloc/core/sizes/screen_size.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double? height;
  const Button({
    Key? key,
    required this.label,
    required this.onPressed,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: ScreenSize.screenWidth(context),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RadiusSize.xxl),
          ),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
