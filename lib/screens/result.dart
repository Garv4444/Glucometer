import 'package:flutter/material.dart';
import 'package:glucometer/constants.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Results extends StatefulWidget {
  static const String id = "result";
  static double value = 0;
  const Results({Key? key}) : super(key: key);

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  double value = Results.value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Results\n',
              textAlign: TextAlign.center,
              style: kTitleStyle.copyWith(fontSize: 50),
            ),
            Text(
              '$value mg/dL\n',
              style: kTitleStyle.copyWith(fontSize: 40),
            ),
            Text(
              '${message(value)}\n',
              style: kTitleStyle.copyWith(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SfLinearGauge(
                labelPosition: LinearLabelPosition.outside,
                tickPosition: LinearElementPosition.outside,
                onGenerateLabels: () {
                  return <LinearAxisLabel>[
                    const LinearAxisLabel(text: '0', value: 0),
                    const LinearAxisLabel(text: '140', value: 140),
                    const LinearAxisLabel(text: '200', value: 200),
                    const LinearAxisLabel(text: '300', value: 300),
                  ];
                },
                markerPointers: <LinearMarkerPointer>[
                  LinearShapePointer(
                    value: value,
                    color: const Color(0xff0658d6),
                    width: 24,
                    position: LinearElementPosition.inside,
                    shapeType: LinearShapePointerType.triangle,
                    height: 16,
                  ),
                ],
                minimum: 0,
                maximum: 300,
                useRangeColorForAxis: true,
                ranges: const [
                  LinearGaugeRange(
                    rangeShapeType: LinearRangeShapeType.curve,
                    position: LinearElementPosition.cross,
                    edgeStyle: LinearEdgeStyle.startCurve,
                    startWidth: 16,
                    midWidth: 16,
                    endWidth: 16,
                    startValue: 0,
                    endValue: 140,
                    color: Colors.green,
                  ),
                  LinearGaugeRange(
                    position: LinearElementPosition.cross,
                    rangeShapeType: LinearRangeShapeType.curve,
                    startWidth: 16,
                    midWidth: 16,
                    endWidth: 16,
                    startValue: 140,
                    endValue: 200,
                    color: Colors.yellow,
                  ),
                  LinearGaugeRange(
                    edgeStyle: LinearEdgeStyle.endCurve,
                    position: LinearElementPosition.cross,
                    rangeShapeType: LinearRangeShapeType.curve,
                    startWidth: 16,
                    midWidth: 16,
                    endWidth: 16,
                    startValue: 200,
                    endValue: 300,
                    color: Colors.red,
                  )
                ],
                majorTickStyle: const LinearTickStyle(length: 0),
                minorTickStyle: const LinearTickStyle(length: 0),
                animateRange: true,
                animateAxis: true,
                axisTrackStyle: const LinearAxisTrackStyle(
                  color: Colors.transparent,
                  edgeStyle: LinearEdgeStyle.bothFlat,
                  thickness: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String message(double value) {
  if (value <= 140) {
    return "Your blood sugar is normal";
  } else if (value <= 200) {
    return "You are Pre-Diabetic";
  } else {
    return "You are Diabetic";
  }
}
