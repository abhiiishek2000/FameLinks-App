import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressChart extends StatefulWidget {
  @override
  _ProgressChartState createState() => _ProgressChartState();
}

class _ProgressChartState extends State<ProgressChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                      height: 90,
                      child: VerticalDivider(
                        thickness: 1,
                        color: Colors.white,
                      )),
                  Column(
                    children: [
                      Text(
                        'Bud',
                        style: GoogleFonts.nunitoSans(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          'Offers Rs.\n 10-50',
                          style:
                              TextStyle(fontSize: 10, color: Color(0xff0060FF)),
                        ),
                      )
                    ],
                  ),
                  Container(
                      height: 90,
                      child: VerticalDivider(
                        thickness: 1,
                        color: Colors.white,
                        width: 15,
                      )),
                  Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Rising',
                            style: GoogleFonts.nunitoSans(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w900),
                          ),
                          Container(
                            color: Color(0xffFF5C28),width: 30,height:1,),
                          SizedBox(height: 10),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          '20-100',
                          style: TextStyle(
                              fontSize: 10,
                              color: Color(0xff0060FF),
                              fontStyle: FontStyle.italic),
                        ),
                      )
                    ],
                  ),
                  Container(
                      height: 90,
                      child: VerticalDivider(
                        thickness: 1,
                        color: Colors.white,
                        width: 15,
                      )),
                  Column(
                    children: [
                      Text(
                        'Known',
                        style: GoogleFonts.nunitoSans(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          '50-500',
                          style: TextStyle(
                              fontSize: 10,
                              color: Color(0xff0060FF),
                              fontStyle: FontStyle.italic),
                        ),
                      )
                    ],
                  ),
                  Container(
                      height: 90,
                      child: VerticalDivider(
                        thickness: 1,
                        color: Colors.white,
                        width: 15,
                      )),
                  Column(
                    children: [
                      Text(
                        'Celebrity',
                        style: GoogleFonts.nunitoSans(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          '500-1K',
                          style: TextStyle(
                              fontSize: 10,
                              color: Color(0xff0060FF),
                              fontStyle: FontStyle.italic),
                        ),
                      )
                    ],
                  ),
                  Container(
                      height: 90,
                      child: VerticalDivider(
                        thickness: 1,
                        color: Colors.white,
                        width: 15,
                      )),
                  Column(
                    children: [
                      Text(
                        'Star',
                        style: GoogleFonts.nunitoSans(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          '1K-10K',
                          style: TextStyle(
                              fontSize: 10,
                              color: Color(0xff0060FF),
                              fontStyle: FontStyle.italic),
                        ),
                      )
                    ],
                  ),
                  Container(
                      height: 90,
                      child: VerticalDivider(
                        thickness: 1,
                        color: Colors.white,
                      )),
                  Column(
                    children: [
                      Text(
                        'Super\n Star',
                        style: GoogleFonts.nunitoSans(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          '10K-100K',
                          style: TextStyle(
                              fontSize: 10,
                              color: Color(0xff0060FF),
                              fontStyle: FontStyle.italic),
                        ),
                      )
                    ],
                  ),
                  Container(
                      height: 90,
                      child: VerticalDivider(
                        thickness: 1,
                        color: Colors.white,
                      )),
                ],
              ),

              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6),
                        child: Divider(
                          color: Color(0xff7AACFF),
                          thickness: 1,
                          height: 0,
                          // indent: 3,
                          // endIndent: 10,
                        ),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded,color: Color(0xff7AACFF),size: 10,)
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: ScrollPhysics(),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Column(
                        children: [
                          Text(
                            '0',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 45,
                    ),
                    Text(
                      '5k',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 38,
                    ),
                    Text(
                      '50k',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    Text(
                      '200k',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 38,
                    ),
                    Text(
                      '1M',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      '5M',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      '5M+',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),

              // Icon(Icons.arrow_forward_ios,color: Colors.red,size: 10),
            ],
          ),
        ),
      ),
    );
  }
}
