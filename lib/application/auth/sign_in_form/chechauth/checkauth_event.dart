part of 'checkauth_bloc.dart';

@freezed
class CheckauthEvent with _$CheckauthEvent {
  const factory CheckauthEvent.authCheckRequested() = AuthCheckRequested;
  const factory CheckauthEvent.signedOut() = SignedOut;
}
