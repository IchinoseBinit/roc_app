import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roc_app/models/blood_mark.dart';
import 'package:roc_app/widgets/body_template.dart';
import 'package:roc_app/widgets/header_template.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class BloodMarkGraphScreen extends StatefulWidget {
  final List<BloodMark> marks;

  const BloodMarkGraphScreen({super.key, required this.marks});
  @override
  _BloodMarkGraphScreenState createState() => _BloodMarkGraphScreenState();
}

class _BloodMarkGraphScreenState extends State<BloodMarkGraphScreen> {
  late final List<Feature> features = [];
  late final List<int> list;

  @override
  void initState() {
    super.initState();
    features.add(
      Feature(
          color: Colors.red,
          data: [
            0,
            ...widget.marks.map((e) => e.amountOfProtien.toDouble()).toList()
          ],
          title: "Protien"),
    );
    features.add(
      Feature(
          color: Colors.green,
          data: [
            0,
            ...widget.marks.map((e) => e.referenceRange.toDouble()).toList()
          ],
          title: "Range"),
    );
    final sortedList = widget.marks
      ..sort((a, b) => a.amountOfProtien.compareTo(b.amountOfProtien));
    final val = sortedList.last.amountOfProtien / 6;
    list = List.generate(7, (index) => (index * val.toDouble()).toInt());
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
                  // Renders line chart
                  LineSeries<BloodMark, String>(
                    dataSource: widget.marks,
                    xValueMapper: (BloodMark mark, _) => mark.date.toString(),
                    yValueMapper: (BloodMark mark, _) => mark.amountOfProtien,
                    legendItemText: "Amount of Protien",
                  ),
                  LineSeries<BloodMark, String>(
                    dataSource: widget.marks,
                    xValueMapper: (BloodMark mark, _) => mark.date.toString(),
                    yValueMapper: (BloodMark mark, _) => mark.referenceRange,
                    legendItemText: "Reference Range",
                  )
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
