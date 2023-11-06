import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/Profile_Model.dart';
import '../../../util/config/color.dart';
import '../../../util/constants.dart';
import '../function/otplogin.dart';
import 'enterEmail.dart';
import 'enterOTPNumber.dart';

class showUpdateEmailDialog extends StatelessWidget {
  showUpdateEmailDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Cancel", style: TextStyle(color: lightRed)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    MyProfileResult? upperProfileData;
    Otplogin otplogin = Provider.of<Otplogin>(context, listen: false);
    return Consumer<Otplogin>(
      builder: (context, provider, child) {
        return AlertDialog(
          content: provider.isOTPEmailLogin
              ? enterOTPNumber(
                  otpNumber: provider.otpNumber,
                )
              : enterEmail(
                  emailController: provider.emailController,
                ),
          actions: [
            cancelButton,
            TextButton(
              child: Text("Submit", style: TextStyle(color: lightRed)),
              onPressed: () async {
                if (otplogin.isOTPEmailLogin) {
                  upperProfileData!.email = provider.emailController.text;
                  otplogin.handleOTPEmailIn(context);
                } else {
                  if (provider.emailController.text.isNotEmpty) {
                    await otplogin.emailLoginService(context);
                  } else if (provider.emailController.text.isEmpty) {
                    Constants.toastMessage(msg: "Enter Email");
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
}
