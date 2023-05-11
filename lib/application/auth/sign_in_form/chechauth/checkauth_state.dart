part of 'checkauth_bloc.dart';

@freezed
class CheckauthState with _$CheckauthState {
  const factory CheckauthState.initial() = Initial;
  const factory CheckauthState.authenticated() = Authenticated;
  const factory CheckauthState.unauthenticated() = Unauthenticated;
}
