import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_bloc/pages/login/login_cubit.dart';
import 'package:to_do_list_bloc/pages/login/login_state.dart';
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
  Widget build(BuildContext context) {
    final cubit = context.watch<LoginCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
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

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FlutterLogo(size: 100),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('E-mail obrigatório'),
                      Validatorless.email('E-mail inválido'),
                    ]),
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordEC,
                    validator: Validatorless.required('Senha obrigatória'),
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      final valid = _formKey.currentState?.validate() ?? false;
                      if (valid) {
                        cubit.login(_emailEC.text, _passwordEC.text);
                      }
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Não tem uma conta? Cadastre-se!',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
