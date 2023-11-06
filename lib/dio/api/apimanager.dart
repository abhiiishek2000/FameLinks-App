import 'dart:convert';

import 'package:famelink/common/URLConst.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiManager {
  static Future<http.Response> getSearchLocation({
    String? searchItem,
  }) async {
    debugPrint('1-1-1-1-1- Inside getSearchLocation Api Calling');
    SharedPreferences? prefs = await SharedPreferences.getInstance();

    Map<String,String>? header = {"Authorization": prefs.getString("token").toString()};
    try {
      String url = (URLConst.base_url + URLConst.location_search) +
          searchItem.toString();
      final response = await http.get(
        Uri.parse(url),
        headers: header,
      );
      debugPrint('1-1-1-1 getSearchLocation Request ${response.request}');
      debugPrint('1-1-1-1 getSearchLocation StatusCode ${response.statusCode}');
      debugPrint('1-1-1-1 getSearchLocation Body ${response.body}');
      return response;
    } catch (e) {
      debugPrint('0-0-0-0-0 :: getSearchLocation ${e.toString()}');
      return http.Response('error', 400);
    }
  }

  static Future<http.Response> patch({dynamic param, String? url1}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString("token");

    Map<String,String>? header = {"Authorization": token!};
    try {
      String url = "https://userapi.budlinks.in/v2/" + url1!;
      final response = await http.patch(
        Uri.parse(url),
        headers: header,
        body: jsonEncode(param),
      );
      return response;
    } catch (e) {
      return http.Response('error', 400);
    }
  }

  static Future<http.Response> post({dynamic param, String? url1}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString("token");

    Map<String,String>? header = {"Authorization": token!};
    // var header={"Authorization":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MzczNGNmMTQwMzk1YTIwZmEwM2MyZWIiLCJpYXQiOjE2Njg1MDA3MjEsImV4cCI6MTM2Njg1MDA3MjF9.9fUN-0Up8CSXO3TPBPd4Qn244J5E7Z7-vEzGplvrpsU"};
    // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MmM4NDYxOTU2MmJiZjExNDc0YzYzNDIiLCJpYXQiOjE2NjE4NTU1NDQsImV4cCI6MTM2NjE4NTU1NDR9.17-U_FpEJwzRliE5ZlkiPV_BNYav7v53nD2Gqkd9Y0M'};
    try {
      String url = "https://userapi.budlinks.in/v2/" + url1!;
      final response = await http.post(
        Uri.parse(url),
        headers: header,
        body: param,
      );
      return response;
    } catch (e) {
      print(e);
      return http.Response('error', 400);
    }
  }
}
