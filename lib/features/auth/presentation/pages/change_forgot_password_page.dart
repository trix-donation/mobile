import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trix_donation/core/theme/colors.dart';
import 'package:trix_donation/core/theme/text_style.dart';
import 'package:trix_donation/core/validators/auth_validators.dart';
import 'package:trix_donation/features/auth/presentation/cubit/forgot_password/forgot_password_cubit.dart';

class ChangeForgotPasswordPage extends StatefulWidget {
  const ChangeForgotPasswordPage({super.key, required this.email});

  final String email;

  @override
  State<ChangeForgotPasswordPage> createState() => _ChangeForgotPasswordPageState();
}

class _ChangeForgotPasswordPageState extends State<ChangeForgotPasswordPage> {
  final ForgotPasswordCubit _forgotPasswordCubit = ForgotPasswordCubit();

  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

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
        child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          bloc: _forgotPasswordCubit,
          listener: (context, state) {
            if (state is ForgotPasswordEmailVerified) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Введіть новий пароль",
                      style: bodyMediumText.copyWith(
                          color: Theme.of(context).colorScheme.onTertiaryContainer)),
                  backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                ),
              );
            }

            if (state is ForgotPasswordEmailVerifiedFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message,
                      style: bodyMediumText.copyWith(
                          color: Theme.of(context).colorScheme.onErrorContainer)),
                  backgroundColor: Theme.of(context).colorScheme.errorContainer,
                ),
              );
            }

            if (state is ForgotPasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Пароль змінено, тепер авторизуйтесь",
                      style: bodyMediumText.copyWith(
                          color: Theme.of(context).colorScheme.onTertiaryContainer)),
                  backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                ),
              );
              Navigator.pop(context);
              Navigator.pop(context);
            }

            if (state is ForgotPasswordFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message,
                      style: bodyMediumText.copyWith(
                          color: Theme.of(context).colorScheme.onErrorContainer)),
                  backgroundColor: Theme.of(context).colorScheme.errorContainer,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ForgotPasswordLoading) {
              return const SizedBox(
                height: 414,
                child: Center(
                  child: SingleChildScrollView(child: CircularProgressIndicator()),
                ),
              );
            }

            if (state is ForgotPasswordNeedVerifyEmail) {
              return _buildCodeVeryficationForm(context);
            } else if (state is ForgotPasswordEmailVerifiedFailed) {
              return _buildCodeVeryficationForm(context);
            }

            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      'Змініть пароль',
                      style: headlineSemiBoldText.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    const SizedBox(height: 28),
                    TextFormField(
                      style: bodyMediumText.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                      controller: _passwordController,
                      validator: passwordValidator,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Пароль',
                        labelStyle: bodyMedium14Text.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                        hintText: '******',
                      ),
                    ),
                    const SizedBox(height: 28),
                    TextFormField(
                      style: bodyMediumText.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                      controller: _repeatPasswordController,
                      validator: passwordValidator,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Повторіть пароль',
                        labelStyle: bodyMedium14Text.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                        hintText: '******',
                      ),
                    ),
                    const SizedBox(height: 90),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_passwordController.text != _repeatPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Паролі відрізняються",
                                    style: bodyMediumText.copyWith(
                                        color: Theme.of(context).colorScheme.onErrorContainer)),
                                backgroundColor: Theme.of(context).colorScheme.errorContainer,
                              ),
                            );
                          } else {
                            _forgotPasswordCubit.changeForgotPassword(
                                widget.email, _passwordController.text);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        child: Wrap(children: [
                          Text(
                            'Змінити пароль',
                            style: bodySemiBoldText.copyWith(
                                color: Theme.of(context).colorScheme.onPrimaryContainer),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String? codeValidator(String? value) {
    if (value!.length < 6) {
      return 'Код повинен містити 6 символів';
    }

    if (value.isEmpty) {
      return 'Введіть код';
    }

    return null;
  }

  Widget _buildCodeVeryficationForm(BuildContext context) {
    return Form(
      key: _formKey2,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text(
              'Підтвердіть код з пошти',
              style:
                  headlineSemiBoldText.copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(height: 28),
            TextFormField(
              style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
              controller: _codeController,
              validator: codeValidator,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Код з пошти',
                labelStyle:
                    bodyMedium14Text.copyWith(color: Theme.of(context).colorScheme.onBackground),
                hintText: '123456',
                errorText: 'Введіть код надісланий на пошту',
              ),
            ),
            const SizedBox(height: 90),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey2.currentState!.validate()) {
                    _forgotPasswordCubit.verifyEmail(widget.email, _codeController.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Wrap(children: [
                  Text(
                    'Підтвердити код',
                    style: bodySemiBoldText.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
