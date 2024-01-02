import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  final String title;
  final String perfilTitle;
  final String exitTitle;
  final VoidCallback onTapPerfil;
  final VoidCallback onPressedExit;

  const HomeDrawer({
    Key? key,
    required this.title,
    required this.perfilTitle,
    required this.exitTitle,
    required this.onTapPerfil,
    required this.onPressedExit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            title: Text(perfilTitle),
            onTap: onTapPerfil,
          ),
          ListTile(
            title: Text(exitTitle),
            onTap: onPressedExit,
          ),
        ],
      ),
    );
  }
}
