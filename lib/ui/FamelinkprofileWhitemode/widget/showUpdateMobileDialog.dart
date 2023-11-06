import 'package:famelink/ui/Famelinkprofile/function/otplogin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../util/config/color.dart';
import '../../../util/constants.dart';
import 'enterOTPNumber.dart';
import 'enterPhoneNumber.dart';

class showUpdateMobileDialogWhitemode extends StatelessWidget {
  showUpdateMobileDialogWhitemode({Key? key, required this.mobile})
      : super(key: key);
  final String mobile;
  @override
  Widget build(BuildContext context) {
    return Consumer<Otplogin>(
      builder: (context, provider, child) {
        provider.phoneNumber.text = mobile;
        provider.phoneCodeNumber.text = "91";
        Widget cancelButton = TextButton(
          child: Text("Cancel", style: TextStyle(color: lightRed)),
          onPressed: () {
            Navigator.pop(context);
          },
        );
        return AlertDialog(
          content: provider.isOTPLogin
              ? enterOTPNumberWhitemode(
                  otpNumber: provider.otpNumber,
                )
              : enterPhoneNumber(),
          actions: [
            cancelButton,
            TextButton(
              child: Text("Submit", style: TextStyle(color: lightRed)),
              onPressed: () async {
                if (provider.isOTPLogin) {
                  provider.handleOTPIn(context);
                } else {
                  if (provider.phoneCodeNumber.text.length > 1 &&
                      provider.phoneNumber.text.isNotEmpty) {
                    await provider.loginService(context);
                  } else if (provider.phoneCodeNumber.text.length <= 1) {
                    Constants.toastMessage(msg: "Enter Phone Code");
                  } else if (provider.phoneNumber.text.isEmpty) {
                    Constants.toastMessage(msg: "Enter Phone Number");
                  }
                }
              },
            ),
          ],
        );
      },
    );
    ;
  }
}
