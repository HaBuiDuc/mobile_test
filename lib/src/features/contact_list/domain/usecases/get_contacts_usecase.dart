import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_test/src/core/common/usecases/usecase.dart';
import 'package:mobile_test/src/core/errors/failure.dart';
import 'package:mobile_test/src/features/contact_list/domain/models/contact_model.dart';
import 'package:mobile_test/src/features/contact_list/domain/repositories/contact_repository.dart';

@Injectable()
class GetContactsUseCase implements UseCase<List<ContactModel>, NoParams> {
  final ContactRepository _contactRepository;

  GetContactsUseCase({required ContactRepository contactRepository})
      : _contactRepository = contactRepository;

  @override
  Future<Either<Failure, List<ContactModel>>> call(NoParams params) {
    return _contactRepository.getContactList();
  }
}
