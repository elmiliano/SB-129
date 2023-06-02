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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 55,
              width: 33,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  color: Color.fromRGBO(228, 228, 228, 100)),
            ),
            Expanded(
              child: Container(
                height: 55,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(228, 228, 228, 100)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "ESTADO DE PUERTAS",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.staatliches(
                        fontSize: 32,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            Container(
              height: 55,
              width: 33,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: Color.fromRGBO(228, 228, 228, 100)),
            ),
          ],
        ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
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
              ),
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
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: widget.colorState == true
                ?  Colors.green[400]
                :  Colors.red[300],
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
