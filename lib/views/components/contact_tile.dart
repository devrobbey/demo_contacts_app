
import 'package:demo_contacts_app/model/contact.dart';
import 'package:flutter/material.dart';

class ContactTile extends StatelessWidget {
  ContactTile(this._contact);

  final Contact _contact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(_contact.lastName, style: const TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 5),
          Text(_contact.firstName),
        ],
      ),
    );
  }

}