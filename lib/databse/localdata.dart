import 'dart:convert';

import 'package:hive/hive.dart';

class Localdata {
  sethivedata(data, String type) async {
    print("local123  $data");
    var box = await Hive.openBox('alldata');
    // await box.add(jsonDecode(data));
    // //box.getAt(0);
    await box.delete(type);
    await box.put(type, jsonEncode(data));
  }

  Future<String?> gethivedata(String type) async {
    var box = await Hive.openBox('alldata');
    var data = box.get(type);
    // log(data.toString());
    return data;
  }
}
