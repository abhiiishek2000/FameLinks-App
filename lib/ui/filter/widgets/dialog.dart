import 'package:flutter/material.dart';

showLoading(BuildContext context, String title) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: 40,
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(title),
                ],
              ),
            ),
          ),
        );
      });
}
