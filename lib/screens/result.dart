import 'package:flutter/material.dart';
import 'package:glucometer/constants.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Results extends StatefulWidget {
  static void setCurrent(bool type) {
    _ResultsState.current =
        type ? _ResultsState.fastValues : _ResultsState.ppValues;
  }

  static bool type = false;
  static const String id = "result";
  static double value = 0;
  const Results({Key? key}) : super(key: key);
  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  double value = Results.value;
  static const List<double> fastValues = [100, 125, 200];
  static const List<double> ppValues = [140, 200, 300];
  static List<double> current = ppValues;
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
              '${value.toStringAsFixed(0)} mg/dL\n',
              style: kTitleStyle.copyWith(fontSize: 40),
            ),
            Text(
              '${message(value, current)}\n',
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
                    LinearAxisLabel(
                        text: current[0].toStringAsFixed(0), value: current[0]),
                    LinearAxisLabel(
                        text: current[1].toStringAsFixed(0), value: current[1]),
                    LinearAxisLabel(
                        text: current[2].toStringAsFixed(0), value: current[2]),
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
                maximum: current[2],
                useRangeColorForAxis: true,
                ranges: [
                  LinearGaugeRange(
                    rangeShapeType: LinearRangeShapeType.curve,
                    position: LinearElementPosition.cross,
                    edgeStyle: LinearEdgeStyle.startCurve,
                    startWidth: 16,
                    midWidth: 16,
                    endWidth: 16,
                    startValue: 0,
                    endValue: current[0],
                    color: Colors.green,
                  ),
                  LinearGaugeRange(
                    position: LinearElementPosition.cross,
                    rangeShapeType: LinearRangeShapeType.curve,
                    startWidth: 16,
                    midWidth: 16,
                    endWidth: 16,
                    startValue: current[0],
                    endValue: current[1],
                    color: Colors.yellow,
                  ),
                  LinearGaugeRange(
                    edgeStyle: LinearEdgeStyle.endCurve,
                    position: LinearElementPosition.cross,
                    rangeShapeType: LinearRangeShapeType.curve,
                    startWidth: 16,
                    midWidth: 16,
                    endWidth: 16,
                    startValue: current[1],
                    endValue: current[2],
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

String message(double value, List<double> current) {
  if (value <= current[0]) {
    return "Your blood sugar is normal";
  } else if (value <= current[1]) {
    return "You are Pre-Diabetic";
  } else {
    return "You are Diabetic";
  }
}
