import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trix_donation/core/theme/colors.dart';
import 'package:trix_donation/core/theme/text_style.dart';
import 'package:trix_donation/features/auth/presentation/cubit/forgot_password/forgot_password_cubit.dart';

import 'change_forgot_password_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final ForgotPasswordCubit _forgotPasswordCubit = ForgotPasswordCubit();

  final TextEditingController _emailController = TextEditingController();

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
                    padding: const EdgeInsets.only(left: 8.0, top: 10, bottom: 10),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      color: text100Color,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'asset/icons/forgot_password.svg',
                      width: 150,
                      height: 150,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 40),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(40),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Забули пароль?',
                style: headlineSemiBoldText.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              const SizedBox(height: 4),
              Text(
                'Долучіться до зборів, тим самим допоміжть волонтарам реалізувати їхню допомогу!',
                style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
              const SizedBox(height: 28),
              TextField(
                style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
                controller: _emailController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Email',
                  labelStyle:
                      bodyMedium14Text.copyWith(color: Theme.of(context).colorScheme.onBackground),
                  hintText: 'hello@world.ua',
                ),
              ),
              const SizedBox(height: 90),
              BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                bloc: _forgotPasswordCubit,
                listener: (context, state) {
                  if (state is ForgotPasswordSuccess) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeForgotPasswordPage(
                          email: _emailController.text,
                        ),
                      ),
                    );
                  }

                  if (state is ForgotPasswordFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message,
                            style: bodyMediumText.copyWith(
                                color: Theme.of(context).colorScheme.onError)),
                        backgroundColor: Theme.of(context).colorScheme.errorContainer,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ForgotPasswordLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        _forgotPasswordCubit.forgotPassword(_emailController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      child: Wrap(children: [
                        Text(
                          'Відновити пароль',
                          style: bodySemiBoldText.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryContainer),
                        ),
                      ]),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
