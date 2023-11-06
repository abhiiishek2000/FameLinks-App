import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../util/config/color.dart';
import '../Famelinkprofile/function/famelinkFun.dart';

class AgencyRecommendation extends StatefulWidget {
  @override
  _AgencyRecommendationState createState() => _AgencyRecommendationState();
}

class _AgencyRecommendationState extends State<AgencyRecommendation> {
  final double xOffset = 200;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 3;
    final double itemHeight = itemWidth + 30;
    final fameLinkFun = Provider.of<FameLinkFun>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            setState(() {
              Navigator.of(context).pop();
            });
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(CommonImage.dart_back_img),
        //     alignment: Alignment.center,
        //     fit: BoxFit.fill,
        //   ),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    'Recommendations',
                    style: GoogleFonts.nunitoSans(
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        color: black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    fameLinkFun!.recommendations.length.toString(),
                    style: GoogleFonts.nunitoSans(
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        color: black),
                  ),
                ),
              ],
            ),
            fameLinkFun!.recommendations.isEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: 2,
                    padding: EdgeInsets.only(left: 1, top: 10),
                    itemBuilder: (context, index) {
                      // final item = recommendations[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            // CircleAvatar(
                            //     radius: 30.0,
                            //     backgroundImage: NetworkImage(
                            //         ApiProvider.collabPostImageBaseUrl +
                            //             item.user.profileImage),
                            //   ),

                            CircleAvatar(
                                radius: 30,
                                child: Image.asset(
                                    "assets/images/coins_icon.png")),

                            Container(
                              height: 70,
                              width: MediaQuery.of(context).size.width / 1.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xff9B9B9B).withOpacity(0.1),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "kgklerhebmhlkdfbopgmroempergrehrthrthrthtrhr", //brandCollabSubData[index].type
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: 12,
                                        color: black,
                                        fontStyle: FontStyle.normal,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Image.asset(
                                      "assets/icons/dots.png",
                                      color: black,
                                      height: 15,
                                      width: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
