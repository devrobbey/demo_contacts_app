
import 'package:demo_contacts_app/model/contact.dart';
import 'package:demo_contacts_app/service/randomuser_service.dart';
import 'package:demo_contacts_app/views/components/contact_tile.dart';
import 'package:flutter/material.dart';

class ContactsListView extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: FutureBuilder<List<Contact>>(
        future: RandomUsersService().fetchContactsSorted(100),
        builder: (BuildContext context, contactsSnap) {
          if (contactsSnap.connectionState == ConnectionState.waiting) {
            return _loadingIndicator(context);
          } else if (contactsSnap.hasError) return Text(contactsSnap.error.toString());

          return ListView.separated(
              itemBuilder: (context, i) => ContactTile(contactsSnap.data[i]),
              separatorBuilder: (_, i) => Divider(),
              itemCount: contactsSnap.data.length);
        },),
    );
  }

  Widget _loadingIndicator(context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
