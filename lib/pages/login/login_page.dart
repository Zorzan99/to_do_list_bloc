import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_bloc/core/sizes/screen_size.dart';
import 'package:to_do_list_bloc/core/sizes/spacing_size.dart';
import 'package:to_do_list_bloc/core/widgets/button.dart';
import 'package:to_do_list_bloc/pages/login/login_cubit.dart';
import 'package:to_do_list_bloc/pages/login/login_state.dart';
import 'package:to_do_list_bloc/pages/login/widgets/background.dart';
import 'package:to_do_list_bloc/pages/login/widgets/login_box_field.dart';
import 'package:to_do_list_bloc/pages/login/widgets/login_form_field.dart';
import 'package:to_do_list_bloc/routes/routes.dart';
import 'package:validatorless/validatorless.dart';

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
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Scaffold(
      body: Form(
          key: _formKey,
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is FailureLogin) {
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
              } else if (state is LoadedLogin) {
                Future.delayed(const Duration(seconds: 5), () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.homeRoute, (route) => true);
                });
              }
            },
            builder: (context, state) {
              if (state is LoadingLogin) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: CircularProgressIndicator()),
                    SizedBox(height: SpacingSize.g),
                    Center(child: Text('Realizando Login...')),
                  ],
                );
              }
              return Stack(
                children: [
                  const Background(),
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
                              validator: Validatorless.multiple([
                                Validatorless.required('E-mail obrigatório'),
                                Validatorless.email('E-mail inválido'),
                              ]),
                              controller: _emailEC,
                              hintText: "Insira seu e-mail",
                              icon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          const SizedBox(
                            height: SpacingSize.xl,
                          ),
                          LoginBoxField(
                            label: "Senha",
                            child: LoginFormField(
                              controller: _passwordEC,
                              validator:
                                  Validatorless.required('Senha obrigatória'),
                              hintText: "Insira sua senha",
                              icon: Icons.lock,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          const SizedBox(
                            height: SpacingSize.xl,
                          ),
                          Button(
                            label: "LOGIN",
                            onPressed: () async {
                              final valid =
                                  _formKey.currentState?.validate() ?? false;
                              if (valid) {
                                await cubit.login(
                                    _emailEC.text, _passwordEC.text);
                              }
                            },
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
          )),
    );
  }
}
