import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_test/src/features/auth/domain/models/user_credential_model.dart';
import 'package:mobile_test/src/features/auth/domain/usecases/login_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@Injectable()
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  AuthBloc(LoginUseCase loginUseCase)
      : _loginUseCase = loginUseCase,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<AuthLoginEvent>(_onLogin);
    on<AuthInitialEvent>(
      (event, emit) => emit(
        AuthInitial(),
      ),
    );
  }

  void _onLogin(AuthLoginEvent event, Emitter emit) async {
    final res = await _loginUseCase(
        LoginParams(email: event.email, password: event.password));
    res.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) => emit(AuthSuccess(userCredential: r)),
    );
  }
}
