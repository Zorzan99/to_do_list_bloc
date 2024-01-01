import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_bloc/core/sizes/padding_size.dart';
import 'package:to_do_list_bloc/core/sizes/spacing_size.dart';
import 'package:to_do_list_bloc/core/widgets/button.dart';
import 'package:to_do_list_bloc/pages/login/login_cubit.dart';
import 'package:to_do_list_bloc/pages/login/login_state.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'To-Do-List',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: const Color(0XFF73AEF5),
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
                      Text(
                        'Erro ao realizar login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.redAccent,
                ),
              );
            } else if (state is LoadedLogin) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.homeRoute,
                (route) => true,
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(PaddingSize.g),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginFormField(
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required('E-mail obrigatório'),
                        Validatorless.email('E-mail inválido'),
                      ],
                    ),
                    controller: _emailEC,
                    hintText: "Insira seu e-mail",
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: SpacingSize.xl,
                  ),
                  LoginFormField(
                    controller: _passwordEC,
                    validator: Validatorless.required('Senha obrigatória'),
                    hintText: "Insira sua senha",
                    icon: Icons.lock,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: SpacingSize.xl,
                  ),
                  Visibility(
                    visible: state is! LoadingLogin,
                    replacement: const Column(
                      children: [
                        CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                        SizedBox(height: SpacingSize.xx),
                        Text(
                          'Realizando Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    child: Button(
                      label: "LOGIN",
                      onPressed: () async {
                        final valid =
                            _formKey.currentState?.validate() ?? false;
                        if (valid) {
                          await cubit.login(
                            _emailEC.text,
                            _passwordEC.text,
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: SpacingSize.xl,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Não tem conta?",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        width: SpacingSize.xx,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.registerRoute);
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
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
