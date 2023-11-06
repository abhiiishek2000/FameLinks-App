import 'package:dio/dio.dart';
import 'package:famelink/dio/communication.dart';
import 'package:famelink/dio/excep/dio_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Get {
  ApiClient client;
  bool isLoading = true;
  Get(this.client);

  void call(BuildContext context,
      {@required String? method,
      @required Map<String, dynamic>? param,
      Function(Map object)? onResponseSuccess,
      Function(double percentage)? onProgress,
      bool? isLoading,
      String? contentType}) async {
    this.isLoading = isLoading != null ? isLoading : true;
    var sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") != null) {
      client.addDefaultHeader(
          "Authorization", sharedPreferences.getString("token").toString());
    }
    // client.addDefaultHeader("Authorization","eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzczNGNmMTQwMzk1YTIwZmEwM2MyZWIiLCJpYXQiOjE2Njg1MDA3MjEsImV4cCI6MTM2Njg1MDA3MjF9.9fUN-0Up8CSXO3TPBPd4Qn244J5E7Z7-vEzGplvrpsU");
    var options = Options(
        method: "GET",
        contentType: contentType == null ? 'application/json' : contentType,
        headers: client.defaultHeaderMap);
    var request = Dio().getUri(
      Uri(
          scheme: client.hostScheme,
          host: client.host,
          path: "${client.hostPath}/$method",
          queryParameters: param),
      options: options,
      onReceiveProgress: (count, total) {
        if (onProgress != null) {
          onProgress(total / count);
        }
      },
    );
    print(
        "URI:::${Uri(scheme: client.hostScheme, host: client.host, path: "${client.hostPath}/$method", queryParameters: param)}");
    print("HEAD:::${client.defaultHeaderMap}");
    if (param != null) {
      print("PARAMS:::$param");
    }

    client.startCall(context, method!, this.isLoading);
    request.then((response) {
      if (response.statusCode == 200) {
        print(response.data);
        if (client.checkStatus(context, method, response.data,
            response.statusCode!, this.isLoading)) {
          if (onResponseSuccess != null) {
            onResponseSuccess(response.data);
          }
        } else {
          client.onMsg(context, method, response.data, response.statusCode!,
              this.isLoading);
        }
      } else {
        client.onError(
            context, method, "Something went wrong!", this.isLoading);
      }
    }, onError: (e) {
      debugPrint("ERRORR:::${e.toString()}");
      client
          .onError(
              context,
              method,
              e is DioError
                  ? DioExceptions.fromDioError(e).message!
                  : e.toString(),
              this.isLoading)
          .then((value) async {
        if (value != null && value) {
          retry(e, context, method, onResponseSuccess!, this.isLoading);
        }
      });
    });
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
        print("ONRETRY:::${e.toString()}");
        client
            .onError(
                context,
                method,
                e is DioError
                    ? DioExceptions.fromDioError(e).message!
                    : e.toString(),
                isLoading)
            .then((value) async {
          retry(e, context, method, onResponseSuccess, isLoading);
        });
      });
    }
  }
}
