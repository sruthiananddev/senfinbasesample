import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:senfin/domain/auth/i_auth_facade.dart';

import '../../../domain/auth/auth_failure.dart';
import '../../../domain/auth/value_objects.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';
part 'sign_in_form_bloc.freezed.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  IAuthFacade _authFacade;
  SignInFormBloc(this._authFacade) : super(SignInFormState.initial()) {
    on<SignInFormEvent>((event, emit) async {
      if (event is _$EmailChanged) {
        emit(state.copyWith(
            emailAddress: EmailAddress(event.emailStr),
            authFailureOrSuccessOption: none()));
      } else if (event is _$PasswordChanged) {
        emit(state.copyWith(
            password: Password(event.passwordStr),
            authFailureOrSuccessOption: none()));
      } else if (event is _$SignInWithEmailAndPasswordPressed) {
        Either<AuthFailure, Unit> failureOrSuccess;
        if (state.emailAddress!.isValid() && state.password!.isValid()) {
          emit(state.copyWith(
              isSubmitting: true, authFailureOrSuccessOption: none()));
          failureOrSuccess = await _authFacade.signInWithEmailAndPassword(
              emailAddress: state.emailAddress!, password: state.password!);
          emit(state.copyWith(
              isSubmitting: false,
              authFailureOrSuccessOption: some(failureOrSuccess)));
        }
        emit(state.copyWith(
            isSubmitting: false,
            showErrorMessages: true,
            authFailureOrSuccessOption: none()));
      }
    });
  }
}
