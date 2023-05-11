import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:senfin/domain/auth/i_auth_facade.dart';

part 'checkauth_event.dart';
part 'checkauth_state.dart';
part 'checkauth_bloc.freezed.dart';

@injectable
class CheckauthBloc extends Bloc<CheckauthEvent, CheckauthState> {
  IAuthFacade _authFacade;
  CheckauthBloc(this._authFacade) : super(CheckauthState.initial()) {
    on<CheckauthEvent>((event, emit) async {
      if (event is AuthCheckRequested) {
        final userOption = await _authFacade.getSignedInUser();
        emit(userOption.fold(
          () => const CheckauthState.unauthenticated(),
          (_) => const CheckauthState.authenticated(),
        ));
      } else if (event is SignedOut) {
        _authFacade.getSignsignOut();

        emit(_$Unauthenticated());
      }
    });
  }
}
