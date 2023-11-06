import 'dart:convert';
import 'package:famelink/dio/communication.dart';
import 'package:famelink/dio/methods/delete.dart';
import 'package:famelink/dio/methods/get.dart';
import 'package:famelink/dio/methods/patch.dart';
import 'package:famelink/dio/methods/post.dart';
import 'package:famelink/dio/methods/put.dart';
import 'package:famelink/dio/methods/uploadPost.dart';
import 'package:famelink/dio/methods/uploadPut.dart';
import 'package:flutter/material.dart';

class Api {
  static ApiClient apiClient = ApiClient(
    host: "userapi.famelinks.app",
    hostScheme: "https",
    hostPath: "v2",
    onResponse: (context, method, response, statusCode, bool? isLoading) {
      if (isLoading!) {
        // Constants.progressDialog(false, context);
      }
      return response!['success'] == true;
    },
    onError:
        (BuildContext context, String method, String error, bool? isLoading) {
      if (isLoading!) {
        // Constants.progressDialog(false, context);
      }
      return Future(() => false);

      //   return showDialog<bool>(
      //   context: context,
      //   barrierDismissible: false,
      //   barrierLabel:
      //   MaterialLocalizations
      //       .of(context)
      //       .modalBarrierDismissLabel,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       content: Text(error),
      //       actions: <Widget>[
      //         TextButton(
      //           child: const Text('Cancel'),
      //           onPressed: () {
      //             Navigator.pop(context);
      //           },
      //         ),
      //         TextButton(
      //           child: const Text('retry'),
      //           onPressed: () {
      //             Navigator.pop(context, true);
      //           },
      //         ),
      //       ],
      //     );
      //   },
      // );
    },
    onMsg: (context, method, response, statusCode, bool isLoading) {
      if (isLoading) {
        // Constants.progressDialog(false, context);
      }
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(response['message'] ?? json.encode(response)),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    },
    onStart: (context, method, bool? isLoading) {
      // Api.apiClient.defaultHeaderMap.putIfAbsent("Authorization", () => "Bearer ${SessionManager.getString(Session.AUTH_KEY)}");
      if (isLoading!) {
        // Constants.progressDialog(true, context);
      }
    },
  );
  Future<bool?> showD(BuildContext context, String error) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(error),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('retry'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  static ApiClient apiClient2 = ApiClient(
    host: "userapi.budlinks.in",
    hostScheme: "https",
    hostPath: "v2",
    onResponse: (context, method, response, statusCode, bool? isLoading) {
      return response!['success'] == true;
    },
    onError: (context, method, error, bool isLoading) {
      if (isLoading) {
        // Constants.progressDialog(false, context);
      }
      return Future(() => false);
      // //return showD(context, error);
      // return showDialog<bool>(
      //   context: context,
      //   barrierDismissible: false,
      //   barrierLabel:
      //   MaterialLocalizations
      //       .of(context)
      //       .modalBarrierDismissLabel,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       content: Text(error),
      //       actions: <Widget>[
      //         TextButton(
      //           child: const Text('Cancel'),
      //           onPressed: () {
      //             Navigator.pop(context);
      //           },
      //         ),
      //         TextButton(
      //           child: const Text('retry'),
      //           onPressed: () {
      //             Navigator.pop(context, true);
      //           },
      //         ),
      //       ],
      //     );
      //   },
      // );
    },
    onMsg: (context, method, response, statusCode, bool isLoading) {
      if (isLoading) {
        // Constants.progressDialog(false, context);
      }
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(response['message'] ?? json.encode(response)),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    },
    onStart: (context, method, bool? isLoading) {
      // Api.apiClient.defaultHeaderMap.putIfAbsent("Authorization", () => "Bearer ${SessionManager.getString(Session.AUTH_KEY)}");
      var snackBar = SnackBar(
        content: Text('Uploading...'),
      );
      ScaffoldMessenger.of(context!).showSnackBar(snackBar);
    },
  );

  static Get get = Get(apiClient);
  static Post post = Post(apiClient);
  static Put put = Put(apiClient);
  static UploadPut uploadPut = UploadPut(apiClient);
  static UploadPost uploadPost = UploadPost(apiClient2);
  static Delete delete = Delete(apiClient);
  static Patch patch = Patch(apiClient);
}
