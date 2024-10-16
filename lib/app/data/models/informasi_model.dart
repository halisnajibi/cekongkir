class Informasi {
  OriginDetails? originDetails;
  OriginDetails? destinationDetails;

  Informasi({this.originDetails, this.destinationDetails});

  Informasi.fromJson(Map<String, dynamic> json) {
    originDetails = json['origin_details'] != null
        ? OriginDetails?.fromJson(json['origin_details'])
        : null;
    destinationDetails = json['destination_details'] != null
        ? OriginDetails?.fromJson(json['destination_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (originDetails != null) {
      data['origin_details'] = originDetails?.toJson();
    }
    if (destinationDetails != null) {
      data['destination_details'] = destinationDetails?.toJson();
    }
    return data;
  }
}

class OriginDetails {
  String? cityId;
  String? provinceId;
  String? province;
  String? type;
  String? cityName;
  String? postalCode;

  OriginDetails(
      {this.cityId,
      this.provinceId,
      this.province,
      this.type,
      this.cityName,
      this.postalCode});

  OriginDetails.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    provinceId = json['province_id'];
    province = json['province'];
    type = json['type'];
    cityName = json['city_name'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['city_id'] = cityId;
    data['province_id'] = provinceId;
    data['province'] = province;
    data['type'] = type;
    data['city_name'] = cityName;
    data['postal_code'] = postalCode;
    return data;
  }
}
