import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/models/blood_mark.dart';
import 'package:roc_app/models/log_symptom.dart';
import 'package:roc_app/models/symptom.dart';
import 'package:roc_app/widgets/body_template.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LogSymptomsGraphScreen extends StatefulWidget {
  final List<LogSymptom> loggedSymptom;

  const LogSymptomsGraphScreen({super.key, required this.loggedSymptom});
  @override
  _LogSymptomsGraphScreenState createState() => _LogSymptomsGraphScreenState();
}

class _LogSymptomsGraphScreenState extends State<LogSymptomsGraphScreen> {
  List<SymptomGraph> list = [];

  @override
  void initState() {
    super.initState();
    for (var l in widget.loggedSymptom) {
      if (l.symptom != null) {
        if (list.isEmpty) {
          list.add(
            SymptomGraph(
              name: l.symptom!.symptom,
              details: [
                GraphDetail(dateTime: l.dateTime, rate: l.symptom!.rate)
              ],
            ),
          );
        } else {
          final index = list.indexWhere((element) =>
              element.name.toLowerCase() == l.symptom!.symptom.toLowerCase());
          if (index >= 0) {
            list[index].details.add(
                  GraphDetail(dateTime: l.dateTime, rate: l.symptom!.rate),
                );
          } else {
            list.add(
              SymptomGraph(
                name: l.symptom!.symptom,
                details: [
                  GraphDetail(dateTime: l.dateTime, rate: l.symptom!.rate)
                ],
              ),
            );
          }
        }
      }
    }
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
                    for (var l in list)
                      SplineSeries<GraphDetail, String>(
                        splineType: SplineType.monotonic,
                        dataSource: l.details,
                        xValueMapper: (GraphDetail detail, _) =>
                            detail.dateTime.toString(),
                        yValueMapper: (GraphDetail detail, _) => detail.rate,
                        legendItemText: l.name,
                      ),
                    SplineSeries<LogSymptom, String>(
                      splineType: SplineType.monotonic,
                      dataSource: widget.loggedSymptom,
                      xValueMapper: (LogSymptom symptom, _) =>
                          symptom.dateTime.toString(),
                      yValueMapper: (LogSymptom symptom, _) =>
                          int.tryParse(symptom.pelvic) ?? 0,
                      legendItemText: "Pelvic",
                    ),
                    SplineSeries<LogSymptom, String>(
                      splineType: SplineType.monotonic,
                      dataSource: widget.loggedSymptom,
                      xValueMapper: (LogSymptom symptom, _) =>
                          symptom.dateTime.toString(),
                      yValueMapper: (LogSymptom symptom, _) =>
                          int.tryParse(symptom.indigestion) ?? 0,
                      legendItemText: "Indigestion",
                    ),
                    SplineSeries<LogSymptom, String>(
                      splineType: SplineType.monotonic,
                      dataSource: widget.loggedSymptom,
                      xValueMapper: (LogSymptom symptom, _) =>
                          symptom.dateTime.toString(),
                      yValueMapper: (LogSymptom symptom, _) =>
                          int.tryParse(symptom.nausea) ?? 0,
                      legendItemText: "Nausea",
                    ),
                    SplineSeries<LogSymptom, String>(
                      splineType: SplineType.monotonic,
                      dataSource: widget.loggedSymptom,
                      xValueMapper: (LogSymptom symptom, _) =>
                          symptom.dateTime.toString(),
                      yValueMapper: (LogSymptom symptom, _) =>
                          int.tryParse(symptom.bloating) ?? 0,
                      legendItemText: "Bloating",
                    ),
                    SplineSeries<LogSymptom, String>(
                      splineType: SplineType.monotonic,
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

class SymptomGraph {
  late List<GraphDetail> details;
  late String name;

  SymptomGraph({
    required this.details,
    required this.name,
  });
}

class GraphDetail {
  late String dateTime;
  late double rate;

  GraphDetail({
    required this.dateTime,
    required this.rate,
  });
}
