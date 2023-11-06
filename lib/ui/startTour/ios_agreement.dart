import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class IOSAgreement extends StatefulWidget {

  @override
  _IOSAgreementState createState() => _IOSAgreementState();
}

class _IOSAgreementState extends State<IOSAgreement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: ScreenUtil().setSp(40),left: ScreenUtil().setSp(15),right: ScreenUtil().setSp(15),bottom: ScreenUtil().setSp(15)),
            color: black,
            child: Text("Instructions for Minimum Terms of Developer's End-User License Agreement",style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w700,color: white),),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setSp(15),right: ScreenUtil().setSp(15)),
              child: ListView(
                children: [
                  Text.rich(TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "1. Acknowledgement: ",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w700,
                            color: black,
                            fontSize: ScreenUtil().setSp(12))),
                    TextSpan(
                        text: "You and the End-User must acknowledge that the EULA is concluded between You and the End-User only, and not with Apple, and You, not Apple, are solely responsible for the Licensed Application and the content thereof. The EULA may not provide for usage rules for Licensed Applications that are in conflict with, the Apple Media Services Terms and Conditions as of the Effective Date (which You acknowledge You have had the opportunity to review).",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(12),
                            color: black)),
                  ])),
                  SizedBox(
                    height: ScreenUtil().setSp(10),
                  ),
                  Text.rich(TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "2. Scope of License: ",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w700,
                            color: black,
                            fontSize: ScreenUtil().setSp(12))),
                    TextSpan(
                        text: "The license granted to the End-User for the Licensed Application must be limited to a non-transferable license to use the Licensed Application on any Apple-branded Products that the End-User owns or controls and as permitted by the Usage Rules set forth in the Apple Media Services Terms and Conditions, except that such Licensed Application may be accessed and used by other accounts associated with the purchaser via Family Sharing or volume purchasing.",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(12),
                            color: black)),
                  ])),
                  SizedBox(
                    height: ScreenUtil().setSp(10),
                  ),
                  Text.rich(TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "3. Maintenance and Support: ",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w700,
                            color: black,
                            fontSize: ScreenUtil().setSp(12))),
                    TextSpan(
                        text: "You must be solely responsible for providing any maintenance and support services with respect to the Licensed Application, as specified in the EULA, or as required under applicable law. You and the End-User must acknowledge that Apple has no obligation whatsoever to furnish any maintenance and support services with respect to the Licensed Application.",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(12),
                            color: black)),
                  ])),
                  SizedBox(
                    height: ScreenUtil().setSp(10),
                  ),
                  Text.rich(TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "4. Warranty: ",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w700,
                            color: black,
                            fontSize: ScreenUtil().setSp(12))),
                    TextSpan(
                        text: "You must be solely responsible for any product warranties, whether express or implied by law, to the extent not effectively disclaimed. The EULA must provide that, in the event of any failure of the Licensed Application to conform to any applicable warranty, the End-User may notify Apple, and Apple will refund the purchase price for the Licensed Application to that End-User; and that, to the maximum extent permitted by applicable law, Apple will have no other warranty obligation whatsoever with respect to the Licensed Application, and any other claims, losses, liabilities, damages, costs or expenses attributable to any failure to conform to any warranty will be Your sole responsibility.",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(12),
                            color: black)),
                  ])),
                  SizedBox(
                    height: ScreenUtil().setSp(10),
                  ),
                  Text.rich(TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "5. Product Claims: ",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w700,
                            color: black,
                            fontSize: ScreenUtil().setSp(12))),
                    TextSpan(
                        text: "You and the End-User must acknowledge that You, not Apple, are responsible for addressing any claims of the End-User or any third party relating to the Licensed Application or the end- user’s possession and/or use of that Licensed Application, including, but not limited to: (i) product liability claims; (ii) any claim that the Licensed Application fails to conform to any applicable legal or regulatory requirement; and (iii) claims arising under consumer protection, privacy, or similar legislation, including in connection with Your Licensed Application’s use of the HealthKit and HomeKit frameworks. The EULA may not limit Your liability to the End-User beyond what is permitted by applicable law.",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(12),
                            color: black)),
                  ])),
                  SizedBox(
                    height: ScreenUtil().setSp(10),
                  ),
                  Text.rich(TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "6. Intellectual Property Rights: ",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w700,
                            color: black,
                            fontSize: ScreenUtil().setSp(12))),
                    TextSpan(
                        text: "You and the End-User must acknowledge that, in the event of any third party claim that the Licensed Application or the End-User’s possession and use of that Licensed Application infringes that third party’s intellectual property rights, You, not Apple, will be solely responsible for the investigation, defense, settlement and discharge of any such intellectual property infringement claim.",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(12),
                            color: black)),
                  ])),
                  SizedBox(
                    height: ScreenUtil().setSp(10),
                  ),
                  Text.rich(TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "7. Legal Compliance: ",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w700,
                            color: black,
                            fontSize: ScreenUtil().setSp(12))),
                    TextSpan(
                        text: "The End-User must represent and warrant that (i) he/she is not located in a country that is subject to a U.S. Government embargo, or that has been designated by the U.S. Government as a “terrorist supporting” country; and (ii) he/she is not listed on any U.S. Government list of prohibited or restricted parties.",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(12),
                            color: black)),
                  ])),
                  SizedBox(
                    height: ScreenUtil().setSp(10),
                  ),
                  Text.rich(TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "8. Developer Name and Address: ",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w700,
                            color: black,
                            fontSize: ScreenUtil().setSp(12))),
                    TextSpan(
                        text: "You must state in the EULA Your name and address, and the contact information (telephone number; E-mail address) to which any End-User questions, complaints or claims with respect to the Licensed Application should be directed.",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(12),
                            color: black)),
                  ])),
                  SizedBox(
                    height: ScreenUtil().setSp(10),
                  ),
                  Text.rich(TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "9. Third Party Terms of Agreement: ",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w700,
                            color: black,
                            fontSize: ScreenUtil().setSp(12))),
                    TextSpan(
                        text: "You must state in the EULA that the End-User must comply with applicable third party terms of agreement when using Your Application, e.g., if You have a VoIP application, then the End-User must not be in violation of their wireless data service agreement when using Your Application.",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(12),
                            color: black)),
                  ])),
                  SizedBox(
                    height: ScreenUtil().setSp(10),
                  ),
                  Text.rich(TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "10. Third Party Beneficiary: ",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w700,
                            color: black,
                            fontSize: ScreenUtil().setSp(12))),
                    TextSpan(
                        text: "You and the End-User must acknowledge and agree that Apple, and Apple’s subsidiaries, are third party beneficiaries of the EULA, and that, upon the End-User’s acceptance of the terms and conditions of the EULA, Apple will have the right (and will be deemed to have accepted the right) to enforce the EULA against the End-User as a third party beneficiary thereof.",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(12),
                            color: black)),
                  ])),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.pop(context,true);
            },
            child: Container(
              height: ScreenUtil().setSp(45),
              color: Colors.green,
              child: Center(
                child: Text("Accept",style: GoogleFonts.nunitoSans(color: white)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
