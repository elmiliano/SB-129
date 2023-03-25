import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        // appBar: AppBar(title: const Text('Navbar Screen')),
        body: Column(
          children: [
            Container(
              height: 10,
              color: Color.fromRGBO(228, 228, 228, 100),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 66,
                      width: 66,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          color: Color.fromRGBO(106, 213, 203, 100)),
                    ),
                    Expanded(
                      child: Container(
                        height: 66,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(228, 228, 228, 100)),
                        child: Text(
                          "temperatura",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.raleway(
                              fontSize: 48,
                              color: const Color.fromRGBO(139, 139, 139, 100)),
                        ),
                      ),
                    ),
                    Container(
                      height: 66,
                      width: 66,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          color: Color.fromRGBO(106, 213, 203, 100)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: changeScreen,
                children: pages,
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color.fromRGBO(106, 213, 203, 100),
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
