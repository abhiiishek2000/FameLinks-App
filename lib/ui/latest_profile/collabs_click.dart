import 'package:famelink/networking/config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../common/common_image.dart';
import '../../util/config/color.dart';
import '../FameChatScreen.dart';
import '../Famelinkprofile/function/famelinkFun.dart';

class CollabClick extends StatefulWidget {
  @override
  _CollabClickState createState() => _CollabClickState();
}

class _CollabClickState extends State<CollabClick> {
  int? brandCount, userCollabCount;
  final double xOffset = 200;

  @override
  void initState() {
    final fameLinksFeedProvider =
        Provider.of<FameLinkFun>(context, listen: false);
    for (var index in fameLinksFeedProvider!.collab) {
      brandCount = index.brandCollabs!.length;
      userCollabCount = index.userCollabs!.length;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 3;
    final double itemHeight = itemWidth + 30;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.25),
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
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FameChatScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Image.asset(
                  'assets/icons/sendmessage.png',
                  height: 20,
                  width: 23,
                ),
              ))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(CommonImage.dart_back_img),
            alignment: Alignment.center,
            fit: BoxFit.fill,
          ),
        ),
        child: Consumer<FameLinkFun>(
          builder: (context, provider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    'Brand Collaborations: $brandCount',
                    style: GoogleFonts.nunitoSans(
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        color: white),
                  ),
                ),
                provider.collab.isNotEmpty
                    ? GridView.builder(
                        shrinkWrap: true,
                        itemCount: provider.brandCollabSubData.length,
                        padding: EdgeInsets.only(left: 1, top: 10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          // final item = collab[index];

                          return ListTile(
                            title: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  ApiProvider.profile +
                                      "/" +
                                      provider.brandCollabSubData[index]
                                          .profileImage!),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                provider.brandCollabSubData[index].type!,
                                style: GoogleFonts.nunitoSans(
                                  fontSize: 12,
                                  color: white,
                                  fontStyle: FontStyle.normal,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text('User Collaborations: $userCollabCount',
                      style: GoogleFonts.nunitoSans(
                          fontSize: 12,
                          fontStyle: FontStyle.normal,
                          color: white)),
                ),
                provider.collab.isNotEmpty
                    ? GridView.builder(
                        shrinkWrap: true,
                        itemCount: provider.collabSubData.length,
                        padding: EdgeInsets.only(left: 1, top: 10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        // Provide a builder function. This is where the magic happens.
                        // Convert each item into a widget based on the type of item it is.
                        itemBuilder: (context, index) {
                          // final item = collab[index];

                          return ListTile(
                            title: CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(ApiProvider
                                      .profile +
                                  "/" +
                                  provider.collabSubData[index].profileImage!),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                provider.collabSubData[index].type!,
                                style: GoogleFonts.nunitoSans(
                                  fontSize: 12,
                                  color: white,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Container()
              ],
            );
          },
        ),
      ),
    );
  }
}
