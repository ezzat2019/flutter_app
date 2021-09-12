import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class TestScreen1 extends StatefulWidget {
  TestScreen1({Key key}) : super(key: key);

  @override
  _TestScreen1State createState() {
    return _TestScreen1State();
  }
}

class _TestScreen1State extends State<TestScreen1> {
  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var color = Color(0xFF001860);
    FlutterStatusbarcolor.setStatusBarColor(color);

    // TODO: implement build
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(150)),
                    child: Container(
                      color: color,
                      height: 200,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        color: Colors.yellow,
                        margin: EdgeInsets.all(80),
                        width: constraints.maxWidth,
                        height: 200,
                      ),
                      Container(
                        color: Colors.yellow,
                        margin: EdgeInsets.all(80),
                        width: constraints.maxWidth,
                        height: 200,
                      ),

                    ],
                  )

                ],
              ),
            ],

          );
        },
      ),
    );
  }
}
