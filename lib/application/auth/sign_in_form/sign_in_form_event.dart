part of 'sign_in_form_bloc.dart';

@freezed
class SignInFormEvent with _$SignInFormEvent {
  const factory SignInFormEvent.emailChanged(emailStr) = EmailChanged;
  const factory SignInFormEvent.passwordChanged(passwordStr) = PasswordChanged;
  const factory SignInFormEvent.registerWithEmailAndPasswordPressed() =
      RegisterWithEmailAndPasswordPressed;
  const factory SignInFormEvent.signInWithEmailAndPasswordPressed() =
      SignInWithEmailAndPasswordPressed;
  const factory SignInFormEvent.signInWithGooglePressed() =
      SignInWithGooglePressed;
}
