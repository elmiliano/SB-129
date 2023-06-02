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
  PageController pageController = PageController(keepPage: false);
  int index = 0;

  List pages = <Widget>[
    const TempScreen(),
    const HumidityScreen(),
    GraphScreen(key: UniqueKey())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (int index) {
                    changeScreen(index);
                  },
                  controller: pageController,
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 125,
          child: BottomNavigationBar(
            selectedItemColor: const Color.fromRGBO(48, 50, 61, 200),
            items: const [
              BottomNavigationBarItem(
                  label: "temperatura",
                  icon: Icon(Icons.thermostat_sharp, size: 35)),
              BottomNavigationBarItem(
                  label: "humedad",
                  icon: Icon(Icons.water_drop_rounded, size: 35)),
              BottomNavigationBarItem(
                  label: "historial",
                  icon: Icon(Icons.auto_graph_outlined, size: 35)),
            ],
            currentIndex: pageIndex,
            onTap: (int index) {
              changeScreen(index);
            },
          ),
        ));
  }
}
