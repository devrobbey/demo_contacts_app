import 'package:demo_contacts_app/views/contacts_list_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo contacts app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContactsListView(),
    );
  }
}
