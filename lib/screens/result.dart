import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:glucometer/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:draw_graph/draw_graph.dart';


class Storage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/list.txt');
  }
  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }
  Future<File> writeCounter(int counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$counter');
  }
}



class Results extends StatefulWidget {

  static void setCurrent(bool type) {
    _ResultsState.current =
        type ? _ResultsState.fastValues : _ResultsState.ppValues;
  }
  static bool type = false;
  static const String id = "result";
  static double value = 0;
  Results({Key? key}) : super(key: key);
  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {

  @override
  void initState() {
    super.initState();
    _loadCounter();
    _incrementCounter();
  }

  //Loading counter value on start
  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter1 = (prefs.getInt('counter1') ?? 100);
      _counter2 = (prefs.getInt('counter2') ?? 100);
      _counter3 = (prefs.getInt('counter3') ?? 100);
      _counter4 = (prefs.getInt('counter4') ?? 100);
      _counter5 = (prefs.getInt('counter5') ?? 100);
      _counter6 = (prefs.getInt('counter6') ?? 100);
      _counter7 = (prefs.getInt('counter7') ?? 100);
    });
  }

  //Incrementing counter after click
  Future<void> _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter1=_counter2;
      _counter2=_counter3;
      _counter3=_counter4;
      _counter4=_counter5;
      _counter5=_counter6;
      _counter6=_counter7;
      _counter7=value.round();
       avg=((_counter1+_counter2+_counter3+_counter4+_counter5+_counter6+_counter7)/7).round();
       prefs.setInt('counter1', _counter1);
       prefs.setInt('counter2', _counter2);
       prefs.setInt('counter3', _counter3);
       prefs.setInt('counter4', _counter4);
       prefs.setInt('counter5', _counter5);
       prefs.setInt('counter6', _counter6);
       prefs.setInt('counter7', _counter7);
    });
  }

  static int _counter1=100;
  static int _counter2=100;
  static int _counter3=100;
  static int _counter4=100;
  static int _counter5=100;
  static int _counter6=100;
  static int _counter7=100;
  static int avg=_counter1;

  double value = Results.value;
  static const List<double> fastValues = [100, 125, 200];
  static const List<double> ppValues = [140, 200, 300];
  static List<double> current = ppValues;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 100,),
            Text(
              'Results\n',
              textAlign: TextAlign.center,
              style: kTitleStyle.copyWith(fontSize: 40),
            ),
            Text(
              '${value.toStringAsFixed(0)} mg/dL\n',
              style: kTitleStyle.copyWith(fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Recent Average: $avg mg/dL\n',
                style: kTitleStyle.copyWith(fontSize: 20),
              ),
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
            LineGraph(
              size: Size(300, 200),
              labelX: ['D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7'],
              labelY: ['50', '100', '150', '200', '250'],
              showDescription: false,
              graphColor: Colors.white70,
              graphOpacity: 0.2,
              verticalFeatureDirection: true,
              descriptionHeight: 130,
              features: [Feature(
                color: Colors.blue,
                data: [_counter1/250,_counter2/250,_counter3/250,_counter4/250,_counter5/250,_counter6/250,_counter7/250],
              ),],
            ),
            const SizedBox(height: 100,)
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
