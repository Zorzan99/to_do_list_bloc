import 'package:flutter/material.dart';
import 'package:to_do_list_bloc/core/sizes/spacing_size.dart';

class LoginBoxField extends StatelessWidget {
  final Widget? child;
  final String label;

  const LoginBoxField({
    Key? key,
    this.child,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(
          height: SpacingSize.x,
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFF6CA8F1),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: child,
        ),
      ],
    );
  }
}
