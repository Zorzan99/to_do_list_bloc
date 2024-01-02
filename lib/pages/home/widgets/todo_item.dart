import 'package:flutter/material.dart';
import 'package:to_do_list_bloc/core/sizes/text_size.dart';

class TodoItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onLongPress;
  final VoidCallback onPressed;

  const TodoItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onLongPress,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: TextSize.gg,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: TextSize.l,
          color: Colors.black,
        ),
      ),
      onLongPress: onLongPress,
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: onPressed,
      ),
    );
  }
}
