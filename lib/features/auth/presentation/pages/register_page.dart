import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trix_donation/core/theme/colors.dart';
import 'package:trix_donation/core/theme/text_style.dart';
import 'package:trix_donation/features/auth/presentation/cubit/registration/registration_cubit.dart';
import 'package:trix_donation/features/auth/presentation/pages/email_verification_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final registrationCubit = RegistrationCubit();

  final _formKey = GlobalKey<FormState>();

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
            mainAxisAlignment: MainAxisAlignment.start,
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
                      'Реєстрація',
                      style: headlineMediumText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Приєднюйся аби змінювати країну',
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
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 40),
                TextFormField(
                  style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
                  controller: emailController,
                  validator: emailValidator,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelStyle: bodyMedium14Text.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                    labelText: 'Email',
                    hintText: 'hello@world.ua',
                  ),
                ),
                const SizedBox(height: 28),
                TextFormField(
                  style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
                  controller: passwordController,
                  validator: passwordValidator,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Пароль',
                    labelStyle: bodyMedium14Text.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                    hintText: '************',
                  ),
                ),
                const SizedBox(height: 28),
                TextFormField(
                  style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
                  controller: confirmPasswordController,
                  validator: samePasswordValidator,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelStyle: bodyMedium14Text.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                    labelText: 'Повторіть пароль',
                    hintText: '************',
                  ),
                ),
                const SizedBox(height: 90),
                BlocConsumer<RegistrationCubit, RegistrationState>(
                  bloc: registrationCubit,
                  listener: (context, state) {
                    if (state is RegistrationSuccess) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EmailVerificationPage(email: emailController.text)));
                    } else if (state is RegistrationFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message,
                              style: bodyMediumText.copyWith(
                                  color: Theme.of(context).colorScheme.onError)),
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is RegistrationLoading) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          registrationCubit.register(emailController.text, passwordController.text);
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
                              'Зареєструватись',
                              style: bodySemiBoldText.copyWith(
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(Icons.login,
                                size: 24, color: Theme.of(context).colorScheme.onPrimaryContainer),
                          ]),
                    );
                  },
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Маєте акаунт?',
                        style: bodyMedium14Text.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        )),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        'Авторизуватись',
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

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введіть email';
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Введіть коректний email';
    }

    return null;
  }

  String? samePasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Повторіть пароль';
    }

    if (value != passwordController.text) {
      return 'Паролі не співпадають';
    }

    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введіть пароль';
    }

    if (value.length < 6) {
      return 'Пароль повинен бути не менше 6 символів';
    }

    return null;
  }
}
