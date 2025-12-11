// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:mobile_test/src/core/config/data/auth_interceptor.dart'
    as _i519;
import 'package:mobile_test/src/core/config/data/data_module.dart' as _i291;
import 'package:mobile_test/src/core/config/injection/register_module.dart'
    as _i683;
import 'package:mobile_test/src/features/auth/data/datasources/local/auth_local.dart'
    as _i832;
import 'package:mobile_test/src/features/auth/data/datasources/remote/auth_remote.dart'
    as _i202;
import 'package:mobile_test/src/features/auth/data/repositories/auth_repository_impl.dart'
    as _i549;
import 'package:mobile_test/src/features/auth/domain/repositories/auth_repository.dart'
    as _i684;
import 'package:mobile_test/src/features/auth/domain/usecases/login_usecase.dart'
    as _i275;
import 'package:mobile_test/src/features/auth/presentation/bloc/auth/auth_bloc.dart'
    as _i823;
import 'package:mobile_test/src/features/contact_list/data/datasources/contact_remote.dart'
    as _i111;
import 'package:mobile_test/src/features/contact_list/data/repositories/contact_repository_impl.dart'
    as _i681;
import 'package:mobile_test/src/features/contact_list/domain/repositories/contact_repository.dart'
    as _i177;
import 'package:mobile_test/src/features/contact_list/domain/usecases/get_contacts_usecase.dart'
    as _i1016;
import 'package:mobile_test/src/features/contact_list/presentation/bloc/contact_list/contact_list_bloc.dart'
    as _i299;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> $initModuleGetIt({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    final dataModule = _$DataModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.factory<String>(
      () => dataModule.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.factory<_i832.AuthLocalDataSource>(
        () => _i832.AuthLocalDataSourceImpl(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i519.AuthInterceptor>(
        () => _i519.AuthInterceptor(gh<_i832.AuthLocalDataSource>()));
    gh.singleton<_i361.Dio>(() => dataModule.dio(
          gh<String>(instanceName: 'BaseUrl'),
          gh<_i519.AuthInterceptor>(),
        ));
    gh.singleton<_i202.AuthRemote>(() => _i202.AuthRemote(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(instanceName: 'BaseUrl'),
        ));
    gh.singleton<_i111.ContactRemote>(() => _i111.ContactRemote(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(instanceName: 'BaseUrl'),
        ));
    gh.factory<_i684.AuthRepository>(() => _i549.AuthRepositoryImpl(
          authRemote: gh<_i202.AuthRemote>(),
          authLocalDataSource: gh<_i832.AuthLocalDataSource>(),
        ));
    gh.factory<_i177.ContactRepository>(() =>
        _i681.ContactRepositoryImpl(contactRemote: gh<_i111.ContactRemote>()));
    gh.factory<_i275.LoginUseCase>(
        () => _i275.LoginUseCase(authRepository: gh<_i684.AuthRepository>()));
    gh.factory<_i823.AuthBloc>(() => _i823.AuthBloc(gh<_i275.LoginUseCase>()));
    gh.factory<_i1016.GetContactsUseCase>(() => _i1016.GetContactsUseCase(
        contactRepository: gh<_i177.ContactRepository>()));
    gh.factory<_i299.ContactListBloc>(() => _i299.ContactListBloc(
        getContactsUseCase: gh<_i1016.GetContactsUseCase>()));
    return this;
  }
}

class _$RegisterModule extends _i683.RegisterModule {}

class _$DataModule extends _i291.DataModule {}
