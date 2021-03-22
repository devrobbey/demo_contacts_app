
import 'package:demo_contacts_app/model/contact.dart';
import 'package:demo_contacts_app/service/randomuser_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ContactsListViewBloc extends Bloc<ContactsListViewEvent, ContactsListViewState> {
  ContactsListViewBloc() : super(ContactsListViewState(viewStatus: ViewStatus.LOADING, filteredContacts: []));

  List<Contact> _allContacts;
  
  @override
  Stream<ContactsListViewState> mapEventToState(ContactsListViewEvent event) async* {

    if (event is StartLoadingEvent) {
      yield state.copyWith(viewStatus: ViewStatus.LOADING);

      try {
        _allContacts = await RandomUsersService().fetchContactsSorted(100);
        yield state.copyWith(filteredContacts: _allContacts, viewStatus: ViewStatus.VALID);
      } catch (e, stacktrace) {
        print(e.toString() + stacktrace.toString());
        yield state.copyWith(viewStatus: ViewStatus.ERROR);
      }


    } else if (event is QueryStringChangedEvent) {

      //filter contacts
      var filteredContacts = <Contact>[];
      _allContacts.forEach((contact) {
        if (contact.hasTextMatch(event.queryString)) filteredContacts.add(contact);
      });

      yield state.copyWith(filteredContacts: filteredContacts);
    }
  }
}


///// BLoC EVENTS

abstract class ContactsListViewEvent {
  const ContactsListViewEvent();
}

class StartLoadingEvent extends ContactsListViewEvent {
  const StartLoadingEvent();
}

class QueryStringChangedEvent extends ContactsListViewEvent {
  const QueryStringChangedEvent(this.queryString);
  final String queryString;
}


////// BLoC STATE

enum ViewStatus {LOADING, VALID, ERROR}

class ContactsListViewState {
  ContactsListViewState({
    this.viewStatus,
    this.filteredContacts,
  });

  final ViewStatus viewStatus;
  final List<Contact> filteredContacts;

  ContactsListViewState copyWith({
    ViewStatus viewStatus,
    List<Contact> filteredContacts,
  }) {
    return ContactsListViewState(
      viewStatus: viewStatus ?? this.viewStatus,
      filteredContacts: filteredContacts ?? this.filteredContacts,
    );
  }
}
