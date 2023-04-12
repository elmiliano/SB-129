import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphScreen extends StatelessWidget {

  final List<ChartData> chartData = [
            ChartData(10.5, 25),
            ChartData(11, 28),
            ChartData(11.5, 24),
            ChartData(12, 22),
            ChartData(12.5, 24),
            ChartData(13, 25),
            ChartData(13.5, 28),
            ChartData(14.5, 24),
            ChartData(15, 22),
            ChartData(15.5, 26)
        ];

  GraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    
    return Column(
      children: [
        SizedBox(height: 15,),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Color.fromRGBO(106, 213, 203, 1)
          ),
          //color: const Color.fromRGBO(106, 213, 203, 1),
          width: width-25,
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
                  fontWeight: FontWeight.w500
              ),
              minimum: 15
            ),
            primaryXAxis: NumericAxis(
              majorGridLines: const MajorGridLines(
                  width: 1,
                  color: Colors.white,
              ),
              minorGridLines: MinorGridLines(
                  width: 1,
                  color: Colors.green,
                  dashArray: <double>[5,5]
              ),
              labelStyle: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500
              ),
            ),
            margin: const EdgeInsets.all(25),
            series: <ChartSeries>[
                // Renders line chart
                LineSeries<ChartData, double>(
                  color: Colors.white,
                  markerSettings: const MarkerSettings(
                    isVisible: true
                  ),
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y
                )
            ]
          )
        ),
      ],
    );
  }
}

class ChartData {
    ChartData(this.x, this.y);
    final double x;
    final double y;
}
