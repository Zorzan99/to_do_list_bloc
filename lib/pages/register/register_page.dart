import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_bloc/core/widgets/button.dart';
import 'package:to_do_list_bloc/pages/login/widgets/login_form_field.dart';
import 'package:to_do_list_bloc/pages/register/register_cubit.dart';
import 'package:to_do_list_bloc/pages/register/register_state.dart';
import 'package:to_do_list_bloc/routes/routes.dart';
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
  final _userNameEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<RegisterCubit>();

    return Scaffold(
      backgroundColor: const Color(0XFF73AEF5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(Routes.loginRoute),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'To-Do-List',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is FailureRegister) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Erro ao criar conta',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.redAccent,
                ),
              );
            } else if (state is LoadedRegister) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Routes.loginRoute, (route) => false);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Conta criada com sucesso, efetue o login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.blueAccent,
                ),
              );
            }
          },
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
            }
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GlobalFormField(
                    hintText: "Nome",
                    icon: Icons.person,
                    validator: Validatorless.required('Nome é obrigatório'),
                    controller: _userNameEC,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16.0),
                  GlobalFormField(
                    hintText: "E-mail",
                    icon: Icons.email,
                    validator: Validatorless.multiple([
                      Validatorless.required('E-mail obrigatório'),
                      Validatorless.email('E-mail inválido'),
                    ]),
                    controller: _emailEC,
                  ),
                  const SizedBox(height: 16.0),
                  GlobalFormField(
                    hintText: "Senha",
                    suffixIcon: cubit.isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onTap: () {
                      cubit.togglePasswordVisibility();
                    },
                    icon: Icons.lock,
                    validator: Validatorless.required('Senha obrigatória'),
                    controller: _passwordEC,
                    obscureText: cubit.isPasswordVisible,
                  ),
                  const SizedBox(height: 32.0),
                  Button(
                    label: "CRIAR CONTA",
                    onPressed: () async {
                      final valid = _formKey.currentState?.validate() ?? false;
                      if (valid) {
                        cubit.register(
                            _emailEC.text, _passwordEC.text, _userNameEC.text);
                      }
                    },
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
