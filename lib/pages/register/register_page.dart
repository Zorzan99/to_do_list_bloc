import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_bloc/pages/register/register_cubit.dart';
import 'package:to_do_list_bloc/pages/register/register_state.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<RegisterCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            if (state is LoadingRegister) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: CircularProgressIndicator()),
                  SizedBox(height: 16),
                  Center(child: Text('Criando Conta...')),
                ],
              );
            } else if (state is LoadedRegister) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/home', (route) => false);
              });
            } else if (state is FailureRegister) {
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
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    validator: Validatorless.multiple([
                      Validatorless.required('E-mail obrigatório'),
                      Validatorless.email('E-mail inválido'),
                    ]),
                    controller: _emailEC,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    validator: Validatorless.required('Senha obrigatória'),
                    controller: _passwordEC,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () async {
                      final valid = _formKey.currentState?.validate() ?? false;
                      if (valid) {
                        cubit.register(_emailEC.text, _passwordEC.text);
                      }
                    },
                    child: const Text('Login'),
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
