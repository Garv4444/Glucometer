import 'package:flutter/material.dart';
import 'dart:async';
import 'package:glucometer/constants.dart';
import 'dart:io' show Platform;
import 'package:location_permissions/location_permissions.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'result.dart';

class Helper extends StatefulWidget {
  static const String id='ble_connection.dart';
  const Helper({Key? key}) : super(key: key);

  @override
  _HelperState createState() => _HelperState();
}

class _HelperState extends State<Helper> {
  static bool _foundDeviceWaitingToConnect = false;
  static bool _scanStarted = false;
  static bool _connected = false;
  static late DiscoveredDevice _uniqueDevice;
  final flutterReactiveBle = FlutterReactiveBle();
  static late StreamSubscription<DiscoveredDevice> _scanStream;
  static late QualifiedCharacteristic _rxCharacteristic;
  final Uuid serviceUuid = Uuid.parse("451cef94-55ad-4c65-992f-9100afd1d68a");
  final Uuid characteristicUuid = Uuid.parse("18af039e-e091-417c-97d1-d427b159bdb5");
  void _startScan() async {
    bool permGranted = false;
    setState(() {
      _scanStarted = true;
    });
    PermissionStatus permission;
    if (Platform.isAndroid) {
      permission = await LocationPermissions().requestPermissions();
      if (permission == PermissionStatus.granted) permGranted = true;
    } else if (Platform.isIOS) {
      permGranted = true;
    }
    if (permGranted) {
      _scanStream = flutterReactiveBle
          .scanForDevices(withServices: [serviceUuid]).listen((device) {
        if (device.name == 'ESP32') {
          setState(() {
            _uniqueDevice = device;
            _foundDeviceWaitingToConnect = true;
          });
        }
      });
    }
  }
  void _connectToDevice() {
    _scanStream.cancel();
    Stream<ConnectionStateUpdate> _currentConnectionStream = flutterReactiveBle
        .connectToAdvertisingDevice(
        id: _uniqueDevice.id,
        prescanDuration: const Duration(seconds: 1),
        withServices: [serviceUuid, characteristicUuid]);
    _currentConnectionStream.listen((event) {
      switch (event.connectionState) {
        case DeviceConnectionState.connected:
          {
            _rxCharacteristic = QualifiedCharacteristic(
                serviceId: serviceUuid,
                characteristicId: characteristicUuid,
                deviceId: event.deviceId);
            setState(() {
              _foundDeviceWaitingToConnect = false;
              _connected = true;
            });
            break;
          }
        case DeviceConnectionState.disconnected:
          {
            break;
          }
        default:
      }
    });
  }
  Future<void> _ResultTime() async {
    if (_connected) {
      var result = await flutterReactiveBle.readCharacteristic(_rxCharacteristic);
      String temp="";
      for(int i in result){
        temp+=String.fromCharCode(i);
      }
      print(temp);
      Results.value = double.parse(temp);
      Navigator.pushNamed(context, Results.id);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connect to Bluetooth Device'),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            _scanStarted
            // True condition
                ? TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey, // background
                    foregroundColor: Colors.white, // foreground
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Text(
                        'SEARCH ',
                        style: kTitleStyle.copyWith(fontSize: 20),
                      ),
                      const Icon(Icons.search),
                    ],
                  ),
            )
            // False condition
                : TextButton(
                    onPressed: _startScan,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Text(
                          'SEARCH ',
                          style: kTitleStyle.copyWith(fontSize: 20),
                        ),
                        const Icon(Icons.search),
                      ],
                    ),
                  ),

              const SizedBox(
                height: 50,
              ),

            _foundDeviceWaitingToConnect
            // True condition
                ? TextButton(
                  onPressed: _connectToDevice,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Text(
                        'CONNECT ',
                        style: kTitleStyle.copyWith(fontSize: 20),
                      ),
                      const Icon(Icons.bluetooth),
                    ],
                  ),
                )
            // False condition
                : TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey, // background
                    foregroundColor: Colors.white, // foreground
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Text(
                        'CONNECT ',
                        style: kTitleStyle.copyWith(fontSize: 20),
                      ),
                      const Icon(Icons.bluetooth),
                    ],
                  ),
                ),

            const SizedBox(
              height: 50,
            ),
            _connected
            // True condition
                ? TextButton(
                onPressed: _ResultTime,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'GET RESULTS ',
                        style: kTitleStyle.copyWith(fontSize: 20),
                      ),
                      const Icon(Icons.check),
                    ],
                  ),
            )
            // False condition
                : TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey, // background
                    foregroundColor: Colors.white, // foreground
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'GET RESULTS ',
                        style: kTitleStyle.copyWith(fontSize: 20),
                      ),
                      const Icon(Icons.check),
                    ],
                  ),
              ),
          ],),
        ],
      )
    );
  }
}