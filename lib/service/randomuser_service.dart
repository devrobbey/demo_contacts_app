import 'dart:convert';

import 'package:demo_contacts_app/model/contact.dart';
import 'package:http/http.dart';

class RandomUsersService {
  // singleton
  static final RandomUsersService _instance = RandomUsersService._();
  factory RandomUsersService() => _instance;
  RandomUsersService._();


  Future<List<Contact>> fetchContacts(int count) async {
    try {

      var response = await get(Uri.parse('https://randomuser.me/api?results='+count.toString()));

      final parsed = jsonDecode(response.body)['results'].cast<Map<String, dynamic>>();

      return parsed.map<Contact>((json) => Contact.fromJson(json)).toList();
    } catch (e, stacktrace) {
      print(e.toString());
      return Future.error('Error while loading and deserializing contacts');
    }
  }

}
