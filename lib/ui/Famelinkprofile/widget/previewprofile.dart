import 'package:flutter/material.dart';

class PreviewProfile extends StatelessWidget {
   PreviewProfile({Key? key, required this.path}) : super(key: key);
final String path;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setStates) {
      return AlertDialog(
        content: Text('Alert!'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2.0))),
      );
    });
  }
}
