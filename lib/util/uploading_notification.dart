import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import 'config/color.dart';

class UploadingNotificationService extends ChangeNotifier {
  bool disMissed = false;

  bool get isDismissed => disMissed;
  double value = 0.0;

  double get uploadedValue => value;
  OverlaySupportEntry? entry;

  void changeDismissStatus(bool value) {
    disMissed = value;
    entry!.dismiss(animate: true);
    notifyListeners();
  }

  void changeValue(double x) {
    print(x);
    value = x / 100;
    notifyListeners();
  }

  void showUploadingNotification(BuildContext context) {
    entry = showOverlayNotification(
      (context) => Consumer<UploadingNotificationService>(
        builder: (BuildContext context, provider, Widget? child) {
          return Material(
            child: SafeArea(
              child: LinearProgressIndicator(
                value: provider.value,
                valueColor: AlwaysStoppedAnimation<Color>(orange),
                backgroundColor: lightGrey,
              ),
            ),
          );
        },
      ),
      duration: Duration.zero,
    );
  }

  void showErrorNotification(BuildContext context) {
    entry = showSimpleNotification(
      Consumer<UploadingNotificationService>(
        builder: (BuildContext context, provider, Widget? child) {
          return ListTile(
            leading: Icon(
              Icons.warning,
              color: Colors.white,
            ),
            title: Text('Something went wrong!'),
          );
        },
      ),
      position: NotificationPosition.bottom,
      background: Colors.red,
      autoDismiss: true,
      context: context,
    );
  }

  void showSuccessNotification(BuildContext context) {
    entry = showSimpleNotification(
      Consumer<UploadingNotificationService>(
        builder: (BuildContext context, provider, Widget? child) {
          return ListTile(
            leading: Icon(
              Icons.check,
              color: Colors.white,
            ),
            title: Text('Uploaded'),
          );
        },
      ),
      position: NotificationPosition.bottom,
      background: Colors.green,
      autoDismiss: true,
      context: context,
    );
  }
}
