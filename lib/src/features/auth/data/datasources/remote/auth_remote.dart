import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_test/src/core/common/dto/custom_response.dart';
import 'package:mobile_test/src/features/auth/data/entities/user_credential_entity.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_remote.g.dart';

@Singleton()
@RestApi()
abstract class AuthRemote {
  @factoryMethod
  factory AuthRemote(Dio dio, {@Named("BaseUrl") String baseUrl}) = _AuthRemote;

  @POST('auth/login')
  Future<CustomResponse<UserCredentialEntity?>> login(@Body() dynamic obj);
}
