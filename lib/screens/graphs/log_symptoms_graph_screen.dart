import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/models/blood_mark.dart';
import 'package:roc_app/models/log_symptom.dart';
import 'package:roc_app/widgets/body_template.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LogSymptomsGraphScreen extends StatefulWidget {
  final List<LogSymptom> loggedSymptom;

  const LogSymptomsGraphScreen({super.key, required this.loggedSymptom});
  @override
  _LogSymptomsGraphScreenState createState() => _LogSymptomsGraphScreenState();
}

class _LogSymptomsGraphScreenState extends State<LogSymptomsGraphScreen> {
  @override
  void initState() {
    super.initState();
    // final sortedList = widget.marks
    //   ..sort((a, b) => a.amountOfProtien.compareTo(b.amountOfProtien));
    // final val = sortedList.last.amountOfProtien / 6;
    // list = List.generate(7, (index) => (index * val.toDouble()).toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BodyTemplate(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 64.0),
                child: Text(
                  "Logged Symptoms",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
              SizedBox(
                height: .5.sh,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  legend: Legend(
                      isVisible: true,
                      position: LegendPosition.bottom,
                      alignment: ChartAlignment.near,
                      isResponsive: false,
                      orientation: LegendItemOrientation.vertical,
                      height: '100%'),
                  enableAxisAnimation: true,
                  series: <ChartSeries>[
                    // Renders line chart
                    LineSeries<LogSymptom, String>(
                      dataSource: widget.loggedSymptom,
                      xValueMapper: (LogSymptom symptom, _) =>
                          symptom.dateTime.toString(),
                      yValueMapper: (LogSymptom symptom, _) =>
                          symptom.symptom.rate,
                      legendItemText: "Rate",
                    ),
                    LineSeries<LogSymptom, String>(
                      dataSource: widget.loggedSymptom,
                      xValueMapper: (LogSymptom symptom, _) =>
                          symptom.dateTime.toString(),
                      yValueMapper: (LogSymptom symptom, _) =>
                          int.tryParse(symptom.pelvic) ?? 0,
                      legendItemText: "Pelvic",
                    ),
                    LineSeries<LogSymptom, String>(
                      dataSource: widget.loggedSymptom,
                      xValueMapper: (LogSymptom symptom, _) =>
                          symptom.dateTime.toString(),
                      yValueMapper: (LogSymptom symptom, _) =>
                          int.tryParse(symptom.indigestion) ?? 0,
                      legendItemText: "Indigestion",
                    ),
                    LineSeries<LogSymptom, String>(
                      dataSource: widget.loggedSymptom,
                      xValueMapper: (LogSymptom symptom, _) =>
                          symptom.dateTime.toString(),
                      yValueMapper: (LogSymptom symptom, _) =>
                          int.tryParse(symptom.nausea) ?? 0,
                      legendItemText: "Nausea",
                    ),
                    LineSeries<LogSymptom, String>(
                      dataSource: widget.loggedSymptom,
                      xValueMapper: (LogSymptom symptom, _) =>
                          symptom.dateTime.toString(),
                      yValueMapper: (LogSymptom symptom, _) =>
                          int.tryParse(symptom.bloating) ?? 0,
                      legendItemText: "Bloating",
                    ),
                    LineSeries<LogSymptom, String>(
                      dataSource: widget.loggedSymptom,
                      xValueMapper: (LogSymptom symptom, _) =>
                          symptom.dateTime.toString(),
                      yValueMapper: (LogSymptom symptom, _) =>
                          int.tryParse(symptom.weightLoss) ?? 0,
                      legendItemText: "WeightLoss",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
