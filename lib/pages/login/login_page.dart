import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_bloc/core/sizes/radius_size.dart';
import 'package:to_do_list_bloc/core/sizes/screen_size.dart';
import 'package:to_do_list_bloc/core/sizes/spacing_size.dart';
import 'package:to_do_list_bloc/pages/login/login_cubit.dart';
import 'package:to_do_list_bloc/pages/login/login_state.dart';
import 'package:to_do_list_bloc/pages/login/widgets/login_box_field.dart';
import 'package:to_do_list_bloc/pages/login/widgets/login_form_field.dart';
import 'package:to_do_list_bloc/routes/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<LoginCubit>();

    return Scaffold(
      body: Form(
        key: _formKey,
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state is LoadingLogin) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: CircularProgressIndicator()),
                  SizedBox(height: 16),
                  Center(child: Text('Realizando Login...')),
                ],
              );
            } else if (state is LoadedLogin) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/home', (route) => false);
              });
            } else if (state is FailureLogin) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Erro ao realizar login'),
                      ],
                    ),
                  ),
                );
              });
            }

            return Stack(
              children: [
                Container(
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
                ),
                SizedBox(
                  height: ScreenSize.screenHeight(context),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 120,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'To-Do-List',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: SpacingSize.xxl,
                        ),
                        LoginBoxField(
                          label: 'E-mail',
                          child: LoginFormField(
                            controller: _emailEC,
                            hintText: "Insiria seu e-mail",
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        const SizedBox(
                          height: SpacingSize.xl,
                        ),
                        const LoginBoxField(
                          label: "Senha",
                          child: LoginFormField(
                            hintText: "Insiria sua senha",
                            icon: Icons.lock,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        const SizedBox(
                          height: SpacingSize.xl,
                        ),
                        SizedBox(
                          height: 50,
                          width: ScreenSize.screenWidth(context),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(RadiusSize.xxl),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text("LOGIN"),
                          ),
                        ),
                        const SizedBox(
                          height: SpacingSize.xl,
                        ),
                        Row(
                          children: [
                            const Text("Não tem conta?"),
                            const SizedBox(
                              width: SpacingSize.xx,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.registerRoute);
                              },
                              child: const Text(
                                "Cadastre-se agora!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

//  Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const FlutterLogo(size: 100),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     controller: _emailEC,
//                     validator: Validatorless.multiple([
//                       Validatorless.required('E-mail obrigatório'),
//                       Validatorless.email('E-mail inválido'),
//                     ]),
//                     decoration: InputDecoration(
//                       labelText: 'E-mail',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(RadiusSize.g),
//                       ),
//                     ),
//                     keyboardType: TextInputType.emailAddress,
//                   ),
//                   const SizedBox(height: 8),
//                   TextFormField(
//                     controller: _passwordEC,
//                     validator: Validatorless.required('Senha obrigatória'),
//                     decoration: const InputDecoration(
//                       labelText: 'Senha',
//                     ),
//                     obscureText: true,
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () async {
//                       final valid = _formKey.currentState?.validate() ?? false;
//                       if (valid) {
//                         cubit.login(_emailEC.text, _passwordEC.text);
//                       }
//                     },
//                     child: const Text('Login'),
//                   ),
//                   const SizedBox(height: 8),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pushNamed(context, Routes.registerRoute);
//                     },
//                     child: const Text(
//                       'Não tem uma conta? Cadastre-se!',
//                       style: TextStyle(color: Colors.blue),
//                     ),
//                   ),
//                 ],
//               );
}
