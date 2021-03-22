

import 'package:latlong/latlong.dart';

class Address {
  Address({
    this.street,
    this.city,
    this.state,
    this.country,
    this.postCode,
    this.latLng,
  });

  final Street street;
  final String city;
  final String state;
  final String country;
  final int postCode;
  final LatLng latLng;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: Street.fromJson(json['street']),
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postCode: json['postCode'] as int,
      latLng: LatLng(
          double.parse(json['coordinates']['latitude']),
          double.parse(json['coordinates']['longitude'])),
    );
  }

}


class Street {
  Street({
    this.number,
    this.name,
  });

  final int number;
  final String name;

  factory Street.fromJson(Map<String, dynamic> json) {
    return Street(
      number: json['number'],
      name: json['name'],
    );
  }

}
