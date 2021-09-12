import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
class TestNewScreen extends StatefulWidget {

  TestNewScreen({Key key}) : super(key: key);

  @override
  _TestNewScreenState createState() => _TestNewScreenState();
}

class _TestNewScreenState extends State<TestNewScreen> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
height: 60,
backgroundColor: Colors.white,
        color: Colors.green,
        buttonBackgroundColor: Colors.yellow,
        key: _bottomNavigationKey,
        items: <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.compare_arrows, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: Container(

        child: Center(
          child: Column(
            children: <Widget>[
              Text(_page.toString(), textScaleFactor: 10.0),
              RaisedButton(
                child: Text('Go To Page of index 1'),
                onPressed: () {
                  //Page change using state does the same as clicking index 1 navigation button
                  final CurvedNavigationBarState navBarState =
                      _bottomNavigationKey.currentState;
                  navBarState.setPage(1);
                },
              )
            ],
          ),
        ),
      )
    );
  }
}