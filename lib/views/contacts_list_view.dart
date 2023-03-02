import 'package:demo_contacts_app/views/components/contact_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/contacts_list_view_bloc.dart';

class ContactsListView extends StatelessWidget {
  const ContactsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) => ContactsListBloc()..add(LoadContactsEvent()),
        child: BlocBuilder<ContactsListBloc, ContactsListState>(builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                centerTitle: true,
                title: CupertinoTextField(
                  onChanged: (val) => context.read<ContactsListBloc>().add(SearchInContactsEvent(query: val)),
                  prefix: const Padding(
                    padding: EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
                    child: Icon(
                      Icons.search,
                      color: Color(0xffC4C6CC),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: const Color(0xffF0F1F5),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  if (state is InitialState || state is LoadingState)
                    _loadingIndicator(context)
                  else if (state is ErrorState)
                    _displayError(context)
                  else if (state is LoadedState)
                    ...state.contacts.map<ContactTile>((contact) => ContactTile(contact)).toList()
                  else if (state is FilteredState)
                    ...state.filteredContacts.map<ContactTile>((contact) => ContactTile(contact)).toList()
                ]),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _loadingIndicator(context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _displayError(context) {
    return const Text('Something went wrong fetching and deserializing data.');
  }
}
