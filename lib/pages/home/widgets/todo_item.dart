import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onLongPress;
  final VoidCallback onTap;

  const TodoItem(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.onLongPress,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      onLongPress: onLongPress,
      onTap: onTap,
    );
  }
}
