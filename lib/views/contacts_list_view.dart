
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
        future: RandomUsersService().fetchContacts(100),
        builder: (BuildContext context, contactsSnap) {
          if (contactsSnap.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (contactsSnap.hasError) return Text(contactsSnap.error);

          return ListView.separated(
              itemBuilder: (context, i) => Text(contactsSnap.data[i].lastName),//ContactTile(contactsSnap.data[i]),
              separatorBuilder: (_, i) => Divider(),
              itemCount: contactsSnap.data.length);
        },),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Create user',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
