import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_test/src/core/config/injection/injection.dart';
import 'package:mobile_test/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:mobile_test/src/features/auth/presentation/page/login_page.dart';
import 'package:mobile_test/src/features/contact_list/presentation/bloc/contact_list/contact_list_bloc.dart';

final serviceLocator = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dataConfigureInjection(serviceLocator);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider<ContactListBloc>(
          create: (_) => serviceLocator<ContactListBloc>(),
        ),
      ],
      child: const MaterialApp(
        home: LoginPage(),
      ),
    ),
  );
}
