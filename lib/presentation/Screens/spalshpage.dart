import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senfin/application/auth/sign_in_form/chechauth/checkauth_bloc.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckauthBloc, CheckauthState>(
      listener: (context, state) {
        state.map(
            initial: (_) {},
            authenticated: (_) => Navigator.pushNamed(context, '/Home'),
            unauthenticated: (_) => Navigator.pushNamed(context, '/signin'));
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
