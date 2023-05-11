import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senfin/application/auth/sign_in_form/sign_in_form_bloc.dart';

import '../../injection.dart';
import '../widgets/signinform.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: BlocProvider(
        create: (context) => getIt<SignInFormBloc>(),
        child: SignInForm(),
      ),
    );
  }
}
