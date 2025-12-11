part of 'contact_list_bloc.dart';

sealed class ContactListEvent extends Equatable {
  const ContactListEvent();

  @override
  List<Object?> get props => [];
}

class ContactListRequested extends ContactListEvent {
  const ContactListRequested();
}

