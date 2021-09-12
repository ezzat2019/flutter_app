import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/screen1.dart';
import 'package:flutter_app/screens/screen2.dart';
import 'package:flutter_app/screens/screen3.dart';
import 'package:flutter_app/screens/screen4.dart';
import 'package:flutter_app/test_new_screen.dart';
import 'package:flutter_app/tests/provider/test3_Provider.dart';
import 'package:flutter_app/tests/test3.dart';
import 'package:flutter_app/tests/test_screen2.dart';
import 'package:provider/provider.dart';
import 'package:sip_ua/sip_ua.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

const bool debugEnableDeviceSimulator = true;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Test3Provider>(create: (context) => Test3Provider(),)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
typedef PageContentBuilder = Widget Function(
    [SIPUAHelper helper, Object arguments]);

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PanelController con = PanelController();
  final double _initFabHeight = 120.0;
  double _fabHeight;
  double _panelHeightOpen;
  double _panelHeightClosed = 95.0;
  int _bottomNavIndex = -1;
  final iconList = <IconData>[
    Icons.brightness_5,
    Icons.brightness_4,
    Icons.brightness_6,
    Icons.brightness_7,
  ];
  List<Widget> screens = List();

  @override
  void initState() {
    screens.add(Screen1());
    screens.add(Screen2());
    screens.add(Home());
    screens.add(Screen3());
    screens.add(Screen4());

    _fabHeight = _initFabHeight;
  }

  Widget getCurrentScreen(int pos) {
    if (pos == -1) {
      // return screens[2];
      return TestScreen3();
    } else if (pos == 2) {
      return screens[3];
    } else if (pos == 3) {
      return screens[4];
    } else {
      return screens[pos];
    }
  }

  Color getCurrentColor(int pos) {
    if (pos == -1) {
      return Colors.white;
    } else if (pos == 0) {
      return Colors.red;
    } else if (pos == 1) {
      return Colors.green;
    } else if (pos == 2) {
      return Colors.blue;
    } else if (pos == 3) {
      return Colors.purple;
    }
  }

  bool isPasswordCompliant(String password, [int minLength = 8]) {
    if (password == null || password.length < minLength) {
      return false;
    }

    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    if (hasUppercase) {
      bool hasDigits = password.contains(RegExp(r'[0-9]'));
      if (hasDigits) {
        bool hasLowercase = password.contains(RegExp(r'[a-z]'));
        if (hasLowercase) {
          bool hasSpecialCharacters =
              password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
          return hasSpecialCharacters;
        }
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .80;

    return Scaffold(
      backgroundColor: getCurrentColor(_bottomNavIndex),

      body: Test3()

      // SlidingUpPanel(
      //   controller: con,
      //   maxHeight: 300,
      //   minHeight: 0,
      //   parallaxEnabled: true,
      //   parallaxOffset: .5,
      //   borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(50), topRight: Radius.circular(50)),
      //   panel: Center(
      //     child: Text("fgdgfdg"),
      //   ),
      //   body: Column(
      //     children: [
      //       Padding(
      //         padding:  EdgeInsets.only(top: 500),
      //         child: Center(
      //           child: ElevatedButton(
      //             child: Text("dsf"),
      //             onPressed: () async {
      //               con.open();
      //
      //               // await canLaunch("https://pub.dev/packages/url_launcher")
      //               //     ? await launch("https://pub.dev/packages/url_launcher")
      //               //     : throw 'Could not launch https://pub.dev/packages/url_launcher';
      //             },
      //           ),
      //         ),
      //       ),
      //
      //     ],
      //   ),
      //
      //
      //   // onPanelSlide: (double pos) => setState(() {
      //   //   _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
      //   //       _initFabHeight;
      //   // }),
      // ),

,

      // floatingActionButton: FloatingActionButton(
      //   elevation: 14,
      //
      //   onPressed: () async {
      //     print(isPasswordCompliant("Aa+123123"));
      //     setState(() {
      //       _bottomNavIndex = -1;
      //     });
      //   },
      //
      //   child: Icon(Icons.home,
      //       color: _bottomNavIndex == -1 ? Colors.black : Colors.white),
      //   backgroundColor: _bottomNavIndex == -1 ? Colors.amber : Colors.black,
      //
      //   //params
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: AnimatedBottomNavigationBar(
      //     backgroundColor: Colors.black,
      //     activeColor: Colors.amber,
      //     inactiveColor: Colors.white,
      //     icons: iconList,
      //     activeIndex: _bottomNavIndex,
      //     gapLocation: GapLocation.center,
      //     notchSmoothness: NotchSmoothness.sharpEdge,
      //     leftCornerRadius: 25,
      //     rightCornerRadius: 25,
      //     onTap: (index) {
      //       setState(() {
      //         _bottomNavIndex = index;
      //       });
      //     }
      //     //other params
      //     ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
