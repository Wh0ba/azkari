import 'package:azkari/pages/home_page.dart';
import 'package:azkari/pages/taspeeh_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key});

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> with TickerProviderStateMixin {
  List<Widget> pages = [const HomePage(), const TaspeehPage()];
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: GNav(
          textStyle: const TextStyle(
            fontFamily: 'Amiri',
            fontSize: 17,
          ),
          gap: 10,
          tabMargin: const EdgeInsets.only(bottom: 10),
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          tabs: [
            GButton(
              padding: const EdgeInsets.all(10),
              backgroundColor: Theme.of(context).colorScheme.surface,
              icon: Icons.home,
              text: 'أذكاري',
            ),
            GButton(
              backgroundColor: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.all(10),
              icon: Icons.timelapse,
              text: 'سبحتي',
            ),
          ],
          onTabChange: (value) {
            setState(() {
              _controller.index = value;
            });
          },
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _controller,
          children: const [HomePage(), TaspeehPage()],
        ));
  }
}
