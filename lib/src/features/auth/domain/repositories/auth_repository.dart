import 'package:fpdart/fpdart.dart';
import 'package:mobile_test/src/core/errors/failure.dart';
import 'package:mobile_test/src/features/auth/domain/models/user_credential_model.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserCredentialModel>> loginWithEmailPassword(
    String email,
    String password,
  );
}
