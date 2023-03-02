import 'dart:developer';

import 'package:demo_contacts_app/model/contact.dart';
import 'package:demo_contacts_app/service/randomuser_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsListBloc extends Bloc<ContactsListEvent, ContactsListState> {
  ContactsListBloc() : super(InitialState()) {
    on<LoadContactsEvent>(_onStartLoading);
    on<SearchInContactsEvent>(_onFilterContacts);
  }

  List<Contact> allContactsCached = [];

  void _onStartLoading(LoadContactsEvent event, Emitter<ContactsListState> emit) async {
    emit(LoadingState());

    try {
      allContactsCached = await RandomUsersService().fetchContactsSorted(100);
      emit(LoadedState(contacts: allContactsCached));
    } catch (e, stacktrace) {
      log(e.toString() + stacktrace.toString());
      emit(ErrorState());
    }
  }

  void _onFilterContacts(SearchInContactsEvent event, Emitter<ContactsListState> emit) async {
    //filter contacts
    var filteredContacts = allContactsCached
        .where((c) => (c.firstName+c.lastName).toLowerCase().contains(event.query))
        .toList();


    emit( FilteredState(filteredContacts: filteredContacts));
  }
}

///// BLoC EVENTS

abstract class ContactsListEvent {}

class LoadContactsEvent extends ContactsListEvent {}

class SearchInContactsEvent extends ContactsListEvent {
  final String query;

  SearchInContactsEvent({required this.query});
}

////// BLoC STATE

abstract class ContactsListState {}

class InitialState extends ContactsListState {}

class LoadingState extends ContactsListState {}

class LoadedState extends ContactsListState {
  final List<Contact> contacts;

  LoadedState({required this.contacts});
}

class ErrorState extends ContactsListState {}

class FilteredState extends ContactsListState {
  final List<Contact> filteredContacts;

  FilteredState({required this.filteredContacts});
}
