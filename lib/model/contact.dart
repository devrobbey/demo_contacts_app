
import 'address.dart';


class Contact {
  Contact({
    String firstName,
    String lastName,
    String phone,
    String cell,
    String imageUrl,
    String mail,
    Address address,})
      : _firstName = firstName,
        _lastName = lastName,
        _phone = phone,
        _cell = cell,
        _imageUrl = imageUrl,
        _mail = mail,
        _address = address;

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      firstName: json['name']['first'],
      lastName: json['name']['last'],
      phone: json['phone'],
      cell: json['cell'],
      imageUrl: json['picture']['large'],
      mail: json['email'],
      address: Address.fromJson(json['location']),
    );
  }

  String _firstName;
  String _lastName;
  String _phone;
  String _cell;
  String _imageUrl;
  String _mail;
  Address _address;

  get firstName => _firstName;
  get lastName => _lastName;
  get phone => _phone;
  get cell => _cell;
  get imageUrl => _imageUrl;
  get mail => _mail;
  Address get address => _address;

  bool hasTextMatch(String textQuery) {
    return _lastName.toLowerCase().contains(textQuery.toLowerCase())
        || _firstName.toLowerCase().contains(textQuery.toLowerCase());
  }

}