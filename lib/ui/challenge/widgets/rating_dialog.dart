import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/OpenChallengesResponse.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../../models/AddRatingResponse.dart';
import '../../../providers/ChallengeProvider/famelinkChallengeProvider.dart';

showRateDialog(BuildContext context, OpenChallengesResult openChallengesResult,
    int index, String trendId,
    {int? initialValue}) {
  double sliderValue = 0;
  // TODO: Dialog code
  return showDialog(
    context: context,
    barrierColor: Colors.transparent,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: StatefulBuilder(
            builder: (context, setState) => Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text.rich(
                    TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: '${openChallengesResult.hashTag}\n',
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(18),
                            color: HexColor("FF5C28")),
                      ),
                      TextSpan(
                        text: 'Rate this Trendz by selecting hearts',
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                            color: Color(0xff4B4E58),
                            fontSize: ScreenUtil().setSp(12)),
                      )
                    ]),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RatingBar(
                        initialRating:
                        double.parse('${initialValue ?? 0.0}'),
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemSize: 24,
                        ratingWidget: RatingWidget(
                          full: SvgPicture.asset(
                              'assets/icons/ic_likefill.svg',
                              color: Colors.red),
                          empty: SvgPicture.asset(
                              'assets/icons/svg/ic_like.svg'),
                          half:
                          SvgPicture.asset('assets/icons/ic_liked.svg'),
                        ),
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        onRatingUpdate: (rating) {
                          sliderValue = rating;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      dialogButton('Cancel', () => Navigator.pop(context)),
                      dialogButton('Submit', () {
                        Map<String, String> map = {
                          'trendId': "${trendId.toString()}",
                          'rating':
                          "${sliderValue < 1 ? 1.toString() : sliderValue.round().toString()}"
                        };
                        Api.post.call(context,
                            method: "rating/addRating",
                            param: map,
                            isLoading: true,
                            onResponseSuccess: (Map object) {
                              AddRatingResponseResult result =
                              AddRatingResponseResult.fromJson(
                                  object['result']);
                              Provider.of<ChallengeScreenProvider>(context,
                                  listen: false)
                                  .updateRatingStatus(
                                  openChallengesResult, result, index);
                              Navigator.pop(context);
                              Fluttertoast.showToast(
                                  msg: 'Rating added successfully');
                            });
                      }),
                    ],
                  ),
                ],
              ),
            )),
      );
    },
  );
}

GestureDetector dialogButton(String btnTxt, Function() onPressed) =>
    GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Color(0xFF9B9B9B), width: 1)),
        child: Text(btnTxt,
            style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.w600,
                color: Color(0xff4B4E58),
                fontSize: ScreenUtil().setSp(12))),
      ),
    );