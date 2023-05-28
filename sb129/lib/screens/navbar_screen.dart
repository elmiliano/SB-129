import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sb129/screens/screens.dart';
import 'package:sb129/services/services.dart';

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
    //HistTempService();
    setState(() {});
  }

  int pageIndex = 0;
  PageController pageController = PageController(keepPage: false);
  int index = 0;

  List pages = <Widget>[
    TempScreen(),
    HumidityScreen(),
    GraphScreen(key:UniqueKey())
  ];

  @override
  Widget build(BuildContext context) {
    
    //setState(() {});
    
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  //onPageChanged: changeScreen,
                  //itemCount: pages.length,
                  //children: pages,
                  itemBuilder: (context, index) {
                    
                    return pages[index];
                  },
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
            //setState(() { });
          },
        ));
  }
}
