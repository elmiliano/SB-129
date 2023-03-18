import 'package:flutter/material.dart';
import 'package:sb129/screens/screens.dart';

class NavbarScreen extends StatefulWidget {
  NavbarScreen({super.key});

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
        appBar: AppBar(title: const Text('Navbar Screen')),
        body: SizedBox.expand(
          child: PageView(
            controller: pageController,
            onPageChanged: changeScreen,
            children: pages,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
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
