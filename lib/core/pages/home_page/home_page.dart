import 'package:flutter/material.dart';
import 'package:trix_donation/core/theme/colors.dart';
import 'package:trix_donation/core/theme/text_style.dart';
import 'package:trix_donation/features/organization/presentation/pages/my_oranization_page.dart';

import '../../../features/search/presentation/pages/search_page.dart';
import '../../../features/spilnota/presentation/pages/spilnota_page.dart';
import 'home_page_collections_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _bottomNavIndex = 0;

  var pages = [
    const HomePageCollectionsList(),
    const SearchPage(),
    const SpilnotaPage(),
    const MyOrganizationPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.person_rounded),
              onPressed: () {
                Navigator.pushNamed(context, '/personal_profile');
              },
            ),
          ],
          title: const Center(child: Text('TRIX Donation')),
        ),
        body: pages[_bottomNavIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _bottomNavIndex,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: bodySemiBold14Text,
          unselectedLabelStyle: bodyMedium14Text,
          onTap: (index) {
            setState(() {
              _bottomNavIndex = index;
            });
          },
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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: primary100Color,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.add_task_rounded),
                title: Text('Створити новий збір', style: bodyMediumText),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/create_collection');
                },
              ),
            ],
          ),
        ));
  }
}
