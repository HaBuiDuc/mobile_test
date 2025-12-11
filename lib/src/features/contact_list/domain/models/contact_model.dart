class ContactModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? status;

  ContactModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.status,
  });

  String get fullName {
    final first = firstName ?? '';
    final last = lastName ?? '';

    if (first.isEmpty && last.isEmpty) return 'No Name';
    if (first.isEmpty) return last;
    if (last.isEmpty) return first;

    return '$first $last';
  }
}
