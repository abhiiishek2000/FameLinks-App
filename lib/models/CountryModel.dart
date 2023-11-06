class CountryModel {
  CountryResult? result;
  String? message;
  bool? success;

  CountryModel({this.result, this.message, this.success});

  CountryModel.fromJson(Map<dynamic, dynamic> json) {
    result =
    json['result'] != null ? new CountryResult.fromJson(json['result']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class CountryResult {
  List<Country>? data;

  CountryResult({this.data});

  CountryResult.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Country>[];
      json['data'].forEach((v) {
        data!.add(new Country.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Country {
  String? country;
  String? code;

  Country({this.country, this.code});

  Country.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['code'] = this.code;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if(other is Country){
      return other.code == code;
    }else{
      return false;
    }
  }
}

