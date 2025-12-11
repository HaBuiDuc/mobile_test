import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_test/src/core/common/widgets/loading_page.dart';
import 'package:mobile_test/src/core/theme/color_palette.dart';
import 'package:mobile_test/src/features/contact_list/presentation/bloc/contact_list/contact_list_bloc.dart';
import 'package:mobile_test/src/features/contact_list/presentation/widgets/contact_list_tile.dart';

class ContactListPage extends StatefulWidget {
  static Route<void> route() => MaterialPageRoute(
        builder: (_) => const ContactListPage(),
      );

  const ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<ContactListBloc>();
    if (bloc.state is ContactListInitial) {
      bloc.add(const ContactListRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<ContactListBloc, ContactListState>(
          builder: (context, state) {
            if (state is ContactListLoading) {
              return const LoadingPage();
            }
            if (state is ContactListFailure) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: ColorPalette.errorColor),
                ),
              );
            }
            if (state is ContactListLoaded) {
              if (state.contacts.isEmpty) {
                return const Center(child: Text('No contacts found'));
              }
              return ListView.separated(
                itemCount: state.contacts.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) =>
                    ContactListTile(contact: state.contacts[index]),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
