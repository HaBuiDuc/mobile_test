import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_test/src/core/common/widgets/loading_page.dart';
import 'package:mobile_test/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:mobile_test/src/features/auth/presentation/widgets/auth_button.dart';
import 'package:mobile_test/src/features/auth/presentation/widgets/auth_field.dart';
import 'package:mobile_test/src/features/contact_list/presentation/page/contact_list_page.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
              context.read<AuthBloc>().add(AuthInitialEvent());
            }
            if (state is AuthSuccess) {
              context.read<AuthBloc>().add(AuthInitialEvent());
              Navigator.push(context, ContactListPage.route());
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const LoadingPage();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  child: Column(
                    children: [
                      AuthField(
                        controller: emailController,
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AuthField(
                        controller: passwordController,
                        hintText: 'Password',
                        isObscured: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                AuthButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          AuthLoginEvent(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                  },
                  buttonText: 'Login',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
