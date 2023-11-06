class LocationResponse {
  List<AddressLocation>? result;
  String? message;
  bool? success;

  LocationResponse({this.result, this.message, this.success});

  LocationResponse.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <AddressLocation>[];
      json['result'].forEach((v) {
        result!.add(new AddressLocation.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class AddressLocation {
  String? state;
  String? district;
  String? country;
  String? continent;
  bool? isSelected;

  AddressLocation(
      {this.state,
        this.district,
        this.country,
        this.continent,
        });

  AddressLocation.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    district = json['district'];
    country = json['country'];
    continent = json['continent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['continent'] = this.continent;
    return data;
  }
}
