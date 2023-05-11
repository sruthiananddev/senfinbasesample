import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senfin/application/auth/sign_in_form/chechauth/checkauth_bloc.dart';
import 'package:senfin/application/auth/sign_in_form/sign_in_form_bloc.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption?.fold(
          () {},
          (either) => either.fold(
            (failure) {
              // FlushbarHelper.createError(
              //   message: failure.map(
              //     cancelledByUser: (_) => 'Cancelled',
              //     serverError: (_) => 'Server error',
              //     emailAlreadyInUse: (_) => 'Email already in use',
              //     invalidEmailAndPasswordCombination: (_) =>
              //         'Invalid email and password combination',
              //   ),
              // ).show(context);
            },
            (_) {
              Navigator.pushNamed(context, '/Home');
              // context
              //     .bloc<CheckauthBloc>()
              //     .add(const CheckauthEvent.authCheckRequested());
              BlocProvider.of<CheckauthBloc>(context).add(
                CheckauthEvent.authCheckRequested(),
              );
            },
          ),
        );
      },
      builder: (context, state) {
        return Form(
          autovalidateMode: AutovalidateMode.always,
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              const Text(
                '📝',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 130),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                ),
                autocorrect: false,
                onChanged: (value) => BlocProvider.of<SignInFormBloc>(context)
                    .add(SignInFormEvent.emailChanged(value)),
                validator: (_) => BlocProvider.of<SignInFormBloc>(context)
                    .state
                    .emailAddress!
                    .value
                    .fold(
                      (f) => f.maybeMap(
                        invalidEmail: (_) => 'Invalid Email',
                        orElse: () => null,
                      ),
                      (_) => null,
                    ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Password',
                ),
                autocorrect: false,
                obscureText: true,
                onChanged: (value) => BlocProvider.of<SignInFormBloc>(context)
                    .add(SignInFormEvent.passwordChanged(value)),
                validator: (_) => BlocProvider.of<SignInFormBloc>(context)
                    .state
                    .password!
                    .value
                    .fold(
                      (f) => f.maybeMap(
                        shortPassword: (_) => 'Short Password',
                        orElse: () => null,
                      ),
                      (_) => null,
                    ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<SignInFormBloc>(context).add(
                          const SignInFormEvent
                              .signInWithEmailAndPasswordPressed(),
                        );
                      },
                      child: const Text('SIGN IN'),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<SignInFormBloc>(context).add(
                          const SignInFormEvent
                              .registerWithEmailAndPasswordPressed(),
                        );
                      },
                      child: const Text('REGISTER'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
