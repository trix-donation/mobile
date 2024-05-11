import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trix_donation/core/theme/colors.dart';
import 'package:trix_donation/core/theme/text_style.dart';

class WelcomeAuthPage extends StatelessWidget {
  const WelcomeAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.5),
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
            children: <Widget>[
              const SizedBox(height: 60),
              SvgPicture.asset(
                'asset/images/Logo.svg',
                width: 300,
                height: 300,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(40),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 40),
                Text(
                  'Вітаємо!',
                  style: headlineSemiBoldText.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(height: 8),
                Text(
                  'Долучіться до зборів, тим самим допоміжть волонтарам реалізувати їхню допомогу!',
                  style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Авторизація',
                          style: bodySemiBoldText.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryContainer),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.login,
                          size: 24,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ]),
                ),
                const SizedBox(height: 14),
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.primaryContainer, width: 2),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      'Зареєструватись',
                      style: bodyMedium14Text.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer),
                    )),
                const SizedBox(height: 36),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
