import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/userUpdateResponse.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provder/OtherPofileprovider.dart';

class showReferralCodeDialogwhitemode extends StatelessWidget {
  showReferralCodeDialogwhitemode({Key? key, required this.id})
      : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return Consumer<OtherPofileprovider>(
      builder: (context, otherPofileprovider, child) {
        return Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.only(
                left: ScreenUtil().setWidth(
                    (ScreenUtil().screenWidth - ScreenUtil().setSp(315)) / 2),
                right: ScreenUtil().setWidth(
                    (ScreenUtil().screenWidth - ScreenUtil().setSp(315)) / 2)),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setStates) {
              return Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenUtil().setSp(16))),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        color: black25,
                        blurRadius: 4.0,
                      ),
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(ScreenUtil().setSp(16)),
                              topRight:
                                  Radius.circular(ScreenUtil().setSp(16))),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [lightRedWhite, lightRed])),
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(21),
                          bottom: ScreenUtil().setHeight(12),
                          left: ScreenUtil().setWidth(5),
                          right: ScreenUtil().setWidth(5)),
                      child: Center(
                        child: Text(
                          'Send Gift type to your beloved person',
                          style: GoogleFonts.nunitoSans(
                              fontSize: ScreenUtil().setSp(16),
                              color: white,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(ScreenUtil().setSp(16)),
                            bottomRight:
                                Radius.circular(ScreenUtil().setSp(16))),
                        color: appBackgroundColor,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(14),
                                left: ScreenUtil().setWidth(20),
                                right: ScreenUtil().setWidth(20)),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Fame Coins: ',
                                          style: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(12),
                                              color: black,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          '${Constants.fameCoins} Coins Left',
                                          style: GoogleFonts.nunitoSans(
                                              fontSize: ScreenUtil().setSp(12),
                                              color: black,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '(Max 5 Coins per person per day allowed)',
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: ScreenUtil().setSp(10),
                                          color: lightGray,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: ScreenUtil().setSp(5),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    textAlign: TextAlign.start,
                                    textAlignVertical: TextAlignVertical.center,
                                    controller:
                                        otherPofileprovider!.fameCoinController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    textInputAction: TextInputAction.done,
                                    style: GoogleFonts.nunitoSans(
                                        fontSize: ScreenUtil().setSp(12),
                                        color: darkGray,
                                        fontWeight: FontWeight.w400),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: buttonBlue,
                                            width: ScreenUtil().radius(1)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                ScreenUtil().radius(2))),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: buttonBlue,
                                            width: ScreenUtil().radius(1)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                ScreenUtil().radius(2))),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: buttonBlue,
                                            width: ScreenUtil().radius(1)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                ScreenUtil().radius(2))),
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(5),
                                          top: 0,
                                          bottom: 0),
                                      hintStyle: GoogleFonts.nunitoSans(
                                          fontStyle: FontStyle.italic,
                                          fontSize: ScreenUtil().setSp(12),
                                          color: lightGray,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setSp(32),
                                bottom: ScreenUtil().setSp(20)),
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Center(
                                          child: InkWell(
                                    onTap: () async {
                                      Navigator.pop(context);
                                      if (otherPofileprovider!
                                              .fameCoinController
                                              .text
                                              .isNotEmpty &&
                                          int.parse(otherPofileprovider!
                                                  .fameCoinController.text) <=
                                              5) {
                                        if (Constants.fameCoins >=
                                            int.parse(otherPofileprovider!
                                                .fameCoinController.text)) {
                                          Map<String, dynamic> params = {
                                            "fameCoins": otherPofileprovider!
                                                .fameCoinController.text,
                                            "toUserId": id
                                          };
                                          Api.post.call(context,
                                              method: "users/fameCoins",
                                              param: params,
                                              isLoading: false,
                                              onResponseSuccess: (Map object) {
                                            var result =
                                                UserUpdatedResponse.fromJson(
                                                    object);
                                            Constants.toastMessage(
                                                msg: result.message);
                                            // setState(() async {
                                            if (Constants.userType != 'brand') {
                                              otherPofileprovider!
                                                  .getOtherUserProfile(
                                                      id.toString(),1);
                                            } else {
                                              otherPofileprovider!
                                                  .myFamelinks(id.toString());
                                            }

                                            Constants.fameCoins = Constants
                                                    .fameCoins -
                                                int.parse(otherPofileprovider!
                                                    .fameCoinController.text);
                                            otherPofileprovider!
                                                .fameCoinController.text = "";
                                            // });
                                          });
                                        } else {
                                          var snackBar = SnackBar(
                                            content: Text(
                                                'only for ${Constants.fameCoins} coins left'),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      } else {
                                        if (int.parse(otherPofileprovider!
                                                .fameCoinController.text) >
                                            5) {
                                          var snackBar = SnackBar(
                                            content: Text(
                                                'Max 5 Coins per person per day is allowed'),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      }
                                    },
                                    child: Text("Send",
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w700,
                                            fontSize: ScreenUtil().setSp(14),
                                            color: black)),
                                  ))),
                                  Expanded(
                                      child: Center(
                                          child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel",
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: ScreenUtil().setSp(14),
                                            color: black)),
                                  ))),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }));
      },
    );
  }
}
