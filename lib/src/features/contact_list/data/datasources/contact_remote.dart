import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_test/src/core/common/dto/custom_response.dart';
import 'package:mobile_test/src/features/contact_list/data/entities/contact_entity.dart';
import 'package:retrofit/retrofit.dart';

part 'contact_remote.g.dart';

@Singleton()
@RestApi()
abstract class ContactRemote {
  @factoryMethod
  factory ContactRemote(Dio dio, {@Named("BaseUrl") String baseUrl}) =
      _ContactRemote;

  @GET('contact/list')
  Future<CustomResponse<List<ContactEntity>?>> getContactList();
}
