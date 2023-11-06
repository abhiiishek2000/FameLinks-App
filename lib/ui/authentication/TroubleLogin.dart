import 'package:famelink/dio/api/api.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/settings/WebViewScreen.dart';
import 'package:famelink/ui/settings/faq_sucess_screen.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class TroubleLogin extends StatefulWidget {
  const TroubleLogin({Key? key}) : super(key: key);

  @override
  _TroubleLoginState createState() => _TroubleLoginState();
}

class _TroubleLoginState extends State<TroubleLogin> {

  TextEditingController commentController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  final ApiProvider _api = ApiProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        toolbarHeight: ScreenUtil().setSp(61),
        backgroundColor: appBackgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: black)),
        title: Text.rich(TextSpan(children: <TextSpan>[
          TextSpan(
              text: 'Describe your',
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w400,
                  color: black,
                  fontSize: ScreenUtil().setSp(18))),
          TextSpan(
              text: ' Issue',
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w700,
                  fontSize: ScreenUtil().setSp(18),
                  color: lightRed)),
        ])),
      ),
      body: Container(
        width: ScreenUtil().screenWidth,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: ScreenUtil().setSp(25),
              ),
              Padding(
                padding: EdgeInsets.only(left:ScreenUtil().setSp(55),right: ScreenUtil().setSp(56) ),
                child: Text("We apologize for the inconvenience caused.  Please visit our",textAlign : TextAlign.center,style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenUtil().setSp(14),
                    color: black)),
              ),
              SizedBox(
                height: ScreenUtil().setSp(8),
              ),
              InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ontext) => WebViewScreen("FAQ section")),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'FAQ section',
                      style: GoogleFonts.nunitoSans(
                          color: buttonBlue,
                          fontSize: ScreenUtil().setSp(18),
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: ScreenUtil().setSp(8),
                    ),
                    Image.asset("assets/icons/link.png",color: lightGray)
                  ],
                ),
              ),
              SizedBox(
                height: ScreenUtil().setSp(45),
              ),
              Text("or lodge a support request below",style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w300,
                  fontSize: ScreenUtil().setSp(14),
                  color: black)),
              Container(
                margin: EdgeInsets.only(top: ScreenUtil().setSp(10),left: ScreenUtil().setSp(28),right: ScreenUtil().setSp(28)),
                child: TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: ScreenUtil().setSp(16),left: ScreenUtil().setSp(17),right: ScreenUtil().setSp(19)),
                    hintText: 'Enter Your Name',
                    hintStyle: GoogleFonts.nunitoSans(fontWeight: FontWeight.w400,fontSize: ScreenUtil().setSp(14),color: lightGray),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setSp(5))),
                      borderSide: BorderSide(
                        width: 1,
                        color: lightGray,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(ScreenUtil().setSp(5)),
                      borderSide: BorderSide(
                        width: 1,
                        color: buttonBlue,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: ScreenUtil().setSp(20),left: ScreenUtil().setSp(28),right: ScreenUtil().setSp(28)),
                child: TextFormField(
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(10),
                  ],
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: ScreenUtil().setSp(16),left: ScreenUtil().setSp(17),right: ScreenUtil().setSp(19)),
                    hintText: 'Enter Phone Number',
                    hintStyle: GoogleFonts.nunitoSans(fontWeight: FontWeight.w400,fontSize: ScreenUtil().setSp(14),color: lightGray),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setSp(5))),
                      borderSide: BorderSide(
                        width: 1,
                        color: lightGray,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(ScreenUtil().setSp(5)),
                      borderSide: BorderSide(
                        width: 1,
                        color: buttonBlue,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(10),
                    bottom: ScreenUtil().setHeight(10)),
                child: Text('Or',
                    style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil().setSp(12))
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: ScreenUtil().setSp(10),left: ScreenUtil().setSp(28),right: ScreenUtil().setSp(28)),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: ScreenUtil().setSp(16),left: ScreenUtil().setSp(17),right: ScreenUtil().setSp(19)),
                    hintText: 'Enter Email ID',
                    hintStyle: GoogleFonts.nunitoSans(fontWeight: FontWeight.w400,fontSize: ScreenUtil().setSp(14),color: lightGray),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setSp(5))),
                      borderSide: BorderSide(
                        width: 1,
                        color: lightGray,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(ScreenUtil().setSp(5)),
                      borderSide: BorderSide(
                        width: 1,
                        color: buttonBlue,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: ScreenUtil().setSp(40),left: ScreenUtil().setSp(28),right: ScreenUtil().setSp(28)),
                child: TextFormField(
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(500),
                  ],
                  controller: commentController,
                  minLines: 6,
                  maxLines: 6,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: ScreenUtil().setSp(16),left: ScreenUtil().setSp(17),right: ScreenUtil().setSp(19)),
                    hintText: 'Describe your issue',
                    hintStyle: GoogleFonts.nunitoSans(fontWeight: FontWeight.w400,fontSize: ScreenUtil().setSp(14),color: lightGray),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setSp(5))),
                      borderSide: BorderSide(
                        width: 1,
                        color: lightGray,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(ScreenUtil().setSp(5)),
                      borderSide: BorderSide(
                        width: 1,
                        color: buttonBlue,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  _addFeedbackApi();
                },
                child: Container(
                  margin: EdgeInsets.only(
                      top: ScreenUtil().setSp(34),
                      bottom: ScreenUtil().setSp(100)),
                  width: ScreenUtil().setWidth(250),
                  height: ScreenUtil().setHeight(50),
                  decoration: new BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [lightRedWhite, lightRed]),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Submit',
                        style: GoogleFonts.nunitoSans(
                            color: white,
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(18)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  void _addFeedbackApi() async {
    if (commentController.text.isNotEmpty && nameController.text.isNotEmpty && (phoneController.text.isNotEmpty || emailController.text.isNotEmpty)) {
      Map<String, dynamic> map;
      if(phoneController.text.isEmpty){
        map = {
          "name": nameController.text,
          "body": commentController.text,
          "email": emailController.text,
        };
      }else if(emailController.text.isEmpty){
        map = {
          "name": nameController.text,
          "body": commentController.text,
          "mobileNumber": phoneController.text,
        };
      }else {
        map = {
          "name": nameController.text,
          "body": commentController.text,
          "mobileNumber": phoneController.text,
          "email": emailController.text,
        };
      }
      Api.post.call(context, method: "users/report/issue",
          param: map,
          onResponseSuccess: (Map object)async{
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ontext) => FAQSuccessScreen()),
            );
            if(result != null){
              Navigator.pop(context, true);
            }
          });
    }else if(nameController.text.isEmpty){
      Constants.toastMessage(msg: "Enter Name");
    }else if(commentController.text.isEmpty){
      Constants.toastMessage(msg: "Describe your issue");
    }else if(phoneController.text.isEmpty || emailController.text.isEmpty){
      Constants.toastMessage(msg: "Enter Mobile Number Or Email");
    }
  }

}
