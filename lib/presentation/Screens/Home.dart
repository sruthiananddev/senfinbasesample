import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senfin/application/auth/sign_in_form/chechauth/checkauth_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CheckauthBloc, CheckauthState>(
          listener: (context, state) {
            state.maybeMap(
              unauthenticated: (_) => Navigator.pushNamed(context, '/signin'),
              orElse: () {
                Navigator.pushNamed(context, '/Home');
              },
            );
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
          leading: IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<CheckauthBloc>(context)
                  .add(const CheckauthEvent.signedOut());
            },
          ),
        ),
      ),
    );
  }
}
