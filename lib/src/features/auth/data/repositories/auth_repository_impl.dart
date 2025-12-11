import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_test/src/core/errors/failure.dart';
import 'package:mobile_test/src/features/auth/data/datasources/local/auth_local.dart';
import 'package:mobile_test/src/features/auth/data/datasources/remote/auth_remote.dart';
import 'package:mobile_test/src/features/auth/data/mapper/user_credential_mapper.dart';
import 'package:mobile_test/src/features/auth/data/req/login_req.dart';
import 'package:mobile_test/src/features/auth/domain/models/user_credential_model.dart';
import 'package:mobile_test/src/features/auth/domain/repositories/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemote authRemote;
  final AuthLocalDataSource authLocalDataSource;
  AuthRepositoryImpl({
    required this.authRemote,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, UserCredentialModel>> loginWithEmailPassword(
      String email, String password) async {
    final req = LoginReq(email: email, password: password);
    try {
      final res = await authRemote.login(req.toJson());
      if (res.statusCode == 200 && res.data != null) {
        final data = res.data;
        if (data!.accessToken == null && data.refreshToken == null) {
          return left(Failure(message: res.message));
        }
        await authLocalDataSource.saveTokens(
            data.accessToken!, data.refreshToken!);
        return right(res.data!.toModel());
      }
      return left(Failure(message: res.message));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
