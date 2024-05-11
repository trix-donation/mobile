import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trix_donation/core/theme/colors.dart';
import 'package:trix_donation/core/theme/text_style.dart';
import 'package:trix_donation/core/validators/auth_validators.dart';
import 'package:trix_donation/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:trix_donation/features/auth/presentation/pages/email_verification_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _loginFormKey = GlobalKey<FormState>();

  LoginCubit loginCubit = LoginCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.7),
            radius: 1,
            colors: [
              primary100Color,
              accent200Color,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 10),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      color: text100Color,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Авторизація',
                      style: headlineMediumText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Змінюй країну разом з нами :)',
                      style: bodyMediumText,
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(40),
          ),
        ),
        child: Form(
          key: _loginFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                TextFormField(
                  validator: emailValidator,
                  style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Email',
                    labelStyle: bodyMedium14Text.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                    hintText: 'hello@world.ua',
                  ),
                ),
                const SizedBox(height: 28),
                TextFormField(
                  controller: _passwordController,
                  validator: passwordValidator,
                  style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Пароль',
                    labelStyle: bodyMedium14Text.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                    hintText: '************',
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgot_password');
                    },
                    child: Text(
                      'Забули пароль?',
                      style: bodySemiBold14Text.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 90),
                BlocConsumer<LoginCubit, LoginState>(
                  bloc: loginCubit,
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      Navigator.pushNamed(context, '/home');
                    }

                    if (state is LoginFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(state.message,
                                style: bodyMediumText.copyWith(
                                    color: Theme.of(context).colorScheme.onErrorContainer)),
                            backgroundColor: Theme.of(context).colorScheme.errorContainer),
                      );
                    }

                    if (state is LoginNeedActivateEmail) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message,
                              style: bodyMediumText.copyWith(
                                  color: Theme.of(context).colorScheme.secondaryContainer)),
                          backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
                        ),
                      );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EmailVerificationPage(email: state.email)));
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return const CircularProgressIndicator();
                    }

                    return ElevatedButton(
                      onPressed: () {
                        if (_loginFormKey.currentState!.validate()) {
                          loginCubit.login(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Авторизація',
                              style: bodySemiBoldText.copyWith(
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.login,
                              size: 24,
                            ),
                          ]),
                    );
                  },
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Немаєте акаунту?',
                      style: bodySemiBold14Text.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text(
                        'Зареєструватись',
                        style: bodySemiBold14Text.copyWith(
                          color: primary100Color,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
