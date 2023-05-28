import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class DoorWidget extends StatelessWidget {
  const DoorWidget({
    super.key,
    required this.width,
    required this.title1,
    required this.title2,
    required this.state,
  });
  final double width;
  final String title1;
  final String title2;
  final bool state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
              "ESTADO DE PUERTAS",
              style: GoogleFonts.staatliches(fontSize: 48, color: Colors.black),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DoorButtonWidget(
                  width: width,
                  title: title1,
                  colorState: state,
                ),
                const SizedBox(width: 8),
                DoorButtonWidget(
                  width: width,
                  title: title2,
                  colorState: state,
                ),
              ],
            )
      ],
    );
  }
}

class DoorButtonWidget extends StatefulWidget {
  DoorButtonWidget({
    super.key,
    required this.width,
    required this.title, 
    required this.colorState,
  });

  final double width;
  final String title;
  bool colorState;

  @override
  State<DoorButtonWidget> createState() => _DoorButtonWidgetState();
}

class _DoorButtonWidgetState extends State<DoorButtonWidget> {
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 91,
          width: widget.width / 3,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black, //color of border
              width: 1, //width of border
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: widget.colorState == true
                ? const Color.fromRGBO(106, 213, 203, 100)
                : const Color.fromRGBO(201, 93, 99, 100),
          ),
          child: widget.colorState == true
              ? const Icon(Icons.lock)
              : const Icon(Icons.lock_open),
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
