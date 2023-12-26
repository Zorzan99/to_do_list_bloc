import 'package:flutter/material.dart';
import 'package:to_do_list_bloc/pages/home/home_page.dart';
import 'package:to_do_list_bloc/pages/login/login_page.dart';

class Routes {
  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';
  static const String homeRoute = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case signupRoute:
      // return MaterialPageRoute(builder: (_) => SignupScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Rota desconhecida: ${settings.name}'),
            ),
          ),
        );
    }
  }
}
