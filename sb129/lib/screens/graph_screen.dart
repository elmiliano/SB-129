import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    final doorService = Provider.of<DoorService>(context, listen: false);
    doorService.loadProducts();
  }


  @override
  Widget build(BuildContext context) {
    HistTempService histService;
    DoorService doorService;
    double width = MediaQuery.of(context).size.width;
    histService = Provider.of<HistTempService>(context);
    doorService = Provider.of<DoorService>(context);

    if (histService.isLoading) {
      return const Center(
          child: SizedBox(
              height: 150, width: 150, child: CircularProgressIndicator()));
    }

    final List<ChartData> chartData = [];

    for (var i = 0; i < histService.hist.temperatura.length; i++) {
      chartData.add(ChartData(histService.hist.time[i].toString(),
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
              const SizedBox( height: 10 ),
              Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color.fromRGBO(106, 213, 203, 1)),
                  width: width - 25,
                  height: 350,
                  child: SfCartesianChart(
                      enableAxisAnimation: true,
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
                      primaryXAxis: CategoryAxis(
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
                        LineSeries<ChartData, String>(
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
                height: 35,
              ),
              doorService.isLoadingdoor? 
              const Center(
              child: SizedBox(
                height: 150, width: 150, child: CircularProgressIndicator()))
              :DoorWidget(width: width, title1: "Puerta 1", title2: "Puerta 2", state: doorService.door,),
              const SizedBox(
                height: 35,
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
  final String x;
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

    return Container(
      constraints: const BoxConstraints(maxHeight: 250),
      child: SingleChildScrollView(
        child: DataTable(columns: <DataColumn>[
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
        ], rows: _createRows()),
      ),
    );
  }

  List<DataRow> _createRows() {
    return data
        .map((dato) => DataRow(cells: [
              DataCell(Center(
                  child: Text('${dato['temp']} C',
                      style: GoogleFonts.raleway(
                          textStyle: const TextStyle(fontSize: 15))))),
              DataCell(Center(
                  child: Text('${dato['timePassed']} hrs',
                      style: GoogleFonts.raleway(
                          textStyle: const TextStyle(fontSize: 15))))),
            ]))
        .toList();
  }
}
