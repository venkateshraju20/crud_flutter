import 'package:flutter/material.dart';

import 'package:connectivity/connectivity.dart';
import 'package:crud_flutter/src/resources/user_register_request.dart';
import 'package:crud_flutter/src/utils/dialog_box.dart';
import 'package:crud_flutter/src/utils/save_loader.dart';
import 'package:crud_flutter/src/utils/validation.dart';

class UserRegistration extends StatefulWidget {
  @override
  _UseRegistrationState createState() => _UseRegistrationState();
}

class _UseRegistrationState extends State<UserRegistration> {
  String _emailAddress;
  String _password;
  String _mobile;
  String _profession;
  String _firstName;
  String _lastName;

  bool _autoValidate = false;
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();

  FocusNode focusEmail;
  FocusNode focusPassword;
  FocusNode focusConfirmPassword;
  FocusNode focusMobile;
  FocusNode focusFirstName;
  FocusNode focusLastName;
  FocusNode focusProfession;

  @override
  void initState() {
    super.initState();
    focusEmail = FocusNode();
    focusPassword = FocusNode();
    focusConfirmPassword = FocusNode();
    focusMobile = FocusNode();
    focusFirstName = FocusNode();
    focusLastName = FocusNode();
    focusProfession = FocusNode();
  }

  @override
  void dispose() {
    focusEmail.dispose();
    focusPassword.dispose();
    focusConfirmPassword.dispose();
    focusMobile.dispose();
    focusFirstName.dispose();
    focusLastName.dispose();
    focusProfession.dispose();
    super.dispose();
  }

  void setEmailAddress(String value) {
    _emailAddress = value;
  }

  void setPassword(String value) {
    _password = value;
  }

  void setFirstName(String value) {
    _firstName = value;
  }

  void setLastName(String value) {
    _lastName = value;
  }

  void setMobile(String value) {
    _mobile = value;
  }

  void setProfession(String value) {
    _profession = value;
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
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

  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).padding;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Create account"),
        centerTitle: true,
        elevation: 0.0,
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
                              padding: EdgeInsets.only(
                                  left: 15.0, top: 5.0, right: 15.0),
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                      focusNode: focusEmail,
                                      textInputAction: TextInputAction.next,
                                      onEditingComplete: () =>
                                          _fieldFocusChange(context, focusEmail,
                                              focusPassword),
                                      decoration: InputDecoration(
                                          hintText: 'Your email address',
                                          labelText: 'Email Address'),
                                      keyboardType: TextInputType.emailAddress,
                                      onSaved: (String val) {
                                        this.setEmailAddress(val);
                                      },
                                      validator: FieldValidator.validateEmail),
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
                                  TextFormField(
                                      obscureText: confirmPasswordVisible,
                                      focusNode: focusConfirmPassword,
                                      textInputAction: TextInputAction.next,
                                      onEditingComplete: () =>
                                          _fieldFocusChange(
                                              context,
                                              focusConfirmPassword,
                                              focusMobile),
                                      decoration: InputDecoration(
                                        hintText: 'Re-type password',
                                        labelText: 'Confirm Password',
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
                                  TextFormField(
                                      focusNode: focusMobile,
                                      textInputAction: TextInputAction.next,
                                      onEditingComplete: () =>
                                          _fieldFocusChange(context,
                                              focusMobile, focusFirstName),
                                      decoration: InputDecoration(
                                          hintText: 'Your mobile number',
                                          labelText: 'Mobile Number'),
                                      keyboardType: TextInputType.number,
                                      maxLength: 10,
                                      onSaved: (String val) {
                                        this.setMobile(val);
                                      },
                                      validator: FieldValidator.validateMobile),
                                  TextFormField(
                                      focusNode: focusFirstName,
                                      textInputAction: TextInputAction.next,
                                      onEditingComplete:
                                          () =>
                                              _fieldFocusChange(
                                                  context,
                                                  focusFirstName,
                                                  focusLastName),
                                      textCapitalization:
                                          TextCapitalization.words,
                                      decoration: InputDecoration(
                                          hintText: 'Your first name',
                                          labelText: 'First Name'),
                                      keyboardType: TextInputType.text,
                                      onSaved: (String val) {
                                        this.setFirstName(val);
                                      },
                                      validator:
                                          FieldValidator.validateFirstName),
                                  TextFormField(
                                      focusNode: focusLastName,
                                      textInputAction: TextInputAction.next,
                                      onEditingComplete: () =>
                                          _fieldFocusChange(context,
                                              focusLastName, focusProfession),
                                      textCapitalization:
                                          TextCapitalization.words,
                                      decoration: InputDecoration(
                                          hintText: 'Your last name',
                                          labelText: 'Last Name'),
                                      keyboardType: TextInputType.text,
                                      onSaved: (String val) {
                                        this.setLastName(val);
                                      },
                                      validator:
                                          FieldValidator.validateLastName),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: TextFormField(
                                        focusNode: focusProfession,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                            hintText: 'Your profession',
                                            labelText: 'Profession'),
                                        keyboardType: TextInputType.multiline,
                                        onSaved: (String val) {
                                          this.setProfession(val);
                                        },
                                        validator:
                                            FieldValidator.validateProfession),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: RaisedButton(
                                      padding: EdgeInsets.all(10.0),
                                      elevation: 0.0,
                                      child: Text(
                                        'REGISTER',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      onPressed: () async {
                                        var connection = await Connectivity()
                                            .checkConnectivity();
                                        if (connection ==
                                            ConnectivityResult.none) {
                                          showDialogButton(
                                              context,
                                              "No Internet Access",
                                              "You are not connected to the internet.",
                                              "OK");
                                        } else if (connection ==
                                                ConnectivityResult.mobile ||
                                            connection ==
                                                ConnectivityResult.wifi) {
                                          if (_formKey.currentState
                                              .validate()) {
                                            _formKey.currentState.save();
                                            showSavingLoader(
                                                context, true, "Please wait");
                                            registerUserAPI(
                                                context,
                                                _emailAddress,
                                                _password,
                                                _mobile,
                                                _profession,
                                                _firstName,
                                                _lastName);
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
                            FlatButton(
                              child: Text('Log in instead'),
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/loginScreen',
                                    (Route<dynamic> route) => false);
                              },
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
