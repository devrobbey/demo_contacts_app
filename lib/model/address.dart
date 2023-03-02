
import 'package:latlong2/latlong.dart';

class Address {
  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.latLng,
  });

  final Street street;
  final String city;
  final String state;
  final String country;
  final LatLng latLng;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: Street.fromJson(json['street']),
      city: json['city'],
      state: json['state'],
      country: json['country'],
      latLng: LatLng(
          double.parse(json['coordinates']['latitude']),
          double.parse(json['coordinates']['longitude'])),
    );
  }

}


class Street {
  Street({
    required this.number,
    required this.name,
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
