import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senfin/application/auth/sign_in_form/chechauth/checkauth_bloc.dart';
import 'package:senfin/injection.dart';
import 'package:senfin/presentation/routes/router.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<CheckauthBloc>()
            ..add(const CheckauthEvent.authCheckRequested()),
        )
      ],
      child: MaterialApp(
        title: 'Overlay Loader',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        onGenerateRoute: RouteGenerator().generateRoute,
      ),
    );
  }
}
