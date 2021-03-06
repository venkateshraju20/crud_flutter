import 'package:crud_flutter/src/ui/user_forgot.dart';
import 'package:crud_flutter/src/ui/user_home.dart';
import 'package:crud_flutter/src/ui/user_login.dart';
import 'package:crud_flutter/src/ui/user_new_password.dart';
import 'package:crud_flutter/src/ui/user_register.dart';
import 'package:flutter/material.dart';

final routes = <String, WidgetBuilder>{
  "/loginScreen": (context) => UserLogin(),
  "/signupScreen": (context) => UserRegistration(),
  "/forgotScreen": (context) => UserForgot(),
  "/resetNewPasswordScreen": (context) => UserNewPassword(),
  "/homeScreen": (context) => UserHome(),
};
