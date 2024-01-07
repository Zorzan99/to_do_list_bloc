import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_bloc/pages/home/home_cubit.dart';
import 'package:to_do_list_bloc/pages/login/login_cubit.dart';
import 'package:to_do_list_bloc/pages/register/register_cubit.dart';
import 'package:to_do_list_bloc/repositories/home/home_repository.dart';
import 'package:to_do_list_bloc/repositories/home/home_repository_impl.dart';
import 'package:to_do_list_bloc/repositories/login/login_repository.dart';
import 'package:to_do_list_bloc/repositories/login/login_repository_impl.dart';
import 'package:to_do_list_bloc/repositories/register/register_repository.dart';
import 'package:to_do_list_bloc/repositories/register/register_repository_impl.dart';

class ProvidersApp extends StatelessWidget {
  final Widget child;

  const ProvidersApp({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginRepository>(
          create: (context) =>
              LoginRepositoryImpl(firebaseAuth: FirebaseAuth.instance),
        ),
        Provider<LoginCubit>(
          create: (context) => LoginCubit(
            context.read<LoginRepository>(),
          ),
        ),
        Provider<RegisterRepository>(
          create: (context) =>
              RegisterRepositoryImpl(firebaseAuth: FirebaseAuth.instance),
        ),
        Provider<RegisterCubit>(
          create: (context) => RegisterCubit(
            context.read<RegisterRepository>(),
          ),
        ),
        Provider<HomeRepository>(
          create: (context) => HomeRepositoryImpl(),
        ),
        Provider<HomeCubit>(
          create: (context) => HomeCubit(
            context.read<HomeRepository>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
