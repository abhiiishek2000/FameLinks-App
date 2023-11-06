import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:famelink/dio/excep/dio_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../communication.dart';

class Post {
  ApiClient client;
  bool isLoading = true;
  Post(this.client);

  void call(BuildContext context,
      {@required String? method,
      @required Map<String, dynamic>? param,
      Function(Map object)? onResponseSuccess,
      Function(String message)? onRetry,
      Function(double percentage)? onProgress,
      bool? isLoading}) async {
    this.isLoading = isLoading != null ? isLoading : true;
    if (param != null) {
      log("PARAMS:::$param:::$isLoading");
    }
    var sharedPreferences = await SharedPreferences.getInstance();
    log("TOKEN::::${sharedPreferences.getString("token")}");
    if (sharedPreferences.getString("token") != null) {
      client.addDefaultHeader(
          "Authorization", sharedPreferences.getString("token").toString());
    }
    // client.addDefaultHeader("Authorization", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzczNGNmMTQwMzk1YTIwZmEwM2MyZWIiLCJpYXQiOjE2Njg1MDA3MjEsImV4cCI6MTM2Njg1MDA3MjF9.9fUN-0Up8CSXO3TPBPd4Qn244J5E7Z7-vEzGplvrpsU");
    log(
        "URI:::${Uri(scheme: client.hostScheme, host: client.host, path: "${client.hostPath}/$method", queryParameters: param)}");
    client.startCall(context, method!, this.isLoading);
    try {
      client.addDefaultHeader("Content-Type", "application/json");
      print("HEADER:::${client.defaultHeaderMap}");
      var response = await client.dio.post<Map>(
        "/$method",
        onReceiveProgress: (count, total) {
          if (onProgress != null) {
            //onProgress(total);
          }
        },
        data: jsonEncode(param),
        onSendProgress: (count, total) {
          if (onProgress != null) {
            onProgress((count / total) * 100);
          }
        },
      );
      log("${response.statusCode}");
      if (response.statusCode == 200) {
        log("${response.data is Map}");
        if (client.checkStatus(context, method, response.data!,
            response.statusCode!, this.isLoading)) {
          if (onResponseSuccess != null) {
            onResponseSuccess(response.data!);
          }
        } else {
          client.onMsg(context, method, response.data!, response.statusCode!,
              this.isLoading);
        }
      } else {
        client
            .onError(context, method, "Something went wrong!", this.isLoading)
            .then((value) {
          if (onRetry != null) {
            onRetry("Something went wrong!");
          }
        });
      }
    } catch (e) {
      log(e.toString());
      client
          .onError(
              context,
              method,
              e is DioError
                  ? DioExceptions.fromDioError(e).message!
                  : e.toString(),
              this.isLoading)
          .then((value) async {
        if (onRetry != null && value) {
          onRetry(e is DioError
              ? DioExceptions.fromDioError(e).message!
              : e.toString());
          retry(e, context, method, onResponseSuccess!, this.isLoading);
        }
      });
    }
  }

  void retry(e, BuildContext context, String method,
      Function(Map object) onResponseSuccess, bool isLoading) async {
    if (e is DioError) {
      var response = await client.dio
          .request(
        e.requestOptions.path,
        cancelToken: e.requestOptions.cancelToken,
        data: e.requestOptions.data,
        onReceiveProgress: e.requestOptions.onReceiveProgress,
        onSendProgress: e.requestOptions.onSendProgress,
        queryParameters: e.requestOptions.queryParameters,
      )
          .then((response) {
        if (response.statusCode == 200) {
          if (client.checkStatus(
              context, method, response.data, response.statusCode!, isLoading)) {
            if (onResponseSuccess != null) {
              onResponseSuccess(response.data);
            }
          } else {
            client.onMsg(
                context, method, response.data, response.statusCode!, isLoading);
          }
        } else {
          client
              .onError(context, method, "Something went wrong!", isLoading)
              .then((value) {
            if (value) {
              retry(e, context, method, onResponseSuccess, isLoading);
            }
          });
        }
      }, onError: (e) {
        client
            .onError(context, method, "Something went wrong!", isLoading)
            .then((value) {
          if (value) {
            retry(e, context, method, onResponseSuccess, isLoading);
          }
        });
      });
    }
  }
}
