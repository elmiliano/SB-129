import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sb129/widgets/widgets.dart';

import '../services/services.dart';

class HumidityScreen extends StatefulWidget {
  const HumidityScreen({super.key});

  @override
  State<HumidityScreen> createState() => _HumidityScreenState();
}

class _HumidityScreenState extends State<HumidityScreen> {
  @override
  void initState() {
    super.initState();
    final humService = Provider.of<HumService>(context, listen: false);
    humService.loadProducts();
    final doorService = Provider.of<DoorService>(context, listen: false);
    doorService.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final humService = Provider.of<HumService>(context);
    DoorService doorService;
    doorService = Provider.of<DoorService>(context);

    if (humService.isLoadingHum) {
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
              title: 'humedad',
            ),
            Container(
              height: 262,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(106, 213, 203, 40)),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.water_outlined,
                    color: Colors.white,
                    size: 150,
                  ),
                  Text(
                    "${humService.humedad}%",
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
