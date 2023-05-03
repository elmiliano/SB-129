import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sb129/screens/temp_screen.dart';
import 'package:sb129/widgets/widgets.dart';

class HumidityScreen extends StatelessWidget {
  const HumidityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const TopScreenTitleWidget(
              title: 'humedad',
            ),
            Container(
              height: 262,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(106, 213, 203, 100)),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.water_outlined,
                    color: Colors.white,
                    size: 150,
                  ),
                  Text(
                    "65 %",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.staatliches(
                        fontSize: 64, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 76,
            ),
            Text(
              "ESTADO DE PUERTAS",
              style: GoogleFonts.staatliches(fontSize: 48, color: Colors.black),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DoorButtonWidget(
                  width: width,
                  title: 'PUERTA 1',
                ),
                const SizedBox(width: 8),
                DoorButtonWidget(
                  width: width,
                  title: 'PUERTA 2',
                ),
              ],
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
