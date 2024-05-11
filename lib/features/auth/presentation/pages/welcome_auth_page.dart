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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SvgPicture.asset(
              'asset/images/Logo.svg',
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 100),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: bg100Color,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 40),
                    Text(
                      'Вітаємо!',
                      style: headlineSemiBoldText,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Долучіться до зборів, тим самим допоміжть волонтарам реалізувати їхню допомогу!',
                      style: bodyMediumText,
                    ),
                    const SizedBox(height: 48),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        backgroundColor: primary100Color,
                      ),
                      child: Wrap(children: [
                        Text(
                          'Авторизація',
                          style: bodySemiBoldText,
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.login,
                          size: 24,
                        ),
                      ]),
                    ),
                    const SizedBox(height: 14),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          'Зареєструватись',
                          style: bodyMedium14Text,
                        )),
                    const SizedBox(height: 36),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
