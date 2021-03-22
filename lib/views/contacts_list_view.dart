
import 'package:demo_contacts_app/model/contact.dart';
import 'package:demo_contacts_app/service/randomuser_service.dart';
import 'package:demo_contacts_app/views/components/contact_tile.dart';
import 'package:flutter/cupertino.dart';
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

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                centerTitle: true,
                title: CupertinoTextField(
                  prefix: Padding(
                    padding:
                    const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
                    child: Icon(
                      Icons.search,
                      color: Color(0xffC4C6CC),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Color(0xffF0F1F5),
                  ),
                ),
              ),
              SliverFixedExtentList(
                itemExtent: 40.0,
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    return ContactTile(contactsSnap.data[i]);
                  }
                ),
              )
            ],
          );
        },),
    );
  }

  Widget _loadingIndicator(context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
