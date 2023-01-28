import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/models/log_blood_mark.dart';
import 'package:roc_app/screens/graphs/log_symptoms_graph_screen.dart';
import 'package:roc_app/widgets/body_template.dart';
import 'package:roc_app/widgets/header_template.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BloodMarkGraphScreen extends StatefulWidget {
  final List<LogBloodMark> marks;

  const BloodMarkGraphScreen({super.key, required this.marks});
  @override
  _BloodMarkGraphScreenState createState() => _BloodMarkGraphScreenState();
}

class _BloodMarkGraphScreenState extends State<BloodMarkGraphScreen> {
  List<SymptomGraph> list = [];

  @override
  void initState() {
    super.initState();

    for (var l in widget.marks) {
      if (l.bloodMark != null) {
        if (list.isEmpty) {
          list.add(
            SymptomGraph(
              name: l.bloodMark!.name,
              details: [
                GraphDetail(
                    dateTime: l.dateTime, rate: l.bloodMark!.amountOfProtien)
              ],
            ),
          );
        } else {
          final index = list.indexWhere((element) =>
              element.name.toLowerCase() == l.bloodMark!.name.toLowerCase());
          if (index >= 0) {
            list[index].details.add(
                  GraphDetail(
                      dateTime: l.dateTime, rate: l.bloodMark!.amountOfProtien),
                );
          } else {
            list.add(
              SymptomGraph(
                name: l.bloodMark!.name,
                details: [
                  GraphDetail(
                      dateTime: l.dateTime, rate: l.bloodMark!.amountOfProtien)
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
              const HeaderTemplate(
                headerText: "Blood Mark",
              ),
              SizedBox(
                height: 24.h,
              ),
              SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                ),
                enableAxisAnimation: true,
                series: <ChartSeries>[
                  for (var l in list)
                    SplineSeries<GraphDetail, String>(
                      splineType: SplineType.monotonic,
                      dataSource: l.details,
                      xValueMapper: (GraphDetail detail, _) =>
                          detail.dateTime.toString(),
                      yValueMapper: (GraphDetail detail, _) => detail.rate,
                      legendItemText: l.name,
                    ),
                  SplineSeries<LogBloodMark, String>(
                    splineType: SplineType.monotonic,
                    dataSource: widget.marks,
                    xValueMapper: (LogBloodMark symptom, _) =>
                        symptom.dateTime.toString(),
                    yValueMapper: (LogBloodMark symptom, _) =>
                        int.tryParse(symptom.inhibinB) ?? 0,
                    legendItemText: "Inhibin B",
                  ),
                  SplineSeries<LogBloodMark, String>(
                    splineType: SplineType.monotonic,
                    dataSource: widget.marks,
                    xValueMapper: (LogBloodMark symptom, _) =>
                        symptom.dateTime.toString(),
                    yValueMapper: (LogBloodMark symptom, _) =>
                        int.tryParse(symptom.ca125) ?? 0,
                    legendItemText: "CA-125",
                  ),
                ],
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
