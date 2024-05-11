import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:trix_donation/core/theme/colors.dart';
import 'package:trix_donation/core/theme/text_style.dart';
import 'package:trix_donation/features/auth/presentation/cubit/email_verification/email_verification_cubit.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key, required this.email});

  final String email;

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  bool _onEditing = true;
  String _code = '';

  EmailVerificationCubit emailVerificationCubit = EmailVerificationCubit();

  late String _email;

  @override
  void initState() {
    super.initState();

    _email = widget.email;
    emailVerificationCubit.sendEmail(_email);
  }

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
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
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
                'Підтвердіть ваш профіль',
                style: headlineSemiBoldText.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Без проблем, відновимо! Вкажіть ваш Email для відновлення!',
                style: bodyMediumText.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 28),
              Align(
                alignment: Alignment.center,
                child: VerificationCode(
                  textStyle: headlineSemiBoldText.copyWith(
                      fontSize: 34, color: Theme.of(context).colorScheme.onPrimaryContainer),
                  keyboardType: TextInputType.number,
                  underlineColor: accent200Color,
                  length: 6,
                  cursorColor: accent100Color,
                  itemSize: 52,
                  digitsOnly: true,
                  fillColor: Theme.of(context).colorScheme.primaryContainer,
                  onCompleted: (String value) {
                    setState(() {
                      _code = value;
                    });
                  },
                  onEditing: (bool value) {
                    setState(() {
                      _onEditing = value;
                    });
                    if (!_onEditing) FocusScope.of(context).unfocus();
                  },
                ),
              ),
              const SizedBox(height: 90),
              BlocConsumer<EmailVerificationCubit, EmailVerificationState>(
                bloc: emailVerificationCubit,
                listener: (context, state) {
                  if (state is EmailVerificationSended) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message,
                            style: bodyMediumText.copyWith(
                                color: Theme.of(context).colorScheme.onTertiaryContainer)),
                        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                      ),
                    );
                  }
                  if (state is EmailVerificationError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message,
                            style: bodyMediumText.copyWith(
                                color: Theme.of(context).colorScheme.onErrorContainer)),
                        backgroundColor: Theme.of(context).colorScheme.errorContainer,
                      ),
                    );
                  }
                  if (state is EmailVerificationCodeVerified) {
                    Navigator.pushNamed(context, '/login');
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.message,
                          style: bodyMediumText.copyWith(
                              color: Theme.of(context).colorScheme.onTertiaryContainer)),
                      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                    ));
                  }
                  if (state is EmailVerificationCodeError) {
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
                  if (state is EmailVerificationLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        emailVerificationCubit.verificate(_email, _code);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                      ),
                      child: Text(
                        'Підтвердити Email',
                        style: bodySemiBoldText.copyWith(
                          color: Theme.of(context).colorScheme.onTertiaryContainer,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 28),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    emailVerificationCubit.sendEmail(_email);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Text(
                    'Відправити ще раз',
                    style: bodySemiBoldText.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
