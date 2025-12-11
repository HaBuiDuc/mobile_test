import 'package:mobile_test/src/features/contact_list/data/entities/contact_entity.dart';
import 'package:mobile_test/src/features/contact_list/domain/models/contact_model.dart';

extension ContactEntityMapper on ContactEntity {
  ContactModel toModel() {
    return ContactModel(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      status: status,
    );
  }
}

extension ContactEntityListMapper on List<ContactEntity> {
  List<ContactModel> toModelList() {
    return map((entity) => entity.toModel()).toList();
  }
}
