import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
class TicketChart {
  String numX;
 int numY;
  charts.Color barColor;
  setNumY(int numY){
    this.numY=numY;
  }
  TicketChart({
   required this.numX,
   required this.numY,
   required this.barColor

});
}
class TicketCharts{
   List<TicketChart> data= [
    TicketChart(
      numX: "40",
      numY: 1200,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    TicketChart(
      numX: "35",
      numY: 1000,
      barColor: charts.ColorUtil.fromDartColor(Colors.orange),
    ),
    TicketChart(
      numX: "30",
      numY: 800,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    TicketChart(
      numX: "25",
      numY: 600,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    TicketChart(
      numX: "20",
      numY: 400,
      barColor: charts.ColorUtil.fromDartColor(Colors.grey),
    ),
    TicketChart(
      numX: "15",
      numY: 200,
      barColor: charts.ColorUtil.fromDartColor(Colors.pink),
    ),
  ];
}
//****************
class TicketChartWidget1 extends StatelessWidget {
   List<TicketChart> data;
  TicketChartWidget1({required this.data});
  @override
  Widget build(BuildContext context) {
    List<charts.Series<TicketChart, String>> series = [
      charts.Series(
          id: "Soon",
          data: data,
          domainFn: (TicketChart series, _) => series.numX,
          measureFn: (TicketChart series, _) => int.parse(series.numX),
          colorFn: (TicketChart series, _) => series.barColor
      )
    ];
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: charts.BarChart(
                series,
                animate: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
