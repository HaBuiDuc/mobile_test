part of 'contact_list_bloc.dart';

sealed class ContactListState extends Equatable {
  const ContactListState();

  @override
  List<Object?> get props => [];
}

final class ContactListInitial extends ContactListState {}

final class ContactListLoading extends ContactListState {}

final class ContactListLoaded extends ContactListState {
  final List<ContactModel> contacts;

  const ContactListLoaded({required this.contacts});

  @override
  List<Object?> get props => [contacts];
}

final class ContactListFailure extends ContactListState {
  final String message;

  const ContactListFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

