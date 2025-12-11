import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_test/src/core/common/usecases/usecase.dart';
import 'package:mobile_test/src/features/contact_list/domain/models/contact_model.dart';
import 'package:mobile_test/src/features/contact_list/domain/usecases/get_contacts_usecase.dart';

part 'contact_list_event.dart';
part 'contact_list_state.dart';

@Injectable()
class ContactListBloc extends Bloc<ContactListEvent, ContactListState> {
  final GetContactsUseCase _getContactsUseCase;

  ContactListBloc({required GetContactsUseCase getContactsUseCase})
      : _getContactsUseCase = getContactsUseCase,
        super(ContactListInitial()) {
    on<ContactListRequested>(_onContactListRequested);
  }

  Future<void> _onContactListRequested(
    ContactListRequested event,
    Emitter<ContactListState> emit,
  ) async {
    emit(ContactListLoading());
    final result = await _getContactsUseCase(NoParams());
    result.fold(
      (failure) => emit(ContactListFailure(message: failure.message)),
      (contacts) => emit(ContactListLoaded(contacts: contacts)),
    );
  }
}
