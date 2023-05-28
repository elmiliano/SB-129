import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sb129/screens/navbar_screen.dart';
import 'package:sb129/screens/temp_screen.dart';
import 'package:sb129/services/services.dart';
import 'package:sb129/widgets/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();

}

class _GraphScreenState extends State<GraphScreen> {
  @override
  void initState() {
    super.initState();
    final histService = Provider.of<HistTempService>(context, listen: false);
    histService.loadProducts();
  }


  @override
  Widget build(BuildContext context) {
    
    HistTempService histService;

    double width = MediaQuery.of(context).size.width;
    //setState(() {});
    histService = Provider.of<HistTempService>(context);

    // void refresh() async {
    //   histService = Provider.of<HistTempService>(context).loadProducts();
    //   setState(() {});
    // }
    if (histService.isLoading) {
      return const Center(
          child: SizedBox(
              height: 150, width: 150, child: CircularProgressIndicator()));
    }
    print("En pantalla de grafica");
    print(histService.hist.temperatura);

    final List<ChartData> chartData = [];

    for (var i = 0; i < histService.hist.temperatura.length; i++) {
      chartData.add(ChartData(histService.hist.time[i].toDouble(),
        histService.hist.temperatura[i].toDouble()));
    }
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: TopScreenTitleWidget(
                  title: 'historial',
                ),
              ),
              // IconButton(onPressed: (){Navigator.pushNamed(
              //       context,
              //       'home');
              //     },
              //   icon: Icon(Icons.arrow_back)),
              // IconButton(onPressed:refresh,
              //   icon: Icon(Icons.refresh)),
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
                        minorGridLines: const MinorGridLines(
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
              const SizedBox(
                height: 15,
              ),
              Text(
                'DETALLES',
                style: GoogleFonts.raleway(
                    textStyle: const TextStyle(fontSize: 20),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              TablaDeTemps(
                  time: histService.hist.time,
                  temp: histService.hist.temperatura),
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
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final double x;
  final double y;
}

class TablaDeTemps extends StatefulWidget {
  const TablaDeTemps({super.key, required this.temp, required this.time});

  final List temp;
  final List time;

  @override
  State<TablaDeTemps> createState() => _TablaDeTempsState();
}

class _TablaDeTempsState extends State<TablaDeTemps> {
  List<Map> data = [];

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < widget.temp.length; i++) {
      data.add({'timePassed': widget.time[i], 'temp': widget.temp[i]});
    }

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
                  child: Text('${dato['temp']} C',
                      style: GoogleFonts.raleway(
                          textStyle: const TextStyle(fontSize: 15))))),
              DataCell(Center(
                  child: Text('Hace ${dato['timePassed']} segundos.',
                      style: GoogleFonts.raleway(
                          textStyle: const TextStyle(fontSize: 15))))),
            ]))
        .toList();
  }
}
