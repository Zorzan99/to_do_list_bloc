import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_bloc/firebase_options.dart';
import 'package:to_do_list_bloc/pages/home/home_cubit.dart';
import 'package:to_do_list_bloc/pages/login/login_cubit.dart';
import 'package:to_do_list_bloc/pages/register/register_cubit.dart';
import 'package:to_do_list_bloc/repositories/home/home_repository.dart';
import 'package:to_do_list_bloc/repositories/home/home_repository_impl.dart';
import 'package:to_do_list_bloc/repositories/login/login_repository.dart';
import 'package:to_do_list_bloc/repositories/login/login_repository_impl.dart';
import 'package:to_do_list_bloc/repositories/register/register_repository.dart';
import 'package:to_do_list_bloc/repositories/register/register_repository_impl.dart';
import 'package:to_do_list_bloc/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // CRIAR CLASSE DE TAMANHOS PARA BORDERRADIUS, PADDING, SIZEDBOX
        // CRIAR ARQUIVO PARA TRABALHAR COM RESPONSIVIDADE
        // GLOBALIZAR PROVIDERS,
        // CONFIGURAR THEMA(FONTES, COR PRINCIPAL, ETC),

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
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: Routes.generateRoute,
        initialRoute: Routes.loginRoute,
      ),
    );
  }
}
