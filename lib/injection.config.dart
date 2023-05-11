// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:senfin/application/auth/sign_in_form/chechauth/checkauth_bloc.dart'
    as _i6;
import 'package:senfin/application/auth/sign_in_form/sign_in_form_bloc.dart'
    as _i5;
import 'package:senfin/domain/auth/i_auth_facade.dart' as _i3;
import 'package:senfin/infrastructure/auth/Auth_Facade.dart' as _i4;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.IAuthFacade>(() => _i4.AuthFacade());
    gh.factory<_i5.SignInFormBloc>(
        () => _i5.SignInFormBloc(gh<_i3.IAuthFacade>()));
    gh.factory<_i6.CheckauthBloc>(
        () => _i6.CheckauthBloc(gh<_i3.IAuthFacade>()));
    return this;
  }
}
