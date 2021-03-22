
import 'package:demo_contacts_app/model/contact.dart';
import 'package:flutter/material.dart';

import '../contact_detail_view.dart';

class ContactTile extends StatelessWidget {
  ContactTile(this._contact);

  final Contact _contact;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ContactDetailView(_contact))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(_contact.firstName),
            SizedBox(width: 5),
            Text(_contact.lastName, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

}