import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:trix_donation/core/theme/text_style.dart';
import 'package:trix_donation/core/widgets/zbir_card.dart';

import '../../storage/first_time_enter_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    if (GetIt.I<FirstTimeEnterStorage>().isFirstTimeEnter ?? true) {
      Navigator.pushNamedAndRemoveUntil(context, '/onBoarding', (route) => false);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_rounded),
            onPressed: () {},
          ),
        ],
        title: const Center(child: Text('TRIX Donation')),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: ListView.separated(
          itemCount: 4,
          itemBuilder: (context, index) {
            return const ZbirCard();
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 20);
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: bodySemiBold14Text,
        unselectedLabelStyle: bodyMedium14Text,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Головна',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Пошук',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_people_rounded),
            label: 'Спільнота',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_center_rounded),
            label: 'Організація',
          ),
        ],
      ),
    );
  }
}
