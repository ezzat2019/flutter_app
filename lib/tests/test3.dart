import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/tests/provider/test3_Provider.dart';
import 'package:flutter_sunmi_printer/flutter_sunmi_printer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shimmer/shimmer.dart';

class Test3 extends StatefulWidget {
  Test3({Key key}) : super(key: key);

  @override
  _Test3State createState() => _Test3State();
}

class _Test3State extends State<Test3> {


  Test3Provider tLive;
  int x = 0;
  static const String _kLocationServicesDisabledMessage =
      'Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';
  GlobalKey globalKey = new GlobalKey();
  String _dataString = "Hello from this QR";
  bool show = true;
  GlobalKey<EditableTextState> k2=GlobalKey<EditableTextState>();

  StreamSubscription<Position> _positionStreamSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    tLive = Provider.of(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    print("Hi");

    return Scaffold(
      appBar: AppBar(
        title: Selector<Test3Provider, int>(
          selector: (_, tt) => tt.count,
          builder: (context, value, child) {
            return Text(value.toString());
          },
        ),
        flexibleSpace: Center(
          child: Transform.scale(
            scale: 0,
            child: RepaintBoundary(
              key: globalKey,
              child: QrImage(
                  data: 'This is a simple QR code',
                  version: QrVersions.auto,
                  size: 100,
                  gapless: false,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black),
            ),
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white,
            child:  Card(
              child: Container(  width: 90,
                height: 120),
            ),
          ),
            ),),

      floatingActionButton: Consumer<Test3Provider>(
        builder: (context, value, child) {
          return FloatingActionButton(
            onPressed: () async {
           //   await captureAndSharePng();
             print( k2.currentState.currentTextEditingValue.text);
            },
          );
        },
      ),
    );
  }

  Future<void> captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage(pixelRatio: 2);

      ByteData bytes = await image.toByteData(format: ImageByteFormat.png);
      final buffer = bytes.buffer;

      final imgData = base64.encode(Uint8List.view(buffer));
      print(imgData);
      SunmiPrinter.emptyLines(1);
      SunmiPrinter.image(imgData);
      SunmiPrinter.emptyLines(2);
    } catch (e) {
      print(e.toString());
    }
  }
}
