import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sb129/widgets/widgets.dart';

import '../services/services.dart';

class TempScreen extends StatefulWidget {
  const TempScreen({super.key});

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  @override
  void initState() {
    super.initState();
    final histService = Provider.of<HistTempService>(context, listen: false);
    histService.loadProducts();
    final doorService = Provider.of<DoorService>(context, listen: false);
    doorService.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    HistTempService histService;
    histService = Provider.of<HistTempService>(context);
    DoorService doorService;
    doorService = Provider.of<DoorService>(context);

    if (histService.isLoading) {
      return const Center(
          child: SizedBox(
              height: 150, width: 150, child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const TopScreenTitleWidget(
              title: 'temperatura',
            ),
            Padding(
              padding: const EdgeInsets.only( left: 10, right: 10, top: 10),
              child: Container(
                height: 262,
                width: double.infinity,
                decoration:
                    BoxDecoration(color: 
                      (histService.hist.temperatura.last < 25) ? const Color.fromRGBO(73, 109, 219, 50)
                      : (histService.hist.temperatura.last > 35) ? const Color.fromRGBO(201, 93, 99, 50)
                      : const Color.fromRGBO(106, 213, 203, 60),

                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      
                    ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.thermostat_outlined,
                      color: Colors.red,
                      size: 95,
                    ),
                    Text(
                      "${histService.hist.temperatura.last}°C",
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
            const SizedBox(
              height: 60,
            ),
            doorService.isLoadingdoor? 
            const Center(
              child: SizedBox(
                height: 150, width: 150, child: CircularProgressIndicator()))
            :DoorWidget(width: width, title1: "Puerta 1", title2: "Puerta 2", state: doorService.door,)
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}


