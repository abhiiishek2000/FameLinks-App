import 'package:famelink/ui/joblinks/jobController.dart';
import 'package:famelink/ui/otherUserProfile/OtherFameLinksModel.dart';
import 'package:famelink/ui/tour_profile/tour_FameLink.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HowItWorks extends StatefulWidget {
  int? index;
  dynamic controller;
  HowItWorks({Key? key, this.index, this.controller}) : super(key: key);

  @override
  State<HowItWorks> createState() => _HowItWorksState();
}

class _HowItWorksState extends State<HowItWorks> {
  int tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => TourFameLink()),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Image.asset(
                    "assets/images/tourIcon.png",
                    color: darkGray,
                    height: 16,
                    width: 16,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    "Tour",
                    style: GoogleFonts.nunitoSans(
                      fontSize: 12.sp,
                      fontStyle: FontStyle.italic,
                      color: darkGray,
                      fontWeight: FontWeight.w400
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                InkWell(
                  onTap:(){
                    setState(() {
                      tabIndex = 0;
                    });
                  },
                  child: IntrinsicWidth(
                    child: Column(
                      children: [
                        Text(
                          'Guidelines',
                          style: GoogleFonts.nunitoSans(
                            fontSize: tabIndex == 0 ? 14.sp : 12.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: tabIndex == 0 ? darkGray : lightGray
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Container(
                          height: 1,
                          color: tabIndex == 0 ? black : lightGray
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 24.w),
                InkWell(
                  onTap:(){
                    setState(() {
                      tabIndex = 1;
                    });
                  },
                  child: IntrinsicWidth(
                    child: Column(
                      children: [
                        Text(
                          'Titles & Awards',
                          style: GoogleFonts.nunitoSans(
                            fontSize: tabIndex == 1 ? 14.sp : 12.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: tabIndex == 1 ? darkGray : lightGray
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Container(
                          height: 1,
                          color: tabIndex == 1 ? black : lightGray
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 24.w),
                InkWell(
                  onTap:(){
                    setState(() {
                      tabIndex = 2;
                    });
                  },
                  child: IntrinsicWidth(
                    child: Column(
                      children: [
                        Text(
                          'Rules',
                          style: GoogleFonts.nunitoSans(
                            fontSize: tabIndex == 2 ? 14.sp : 12.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: tabIndex == 2 ? darkGray : lightGray
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Container(
                          height: 1,
                          color: tabIndex == 2 ? black : lightGray
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            tabIndex == 0 ?
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How Club Offers Works: ',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 18.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w900,
                      color: black
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Important Rules:',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 16.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      color: black
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'Scoring Principle:',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 16.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      color: black
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'Trendz Participation:',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 16.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      color: black
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'Winner Ratings:',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 16.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      color: black
                    ),
                  ),
                ],
              ),
            ): tabIndex == 1
            ? Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'FameLinks Titles & Awards',
                      style: GoogleFonts.nunitoSans(
                        fontSize: 18.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w900,
                        color: black
                      ),
                    ),
                ],
              ),
            ): Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contest Rules & Regulations:',
                  style: GoogleFonts.nunitoSans(
                    fontSize: 18.sp,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w900,
                    color: black
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Please note that these contests are held, managed, initiated and owned by BudLinks Pvt Ltd (for BudLinks App) and are not sponsored by the app hosting providers i.e. App Store or Play Store or any other hosting platforms.',
                    maxLines: 6,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 17.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      color: black
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Below are the rules & regulations that would govern the contests that would be held by BudLinks:\n\n1.The contest are held for the purpose of entertainment for the users in general and also for the promotion of an individual who would be participating in it.\n\n2.There may not be any monitory benefits granted to the participants or the winners. However, BudLinks might choose to grant you or share any benefit with you at its sole discretion. There is no compulsion except the benefit as mentioned in the clause 1.\n\n3.BudLinks has all the rights to exclude any participants from the contest without providing any reason what so ever if they find a participant not eligible for some reason.\n\n4.BudLinks has all the rights to withdraw the contest at any given point of time without prior notice or any justification.\n\n5.BudLinks has all the rights to conduct an online or offline events with the participants selected by the audiences. The participant has all the right to withdraw from the contest by removing their posts from the BudLinks Platform.\n\n6.In case, an offline event is organized, then BudLinks would intimate the selected candidate and the candidates would have the opportunity to accept or reject to participate in that. The expense of the participants shall be born by the participants themselves.\n\n7.BudLinks has all the rights to amend or add new rules to the contests as and when it deems fit. The same shall be updated in the same place it is right now.\n\n8.If a participant is not willing to participate in a contest, they should not post in the BudLinks feed instead choose other channels like FunLinks or FollowLinks.\n\n9.The judges of the digital beauty contests held on BudLinks would be audiences and not the BudLinks itself. What ever rating / voting the audience provides on the participant’s post would be considered and BudLinks would have not control over it.\n\n10.Once a winner is selected by the audience, the winner would feature in the hall of fame page of BudLinks for that given season for that age group for that gender. Until the next season.',
                    maxLines: 70,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 15.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      color: black
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ) 
          ],
        ),
      ),
    );
  }
}