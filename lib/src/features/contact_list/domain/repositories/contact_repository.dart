import 'package:fpdart/fpdart.dart';
import 'package:mobile_test/src/core/errors/failure.dart';
import 'package:mobile_test/src/features/contact_list/domain/models/contact_model.dart';

abstract interface class ContactRepository {
  Future<Either<Failure, List<ContactModel>>> getContactList();
}

