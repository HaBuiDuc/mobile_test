
// Define an extension on the Entity class
import 'package:mobile_test/src/features/auth/data/entities/user_credential_entity.dart';
import 'package:mobile_test/src/features/auth/domain/models/user_credential_model.dart';

extension UserCredentialEntityMapper on UserCredentialEntity {
  UserCredentialModel toModel() {
    return UserCredentialModel(
      accessToken: accessToken ?? '',     
      refreshToken: refreshToken ?? '', 
    );
  }
}