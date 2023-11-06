import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../networking/config.dart';
import '../../../util/config/color.dart';
import '../../Famelinkprofile/function/famelinkFun.dart';
import 'provider/hiring_profile_provider.dart';
import 'widget/behindscenes.dart';
import 'widget/frontfaces.dart';

class HiringProfile extends StatefulWidget {
  final int tabIndex;

  HiringProfile({this.tabIndex = 0});

  // final String? faces;
  // final String? crew;

  @override
  State<HiringProfile> createState() => _HiringProfileState();
}

class _HiringProfileState extends State<HiringProfile> {
  HiringProfileProvider? hiringProfileprovider;
  FameLinkFun? otherPofileprovider;

  @override
  void initState() {
    super.initState();
    hiringProfileprovider =
        Provider.of<HiringProfileProvider>(context, listen: false);
    hiringProfileprovider!.index = widget.tabIndex;
    otherPofileprovider = Provider.of<FameLinkFun>(context, listen: false);
    hiringProfileprovider!.getCategories();
    hiringProfileprovider!.getfaceCategories();
    hiringProfileprovider!.init();

    if (otherPofileprovider!.otherUserProfileJobLinksModelResult != null &&
        otherPofileprovider!.otherUserProfileJobLinksModelResult.length != 0) {
      if (otherPofileprovider!.otherUserProfileJobLinksModelResult[0].crew !=
          null) {
        hiringProfileprovider!.locationlist.clear();
        hiringProfileprovider!.workController.text = otherPofileprovider!
            .otherUserProfileJobLinksModelResult[0].crew!.workExperience
            .toString();
        hiringProfileprovider!.awardsController.text = otherPofileprovider!
            .otherUserProfileJobLinksModelResult[0].crew!.achievements
            .toString();

        otherPofileprovider!
            .otherUserProfileJobLinksModelResult[0].crew!.interestCat!
            .forEach((element) {
          hiringProfileprovider!.categorySelected.add(element.id);
        });
        print(hiringProfileprovider!.fameCategorySelected);
        otherPofileprovider!
            .otherUserProfileJobLinksModelResult[0].crew!.interestedLoc!
            .forEach((element) {
          Map lo = {
            "district": element.district,
            "state": element.state,
            "country": element.country,
          };
          hiringProfileprovider!.locationlist.add(lo);
        });

        hiringProfileprovider!.experienceIndex = otherPofileprovider!
                    .otherUserProfileJobLinksModelResult[0]
                    .crew!
                    .experienceLevel ==
                "experienced"
            ? 0
            : 1;
      }

      //faces set
      if (otherPofileprovider!.otherUserProfileJobLinksModelResult[0].faces !=
          null) {
        hiringProfileprovider!.locationlistface.clear();
        hiringProfileprovider!.ftController.text = otherPofileprovider!
            .otherUserProfileJobLinksModelResult[0].faces!.height!.foot
            .toString()
            .toString();
        hiringProfileprovider!.ftCount =
            int.parse(hiringProfileprovider!.ftController.text);
        hiringProfileprovider!.inController.text = otherPofileprovider!
            .otherUserProfileJobLinksModelResult[0].faces!.height!.inch
            .toString();
        hiringProfileprovider!.inCount =
            int.parse(hiringProfileprovider!.inController.text);

        hiringProfileprovider!.weightController.text = otherPofileprovider!
            .otherUserProfileJobLinksModelResult[0].faces!.weight
            .toString();

        hiringProfileprovider!.bustController.text = otherPofileprovider!
            .otherUserProfileJobLinksModelResult[0].faces!.bust
            .toString();

        hiringProfileprovider!.waistController.text = otherPofileprovider!
            .otherUserProfileJobLinksModelResult[0].faces!.waist
            .toString();
        hiringProfileprovider!.hipController.text = otherPofileprovider!
            .otherUserProfileJobLinksModelResult[0].faces!.hip
            .toString();
        hiringProfileprovider!.eyeController.text = otherPofileprovider!
            .otherUserProfileJobLinksModelResult[0].faces!.eyeColor
            .toString();
        hiringProfileprovider!.sComplexion = otherPofileprovider!
            .otherUserProfileJobLinksModelResult[0].faces!.complexion
            .toString();

        otherPofileprovider!
            .otherUserProfileJobLinksModelResult[0].faces!.interestCat!
            .forEach((element) {
          hiringProfileprovider!.fameCategorySelected.add(element.id);
        });
        otherPofileprovider!
            .otherUserProfileJobLinksModelResult[0].faces!.interestedLoc!
            .forEach((element) {
          Map lo = {
            "district": element.district,
            "state": element.state,
            "country": element.country,
          };
          hiringProfileprovider!.locationlistface.add(lo);
        });
      }
      //otherPofileprovider.fameCategorySelected="2323";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HiringProfileProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(16),
                      right: ScreenUtil().setWidth(16),
                      top: ScreenUtil().setHeight(50)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: black,
                            size: ScreenUtil().radius(20),
                          )),
                      Padding(
                        padding:
                            EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "Your Hiring ",
                                style: GoogleFonts.roboto(
                                    fontSize: ScreenUtil().setSp(18),
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    height: 0.25,
                                    color: black),
                              ),
                              TextSpan(
                                text: "Profile",
                                style: GoogleFonts.roboto(
                                  fontSize: ScreenUtil().setSp(18),
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  height: 0.25,
                                  color: orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_back_ios_rounded,
                        color: white,
                        size: ScreenUtil().radius(20),
                      )
                    ],
                  ),
                ),
                ApiProvider.userType == "agency"
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(40),
                            right: ScreenUtil().setWidth(16),
                            top: ScreenUtil().setHeight(25)),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if (provider.index == 1) {
                                  provider.changeindex(0);
                                  // provider.index = 0;
                                }
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    provider.index == 0
                                        ? "assets/icons/selectedRadio.png"
                                        : "assets/icons/radioCircle.png",
                                    height: ScreenUtil().setHeight(14),
                                    width: ScreenUtil().setWidth(14),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(7.5),
                                        left: ScreenUtil().setWidth(6)),
                                    child: Text(
                                      "Front Faces",
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: provider.index == 0
                                            ? FontWeight.w700
                                            : FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        height: 0.16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                if (provider.index == 0) {
                                  provider.changeindex(1);
                                  //  setState(() {
                                  // provider.index = 1;
                                  // });
                                }
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    provider.index == 1
                                        ? "assets/icons/selectedRadio.png"
                                        : "assets/icons/radioCircle.png",
                                    height: ScreenUtil().setHeight(14),
                                    width: ScreenUtil().setWidth(14),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(7.5),
                                        left: ScreenUtil().setWidth(6)),
                                    child: Text(
                                      "Behind the Scenes",
                                      style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: provider.index == 1
                                            ? FontWeight.w700
                                            : FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        height: 0.16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                provider.index == 1
                    ? Behindscenes(
                        id: '${widget.tabIndex}',
                      )
                    : FrontFaces(
                        id: '${widget.tabIndex}',
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
