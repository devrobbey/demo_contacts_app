
import 'package:demo_contacts_app/model/contact.dart';
import 'package:demo_contacts_app/service/randomuser_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ContactsListViewBloc extends Bloc<ContactsListViewEvent, ContactsListViewState> {
  ContactsListViewBloc() : super(ContactsListViewState(viewStatus: ViewStatus.LOADING, contacts: []));

  @override
  Stream<ContactsListViewState> mapEventToState(ContactsListViewEvent event) async* {

    if (event is StartLoadingEvent) {
      yield state.copyWith(viewStatus: ViewStatus.LOADING);

      try {
        var contacts = await RandomUsersService().fetchContactsSorted(100);
        yield state.copyWith(contacts: contacts, viewStatus: ViewStatus.VALID);
      } catch (e, stacktrace) {
        print(e.toString() + stacktrace.toString());
        yield state.copyWith(viewStatus: ViewStatus.ERROR);
      }


    } else if (event is QueryStringChangedEvent) {

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
    this.contacts,
  });

  final ViewStatus viewStatus;
  final List<Contact> contacts;

  ContactsListViewState copyWith({
    ViewStatus viewStatus,
    List<Contact> contacts,
  }) {
    return ContactsListViewState(
      viewStatus: viewStatus ?? this.viewStatus,
      contacts: contacts ?? this.contacts,
    );
  }
}
