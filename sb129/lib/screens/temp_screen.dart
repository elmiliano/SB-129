import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class TempScreen extends StatelessWidget {
  const TempScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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
          ),
          Text(
            "detalles",
            style: GoogleFonts.raleway(fontSize: 16, color: Colors.black),
          ),
          Row(
            children: [
              Container(
                height: 99,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, //color of border
                    width: 1, //width of border
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
