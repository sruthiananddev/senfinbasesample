import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:senfin/domain/auth/auth_failure.dart';
import 'package:senfin/domain/auth/value_objects.dart';

import '../models/user/user.dart';

abstract class IAuthFacade {
  // Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
  //   @required EmailAddress emailAddress,
  //   @required Password password,
  // });
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    @required EmailAddress emailAddress,
    @required Password password,
  });
  Future<Option<User>> getSignedInUser();
  Future<void> getSignsignOut();
}
