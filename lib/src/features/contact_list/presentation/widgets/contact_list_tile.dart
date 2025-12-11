import 'package:flutter/material.dart';
import 'package:mobile_test/src/features/contact_list/domain/models/contact_model.dart';

class ContactListTile extends StatelessWidget {
  final ContactModel contact;
  const ContactListTile({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contact.fullName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(contact.email ?? ''),
          Text(contact.phone ?? ''),
        ],
      ),
    );
  }
}
