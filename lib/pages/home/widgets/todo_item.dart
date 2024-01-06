import 'package:flutter/material.dart';
import 'package:to_do_list_bloc/core/sizes/text_size.dart';

class TodoItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onLongPress;
  final VoidCallback onPressed;
  final VoidCallback onDelete;

  const TodoItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onLongPress,
    required this.onPressed,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue[600],
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
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
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onPressed,
                child: const Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 10), // Espaço entre os ícones
              GestureDetector(
                onTap: onDelete,
                child: const Icon(
                  Icons.delete,
                  color: Colors.red, // Cor do ícone de exclusão
                ),
              ),
            ],
          ),
        ));
  }
}
