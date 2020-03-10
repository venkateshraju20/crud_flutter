import 'package:connectivity/connectivity.dart';
import 'package:crud_flutter/src/resources/user_login_request.dart';
import 'package:crud_flutter/src/utils/dialog_box.dart';
import 'package:crud_flutter/src/utils/save_loader.dart';
import 'package:crud_flutter/src/utils/validation.dart';
import 'package:flutter/material.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final _formKey = GlobalKey<FormState>();
  FocusNode focusEmail;
  FocusNode focusPassword;

  String _emailAddress;
  String _password;
  bool _autoValidate = false;
  bool _passwordVisible = true;

  @override
  void initState() {
    super.initState();
    focusEmail = FocusNode();
    focusPassword = FocusNode();
  }

  @override
  void dispose() {
    focusEmail.dispose();
    focusPassword.dispose();
    super.dispose();
  }

  void setEmailAddress(String value) {
    _emailAddress = value;
  }

  void setPassword(String value) {
    _password = value;
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).padding;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final emailField = TextFormField(
        focusNode: focusEmail,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onEditingComplete: () =>
            _fieldFocusChange(context, focusEmail, focusPassword),
        decoration: InputDecoration(
          labelText: "Email Address",
          hintText: "Your registered email address",
        ),
        onSaved: (String val) {
          this.setEmailAddress(val);
        },
        validator: FieldValidator.validateEmail);
    final passwordField = TextFormField(
        obscureText: _passwordVisible,
        focusNode: focusPassword,
        decoration: InputDecoration(
          hintText: "Your password",
          labelText: "Password",
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              this.setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        onSaved: (String val) {
          this.setPassword(val);
        },
        validator: FieldValidator.validatePassword);

    final loginButon = new RaisedButton(
      padding: EdgeInsets.all(10.0),
      elevation: 0.0,
      child: new Text(
        'LOG IN',
        style: new TextStyle(
          fontSize: 15.0,
        ),
      ),
      onPressed: () async {
        var connection = await Connectivity().checkConnectivity();        
        if (connection == ConnectivityResult.none) {
          showDialogButton(context, "No Internet Access",
              "You are not connected to the internet.", "OK");
        } else if (connection == ConnectivityResult.mobile ||
            connection == ConnectivityResult.wifi) {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            print(_emailAddress);
            print(_password);
            showSavingLoader(context, true, "Please wait");
            requestUserLogin(context, _emailAddress, _password);
          } else {
            setState(() {
              _autoValidate = true;
            });
          }
        }
      },
    );

    return Scaffold(
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
                    SizedBox(height: 55.0),
                    Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.contain,
                      width: width / 1.2,
                      height: height / 10,
                    ),
                    SizedBox(height: 35.0),
                    Container(
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 15.0, top: 15.0, right: 15.0),
                        child: Form(
                          key: _formKey,
                          autovalidate: _autoValidate,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              emailField,
                              Padding(
                                padding: EdgeInsets.only(bottom: 5.0),
                                child: passwordField,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: loginButon,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new FlatButton(
                                    child: new Text('Forgot login?'),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              '/forgotScreen',
                                              (Route<dynamic> route) => false);
                                    },
                                  ),
                                  new FlatButton(
                                    child: new Text("Create account"),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              '/signupScreen',
                                              (Route<dynamic> route) => false);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
