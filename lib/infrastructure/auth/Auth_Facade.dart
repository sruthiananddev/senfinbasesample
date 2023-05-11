import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:senfin/domain/auth/auth_failure.dart';
import 'package:senfin/domain/auth/i_auth_facade.dart';
import 'package:senfin/domain/auth/value_objects.dart';
import 'package:senfin/domain/models/user/user.dart';
import 'package:senfin/infrastructure/Constants.dart';

import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: IAuthFacade)
class AuthFacade implements IAuthFacade {
  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {EmailAddress? emailAddress, Password? password}) async {
    final emailAddressStr = emailAddress!.getOrCrash();
    final passwordStr = password!.getOrCrash();
    try {
      final response = await Dio(BaseOptions(queryParameters: {
        'email': emailAddressStr,
        'password': passwordStr
      }, headers: {
        'Content-Type': 'application/json',
      })).post(URLConstants.loginURL);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = response.data;
        String status = data['status'];
        if (status == "success") {
          var dataresult = data['access_token'].toString();
          SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.setString('token', dataresult);
          print("token...login...$dataresult");

          return right(unit);
        } else {
          return const Left(AuthFailure.invalidEmailAndPasswordCombination());
        }
      } else {
        return const Left(AuthFailure.invalidEmailAndPasswordCombination());
      }
    } catch (e) {
      return const Left(AuthFailure.serverError());
    }
    throw UnimplementedError();
  }

  @override
  Future<Option<User>> getSignedInUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    print("token...profile...$token");
    try {
      final response = await Dio(BaseOptions(headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      })).get(URLConstants.profile);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = response.data;
        String status = data['status'];

        var dataresult = data;
        User profiledata = User.fromJson(data);
        print("site...noti...${profiledata.redirect}");

        return Some(profiledata);
      } else {
        return none();
      }
    } catch (e) {
      print(e.toString());
      return none();
    }

    throw UnimplementedError();
  }

  @override
  Future<void> getSignsignOut() async {
    // String token = getToken().toString();
    // print("tokenlogout.....$token");

    // try {
    //   final response = await Dio(BaseOptions(headers: {
    //     'Content-Type': 'application/json',
    //     'Authorization': 'Bearer $token'
    //   })).get(URLConstants.logout);
    //   if (response.statusCode == 200 || response.statusCode == 201) {}
    //   var data = response.data;
    //   var dataresult = data['message'].toString();
    //   print("datalogoutmessage......$dataresult");
    // } catch (e) {
    //   print(e.toString());
    // }
    // throw UnimplementedError();
    deleteToken();
  }

  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var value = await pref.getString('token');

    return value.toString();
  }

  Future<void> persistToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', token);
  }

  Future<void> deleteToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('token');
    // storage.re();
  }
}
