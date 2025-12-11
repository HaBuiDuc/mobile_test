import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_test/src/core/errors/failure.dart';
import 'package:mobile_test/src/core/errors/server_exception.dart';
import 'package:mobile_test/src/features/contact_list/data/datasources/contact_remote.dart';
import 'package:mobile_test/src/features/contact_list/data/mappers/contact_mapper.dart';
import 'package:mobile_test/src/features/contact_list/domain/models/contact_model.dart';
import 'package:mobile_test/src/features/contact_list/domain/repositories/contact_repository.dart';

@Injectable(as: ContactRepository)
class ContactRepositoryImpl implements ContactRepository {
  final ContactRemote contactRemote;
  ContactRepositoryImpl({required this.contactRemote});

  @override
  Future<Either<Failure, List<ContactModel>>> getContactList() async {
    try {
      final res = await contactRemote.getContactList();
      if (res.statusCode == 200 && res.data != null) {
        return right(res.data!.toModelList());
      }
      return left(Failure(message: res.message));
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
