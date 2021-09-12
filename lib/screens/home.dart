import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Home extends StatefulWidget {

  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool toggle=false;
  var scController=ScrollController();
  Future<String> getPublicIP() async {
    try {

      var response = await http.get('https://api.ipify.org');
      if (response.statusCode == 200) {
        // The response body is the IP in plain text, so just
        // return it as-is.
        return response.body;
      } else {
        // The request failed with a non-200 code
        // The ipify.org API has a lot of guaranteed uptime
        // promises, so this shouldn't ever actually happen.
        print(response.statusCode);
        print(response.body);
        return null;
      }
    } catch (e) {
      // Request failed due to an error, most likely because
      // the phone isn't connected to the internet.
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: LayoutBuilder(

        builder: (context, constraints) {
          return ListView(
            controller: scController,
            children: [
              Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                color: Colors.white,
                child: Center(
                  child: ElevatedButton(
                    child: Text("move"),
                    onPressed: () {
                      setState(() {
                        getPublicIP().then((value) {
                          print(value);
                        });

                            toggle=!toggle;
                            if(toggle)
                              {
                                scController.animateTo(constraints.maxHeight, duration: Duration(
                                    milliseconds: 700
                                ), curve: Curves.linear);

                              }



                      });


                    },
                  ),
                ),
              ),
              if(toggle)
                Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                color: Colors.black,
                  child: Center(
                    child: ElevatedButton(
                      child: Text("back"),
                      onPressed: () {
                        setState(() {



                            scController.animateTo(0.0, duration: Duration(
                                 milliseconds: 700
                            ), curve: Curves.linear)
                            .then((value) {
                              toggle=!toggle;
                            });




                        });


                      },
                    ),
                  ),
              )
            ],

          );

        },

      ),
    );
  }
}
