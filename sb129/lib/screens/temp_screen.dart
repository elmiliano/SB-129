import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:sb129/widgets/widgets.dart';



class TempScreen extends StatelessWidget {
  const TempScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const TopScreenTitleWidget(title: 'temperatura',),
            Container(
              height: 262,
              width: double.infinity,
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(73, 109, 219, 100)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.thermostat_outlined,
                    color: Colors.red,
                    size: 95,
                  ),
                  Text(
                    "15.82°C",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.staatliches(
                        fontSize: 48, color: Colors.white),
                  ),
                  Text(
                    "Temperatura Ambiente\n16.2°C/24.16°C",
                    textAlign: TextAlign.center,
                    style:
                        GoogleFonts.raleway(fontSize: 13, color: Colors.white),
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
            Container(
              child: Row(
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
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class DoorButtonWidget extends StatefulWidget {
  const DoorButtonWidget({
    super.key,
    required this.width,
    required this.title,
  });

  final double width;
  final String title;

  @override
  State<DoorButtonWidget> createState() => _DoorButtonWidgetState();
}

class _DoorButtonWidgetState extends State<DoorButtonWidget> {
  bool colorState = true;

  void changeButton() {
    colorState == true ? colorState = false : colorState = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),

          onPressed: changeButton,
          child: Container(
            height: 91,
            width: widget.width / 3,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black, //color of border
                width: 1, //width of border
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: colorState == true ? const Color.fromRGBO(106, 213, 203, 100)
              : const Color.fromRGBO(201, 93, 99, 100),
            ),
            child: colorState == true ? const Icon(Icons.lock)
              : const Icon(Icons.lock_open),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          widget.title,
          textAlign: TextAlign.center,
          style: GoogleFonts.raleway(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }
}



