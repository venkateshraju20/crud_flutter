import 'package:flutter/material.dart';

import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:crud_flutter/src/resources/user_reset_find_request.dart';
import 'package:crud_flutter/src/ui/user_login.dart';
import 'package:crud_flutter/src/utils/dialog_box.dart';
import 'package:crud_flutter/src/utils/save_loader.dart';
import 'package:crud_flutter/src/utils/validation.dart';

class UserForgot extends StatefulWidget {
  @override
  _UserForgotState createState() => _UserForgotState();
}

class _UserForgotState extends State<UserForgot> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String _emailAddress;
  bool _autoValidate = false;

  @override
  void initState() {
    super.initState();
    this.clearPreferences();
  }

  clearPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  void setEmailAddress(String value) {
    _emailAddress = value;
  }

  _showContent(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message, style: TextStyle(fontSize: 16)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).padding;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
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
                                  Text(
                                      "Please enter your email address below, we will guide you how to set a new password for your account."),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    child: new TextFormField(
                                        decoration: InputDecoration(
                                            labelText: "Email Address",
                                            hintText:
                                                "Your registered email address"),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onSaved: (String val) {
                                          this.setEmailAddress(val);
                                        },
                                        validator:
                                            FieldValidator.validateEmail),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: new RaisedButton(
                                      padding: EdgeInsets.all(10.0),
                                      elevation: 0.0,
                                      child: new Text(
                                        'CONTINUE',
                                        style: new TextStyle(
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
                                                context, true, "Please wait");
                                            var emailExists =
                                                await requestForgotAPI(
                                                    context, _emailAddress);
                                            if (emailExists) {
                                              showSavingLoader(context, false,
                                                  "Please wait");
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      '/resetNewPasswordScreen');
                                            } else {
                                              showSavingLoader(context, false,
                                                  "Please wait");
                                              _showContent(
                                                  "Email address doesn't exist");
                                            }
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
                            new FlatButton(
                              child: new Text('Know your password? Log in'),
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => UserLogin()),
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
