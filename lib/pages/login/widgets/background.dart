import 'package:flutter/material.dart';
import 'package:to_do_list_bloc/core/sizes/screen_size.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize.screenHeight(context),
      width: ScreenSize.screenWidth(context),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0XFF73AEF5),
            Color(0xff61a4f1),
            Color(0XFF478de0),
            Color(0XFF398ae5),
          ],
          stops: [0.1, 0.4, 0.7, 0.9],
        ),
      ),
    );
  }
}
