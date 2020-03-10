import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';

import 'package:crud_flutter/src/resources/user_reset_new_password_request.dart';
import 'package:crud_flutter/src/ui/user_login.dart';
import 'package:crud_flutter/src/utils/dialog_box.dart';
import 'package:crud_flutter/src/utils/save_loader.dart';
import 'package:crud_flutter/src/utils/validation.dart';

class UserNewPassword extends StatefulWidget {
  @override
  _UserNewPasswordState createState() => _UserNewPasswordState();
}

class _UserNewPasswordState extends State<UserNewPassword> {
  String _password;
  String _email;
  bool passwordVisible;
  bool confirmPasswordVisible;
  bool _autoValidate = false;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();

  FocusNode focusPassword;
  FocusNode focusConfirmPassword;

  @override
  void initState() {
    super.initState();
    this.setEmailAddress();
    passwordVisible = true;
    confirmPasswordVisible = true;
    focusPassword = FocusNode();
    focusConfirmPassword = FocusNode();
  }

  @override
  void dispose() {
    focusPassword.dispose();
    focusConfirmPassword.dispose();
    super.dispose();
  }

  setEmailAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _email = preferences.getString('authVerifyEmail');
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void setPassword(String value) {
    _password = value;
  }

  String validateConfirmPassword(String value) {
    final FormFieldState<String> passwordField = _passwordFieldKey.currentState;
    if (value.length == 0) {
      return 'Enter confirm password';
    } else if (passwordField.value != value) {
      return 'The passwords don\'t match';
    }
    return null;
  }

  _styleDetails() {
    return TextStyle(fontSize: 17.0);
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).padding;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var passwordText =
        "The password you are creating must be strong and must be at least 8 characters.";
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Account recovery",
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: devicePadding.top + 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/logo.png",
                      width: width / 1.8,
                      height: height / 16,
                    ),
                    SizedBox(height: 35.0),
                    Container(
                      child: Form(
                        key: _formKey,
                        autovalidate: _autoValidate,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, top: 15.0, right: 15.0),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 10.0),
                                  Text("$passwordText"),
                                  TextFormField(
                                      key: _passwordFieldKey,
                                      obscureText: passwordVisible,
                                      focusNode: focusPassword,
                                      textInputAction: TextInputAction.next,
                                      onEditingComplete: () =>
                                          _fieldFocusChange(
                                              context,
                                              focusPassword,
                                              focusConfirmPassword),
                                      decoration: InputDecoration(
                                        hintText: 'Enter password',
                                        labelText: 'Password',
                                        labelStyle: _styleDetails(),
                                        hintStyle: _styleDetails(),
                                        suffix: InkWell(
                                          child: passwordVisible
                                              ? Text("Hide")
                                              : Text("Show"),
                                          onTap: () {
                                            this.setState(() {
                                              passwordVisible =
                                                  !passwordVisible;
                                            });
                                          },
                                        ),
                                      ),
                                      keyboardType: TextInputType.text,
                                      maxLength: 16,
                                      onSaved: (String val) {
                                        this.setPassword(val);
                                      },
                                      validator: FieldValidator
                                          .validateSignupPassword),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    child: TextFormField(
                                        obscureText: confirmPasswordVisible,
                                        focusNode: focusConfirmPassword,
                                        decoration: InputDecoration(
                                          hintText: 'Re-type password',
                                          labelText: 'Confirm Password',
                                          labelStyle: _styleDetails(),
                                          hintStyle: _styleDetails(),
                                          suffix: InkWell(
                                            child: confirmPasswordVisible
                                                ? Text("Hide")
                                                : Text("Show"),
                                            onTap: () {
                                              this.setState(() {
                                                confirmPasswordVisible =
                                                    !confirmPasswordVisible;
                                              });
                                            },
                                          ),
                                        ),
                                        keyboardType: TextInputType.text,
                                        validator: validateConfirmPassword),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: RaisedButton(
                                      padding: EdgeInsets.all(10.0),
                                      elevation: 0.0,
                                      child: Text(
                                        'SUBMIT',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () async {
                                        var result = await Connectivity()
                                            .checkConnectivity();
                                        if (result == ConnectivityResult.none) {
                                          showDialogButton(
                                              context,
                                              "No Internet Access",
                                              "You are not connected to the internet.",
                                              "OK");
                                        } else if (result ==
                                                ConnectivityResult.mobile ||
                                            result == ConnectivityResult.wifi) {
                                          if (_formKey.currentState
                                              .validate()) {
                                            _formKey.currentState.save();
                                            showSavingLoader(
                                                context, true, "Saving");
                                            submitNewPasswordAPI(
                                                context, _password, _email);
                                          } else {
                                            setState(() {
                                              _autoValidate = true;
                                            });
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: new FlatButton(
                                child: new Text('Know your password? Log in'),
                                onPressed: () async {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => UserLogin()),
                                      (Route<dynamic> route) => false);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
