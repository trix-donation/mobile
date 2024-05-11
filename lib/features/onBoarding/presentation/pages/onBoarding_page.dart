import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trix_donation/core/storage/first_time_enter_storage.dart';
import 'package:trix_donation/core/theme/colors.dart';
import 'package:trix_donation/core/theme/text_style.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        pageBackgroundGradient: const RadialGradient(
          center: Alignment(0, -0.7),
          radius: 1,
          colors: [
            primary100Color,
            accent200Color,
          ],
        ),
        totalPage: 3,
        finishButtonText: 'Почати донатити',
        finishButtonStyle: const FinishButtonStyle(
          backgroundColor: text100Color,
        ),
        onFinish: () async {
          await FirstTimeEnterStorage.setFirstTimeEnter(false);
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        },
        headerBackgroundColor: Colors.white,
        centerBackground: true,
        background: [
          Container(
              padding: const EdgeInsets.only(top: 60),
              child:
                  SvgPicture.asset('asset/onBoardingIcons/logo_text.svg', height: 250, width: 300)),
          Container(
              padding: const EdgeInsets.only(top: 60, right: 30),
              child: Image.asset('asset/onBoardingIcons/donation_services.png',
                  height: 300, width: 300)),
          Container(
              padding: const EdgeInsets.only(top: 60),
              child: SvgPicture.asset('asset/onBoardingIcons/time_notification.svg',
                  height: 200, width: 200)),
        ],
        speed: 1.8,
        pageBodies: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 480,
                ),
                Text('Платформа для легкого та надійного збору коштів!',
                    style: headlineSemiBoldText),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 480,
                ),
                Text('Збирай донати в\nМонобанку\nКонверти\nКрипту\nтощо',
                    style: headlineSemiBoldText),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 480,
                ),
                Text('Донать зараз, а ми час від часу будем нагадувати за донати',
                    style: headlineSemiBoldText),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
