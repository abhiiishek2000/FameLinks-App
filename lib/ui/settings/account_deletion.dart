import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/authentication/login_screen.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountDeletion extends StatefulWidget {
  @override
  State<AccountDeletion> createState() => _AccountDeletionState();
}

class _AccountDeletionState extends State<AccountDeletion> {
  final ApiProvider _api = ApiProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: Colors.black,)),
        title: Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: "Account",
                style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w700,
                  color: HexColor("#030C23"),
                  shadows: <Shadow>[
                    Shadow(
                      color: Color(0xFF000000).withOpacity(0.25),
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: " Deletion",
                style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontSize: 18,
                  color: HexColor("#FF5C28"),
                  shadows: <Shadow>[
                    Shadow(
                      color: Color(0xFF000000).withOpacity(0.25),
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Text(
              'Dear User,\n Once you delete your account, you will not be able to recover you information again.',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                  fontSize: 14, color: HexColor('#000000')),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Instead, you can suspend your account untill next login attempt.',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                  fontSize: 14, color: HexColor('#000000')),
            ),
            SizedBox(height: 5),
            TextButton(
                onPressed: () async{
                  Constants.progressDialog(true, context);
                  var result = await _api.accountDelete("suspend");
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  if (result != null) {
                    print(result);
                    setState(() {
                      if(result == 200){
                        prefs.clear();

                      }
                    });
                    return  Navigator.pushAndRemoveUntil<void>(
                      context,
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) => LoginScreen()),
                      ModalRoute.withName('/'),
                    );
                  }
                },
                child: Text(
                  'Suspend',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 16,
                      color: HexColor('#FF5C28'),
                      fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 20),
            Text(
              'Or you can hide your account from the public untill you choose to make it public again.',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                  fontSize: 14, color: HexColor('#000000')),
            ),
            SizedBox(
              height: 5,
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  'Make Account Private',
                  style: GoogleFonts.nunitoSans(
                      color: HexColor('#0060FF'),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 20),
            Text(
              'If you still wish to delete you account, you will have option to recover the same back within the next 30 days for the date of deletion.',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                  color: HexColor('#000000'),
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Are you sure you want to delete you account?',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunitoSans(
                  fontSize: 14,
                  color: HexColor('#000000'),
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: ()async{
                  Constants.progressDialog(true, context);
                  var result = await _api.accountDelete("delete");
                    if (result != null) {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      print(result);
                      setState(() {
                        if(result == 200){
                          prefs.clear();

                        }
                      });
                      return  Navigator.pushAndRemoveUntil<void>(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) => LoginScreen()),
                        ModalRoute.withName('/'),
                      );
                    }

                },
                child: Text(
                  'Yes, Delete my account',
                  style: GoogleFonts.nunitoSans(
                    color: HexColor('#000000'),
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
