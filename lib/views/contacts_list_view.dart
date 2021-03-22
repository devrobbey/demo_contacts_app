
import 'package:demo_contacts_app/views/components/contact_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/contacts_list_view_bloc.dart';

class ContactsListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) => ContactsListViewBloc()..add(StartLoadingEvent()),
        child: BlocBuilder<ContactsListViewBloc, ContactsListViewState>(
          builder: (context, state) {
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
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      if (state.viewStatus == ViewStatus.LOADING) _loadingIndicator(context),
                      if (state.viewStatus == ViewStatus.ERROR) _displayError(context),
                      ... state.contacts.map<ContactTile>((contact) => ContactTile(contact)).toList()
                    ]
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }

  Widget _loadingIndicator(context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _displayError(context) {
    return Text('Something went wrong fetching and deserializing data.');
  }
}
