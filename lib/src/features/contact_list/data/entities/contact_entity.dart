class ContactEntity {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? status;

  ContactEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.status,
  });

  ContactEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['status'] = status;
    return data;
  }
}
