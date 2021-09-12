import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_esc_printer/flutter_esc_printer.dart';

class TestScreen3 extends StatefulWidget {
  TestScreen3({Key key}) : super(key: key);

  @override
  _TestScreen3State createState() {
    return _TestScreen3State();
  }
}

class _TestScreen3State extends State<TestScreen3> {
  var drawerKey = GlobalKey<SwipeDrawerState>();

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
    // TODO: implement build
    return Scaffold(
      // add this line so you can add your appBar in Body
      extendBodyBehindAppBar: true,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SwipeDrawer(
          radius: 20,
          key: drawerKey,
          bodyBackgroundPeekSize: 30,
          backgroundColor: Colors.red,
          // pass drawer widget
          drawer: buildDrawer(),
          // pass body widget
          child: Column(
            children: [
              // build your appBar
              AppBar(
                title: Text('AppBar title'),
                leading: InkWell(
                    onTap: () {
                      if (drawerKey.currentState.isOpened()) {
                        drawerKey.currentState.closeDrawer();
                      } else {
                        drawerKey.currentState.openDrawer();
                      }
                    },
                    child: Icon(Icons.menu)),
              ),
              // build your screen body
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      testPrint();
                    },
                    child: Center(
                      child: Text('Home Screen'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDrawer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('Title'),
          ),
          ListTile(
            title: Text('Title'),
          ),
          ListTile(
            title: Text('Title'),
          ),
        ],
      ),
    );
  }

  Future<Ticket> testTicket(PaperSize paper) async {
    final Ticket ticket = Ticket(paper);

    ticket.text(
        'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    ticket.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
        styles: PosStyles(codeTable: PosCodeTable.westEur));
    ticket.text('Special 2: blåbærgrød',
        styles: PosStyles(codeTable: PosCodeTable.westEur));

    ticket.text('Bold text', styles: PosStyles(bold: true));
    ticket.text('Reverse text', styles: PosStyles(reverse: true));
    ticket.text('Underlined text',
        styles: PosStyles(underline: true), linesAfter: 1);
    ticket.text('Align left', styles: PosStyles(align: PosAlign.left));
    ticket.text('Align center', styles: PosStyles(align: PosAlign.center));
    ticket.text('Align right',
        styles: PosStyles(align: PosAlign.right), linesAfter: 1);

    ticket.feed(2);

    ticket.cut();
    return ticket;
  }

  testPrint() async {
    const PaperSize paper = PaperSize.mm80;
    String address = "DC:0D:30:8A:B7:56"; // 192.168.10.10
    if (address.isIpAddress) {
      //print vai ip address

      PrinterNetworkManager _printerNetworkManager = PrinterNetworkManager();
      _printerNetworkManager.selectPrinter(address);
      final res =
          await _printerNetworkManager.printTicket(await testTicket(paper));

      print(res.msg);
    } else if (address.isMacAddress) {
      //print vai mac address
      PrinterBluetoothManager _printerBluetoothManager =
          PrinterBluetoothManager();
      _printerBluetoothManager.selectPrinter(address);
      final res =
          await _printerBluetoothManager.printTicket(await testTicket(paper));

      print(res.msg);
    } else {
      //print("Error :e");
    }
  }

  Widget buildBody() {
    return Column(
      children: [
        // build your appBar
        AppBar(
          title: Text('AppBar title'),
          leading: InkWell(
              onTap: () {
                if (drawerKey.currentState.isOpened()) {
                  drawerKey.currentState.closeDrawer();
                } else {
                  drawerKey.currentState.openDrawer();
                }
              },
              child: Icon(Icons.menu)),
        ),
        // build your screen body
        Expanded(
          child: Container(
            color: Colors.white,
            child: InkWell(
              onTap: () {},
              child: Center(
                child: Text('Home Screen'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
