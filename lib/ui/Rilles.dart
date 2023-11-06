import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class RellesScreen extends StatefulWidget {
  const RellesScreen({Key? key}) : super(key: key);

  @override
  _RellesScreenState createState() => _RellesScreenState();
}

class _RellesScreenState extends State<RellesScreen> {
  int index = 0;
  bool check = true;
  bool icon_main = false;

  String main_icon_image = "assets/images/nav_icon.png";


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Stack(
              children: [
                Container(
                    height: double.infinity,
                    child: Image.network(
                      "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8eWVsbG93JTIwZ2lybHxlbnwwfHwwfHw%3D&w=1000&q=80",
                      fit: BoxFit.cover,
                    )),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      check = true;
                    });
                  },
                  child: Visibility(
                    visible: icon_main,
                    child: Container(
                        margin: EdgeInsets.only(top: 100),
                        height: 60,
                        width: 60,
                        child: Image.asset("$main_icon_image")),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {

              },
              child: Visibility(
                visible: check,
                child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Color.fromARGB(80, 0, 0, 0),
                    alignment: Alignment.topLeft,
                    child: Stack(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 80),
                            height: 100,
                            child:
                                Image.asset("assets/images/gradiant_ring.png")),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 40),
                              child: Container(
                                height: 180,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          main_icon_image =
                                          "assets/images/funlinkicon.png";
                                          check = false;
                                          icon_main = true;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                              height: 40,
                                              width: 40,
                                              child: Image.asset(
                                                  "assets/images/funlinkicon.png")),
                                          Text(
                                            "FramLinks",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          main_icon_image =
                                          "assets/images/nav_icon.png";
                                          check = false;
                                          icon_main = true;
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 40),
                                        child: Row(
                                          children: [
                                            Container(
                                                height: 35,
                                                width: 35,
                                                child: Image.asset(
                                                    "assets/images/nav_icon.png")),
                                            Text(
                                              "FramLinks",
                                              style:
                                                  TextStyle(color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          main_icon_image ="assets/images/funlinkicon.png";
                                          check = false;
                                          icon_main = true;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                              height: 35,
                                              width: 35,
                                              child: Image.asset(
                                                  "assets/images/funlinkicon.png")),
                                          Text(
                                            "FramLinks",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 42),
                                height: 180,
                                child: Image.asset(
                                    "assets/images/white_ring.png")),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
        floatingActionButton: SpeedDial(
          children: [
            SpeedDialChild(
              child: Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  child: Image.network(
                      "https://cdn-icons-png.flaticon.com/512/535/535183.png")),
              backgroundColor: Color.fromARGB(0, 255, 255, 0),
              elevation: 0,
              onLongPress: () => debugPrint('FIRST CHILD LONG PRESS'),
            ),
            SpeedDialChild(
              child: Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  child: Image.network(
                      "https://cdn-icons.flaticon.com/png/512/3114/premium/3114810.png?token=exp=1647886820~hmac=cc0fb5f7ff63eb8479060c5cfb29a839")),
              backgroundColor: Color.fromARGB(0, 255, 255, 0),
              elevation: 0,
              onTap: () => debugPrint('SECOND CHILD'),
            ),
            SpeedDialChild(
              child: const Icon(Icons.margin),
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              visible: true,
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(("Third Child Pressed")))),
              onLongPress: () => debugPrint('THIRD CHILD LONG PRESS'),
            ),
          ],
        ),
      ),
    );
  }
}
