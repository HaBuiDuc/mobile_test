import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_test/src/core/common/usecases/usecase.dart';
import 'package:mobile_test/src/core/errors/failure.dart';
import 'package:mobile_test/src/features/auth/domain/models/user_credential_model.dart';
import 'package:mobile_test/src/features/auth/domain/repositories/auth_repository.dart';

@injectable
class LoginUseCase implements UseCase<UserCredentialModel, LoginParams> {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});
  @override
  Future<Either<Failure, UserCredentialModel>> call(LoginParams params) async {
    return await authRepository.loginWithEmailPassword(
      params.email,
      params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
