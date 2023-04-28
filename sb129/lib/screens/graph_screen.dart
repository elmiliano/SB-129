import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sb129/models/historial_model.dart';
import 'package:sb129/services/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';

class GraphScreen extends StatelessWidget {
  

  GraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    final histService = Provider.of<HistTempService>(context);
    if( histService.isLoading) return const Center(child: SizedBox(height: 150,width: 150 ,child: CircularProgressIndicator()));
    print(histService.hist.temperatura);

    final List<ChartData> chartData = [];

    for (var i = 0; i < histService.hist.temperatura.length; i++){

      chartData.add(ChartData(histService.hist.time[i].toDouble(), histService.hist.temperatura[i].toDouble()));
    }

    /* final List<ChartData> chartData = [
      ChartData(10.5, histService.hist.temperatura[0].toDouble()),
      ChartData(11, 28),
      ChartData(11.5, 24),
      ChartData(12, 22),
      ChartData(12.5, 24),
      ChartData(13, 25),
      ChartData(13.5, 28),
      ChartData(14.5, 24),
      ChartData(15, 22),
      ChartData(15.5, 26)
    ]; */

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color.fromRGBO(106, 213, 203, 1)),
              //color: const Color.fromRGBO(106, 213, 203, 1),
              width: width - 25,
              height: 350,
              child: SfCartesianChart(
                  enableAxisAnimation: true,
                  //plotAreaBackgroundColor: const Color.fromRGBO(106, 213, 203, 1),
                  primaryYAxis: NumericAxis(
                      majorGridLines: const MajorGridLines(
                        width: 1,
                        color: Colors.white,
                      ),
                      labelStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500),
                      minimum: 15),
                  primaryXAxis: NumericAxis(
                    majorGridLines: const MajorGridLines(
                      width: 1,
                      color: Colors.white,
                    ),
                    minorGridLines: MinorGridLines(
                        width: 1,
                        color: Colors.green,
                        dashArray: <double>[5, 5]),
                    labelStyle: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500),
                  ),
                  margin: const EdgeInsets.all(25),
                  series: <ChartSeries>[
                    // Renders line chart
                    LineSeries<ChartData, double>(
                        color: Colors.white,
                        markerSettings: const MarkerSettings(isVisible: true),
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y)
                  ])),
          SizedBox(
            height: 15,
          ),
          Text(
            'DETALLES',
            style: GoogleFonts.raleway(
                textStyle: const TextStyle(fontSize: 20),
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          TablaDeTemps(time:histService.hist.time, temp:histService.hist.temperatura )
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final double x;
  final double y;
}

class TablaDeTemps extends StatelessWidget {
  

  TablaDeTemps({required this.temp,required this.time});

  final List temp;
  final List time;

  List<Map> data = [];
  @override
  Widget build(BuildContext context) {

    for (var i = 0; i < temp.length; i++){
      data.add({'timePassed':time[i], 'temp': temp[i]});
    }

    print(data);

    return DataTable(columns: <DataColumn>[
      DataColumn(
        label: Expanded(
          child: Center(
            child: Text(
              'Grados',
              style:
                  GoogleFonts.raleway(textStyle: const TextStyle(fontSize: 18)),
            ),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Center(
            child: Text(
              'Tiempo',
              style:
                  GoogleFonts.raleway(textStyle: const TextStyle(fontSize: 18)),
            ),
          ),
        ),
      ),
    ], rows: _createRows());
  }

  List<DataRow> _createRows() {
    return data
        .map((dato) => DataRow(cells: [
              DataCell(Center(
                  child: Text(dato['temp'].toString() + ' C',
                      style: GoogleFonts.raleway(
                          textStyle: const TextStyle(fontSize: 15))))),
              DataCell(Center(
                  child: Text(
                      'Hace ' + dato['timePassed'].toString() + ' segundos.',
                      style: GoogleFonts.raleway(
                          textStyle: const TextStyle(fontSize: 15))))),
            ]))
        .toList();
  }
}
