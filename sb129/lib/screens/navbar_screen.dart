import 'package:flutter/material.dart';
import 'package:sb129/screens/screens.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  void changeScreen(index) {
    num diff = pageIndex - index;
    pageIndex = index;

    if ((diff).abs() > 1) {
      pageController.jumpToPage(index);
    } else {
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    }
    setState(() {});
  }

  int pageIndex = 0;
  PageController pageController = PageController();

  final pages = [
    const TempScreen(),
    const HumidityScreen(),
    const GraphScreen()
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: pageController,
                  onPageChanged: changeScreen,
                  children: pages,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: const Color.fromRGBO(106, 213, 203, 100),
          items: const [
            BottomNavigationBarItem(
                label: "temperature", icon: Icon(Icons.thermostat_sharp)),
            BottomNavigationBarItem(
                label: "humidity", icon: Icon(Icons.water_drop_rounded)),
            BottomNavigationBarItem(
                label: "graph", icon: Icon(Icons.auto_graph_outlined)),
          ],
          currentIndex: pageIndex,
          onTap: (int index) {
            changeScreen(index);
          },
        ));
  }
}
