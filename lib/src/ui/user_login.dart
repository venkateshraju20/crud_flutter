import 'package:flutter/material.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = new TextEditingController();
  FocusNode focusEmail;
  FocusNode focusPassword;

  String _emailAddress;
  String _password;
  bool _passwordVisible;

  @override
  void initState() {
    super.initState();
  }

  void setEmailAddress(String value) {
    _emailAddress = value;
  }

  void setPassword(String value) {
    _password = value;
  }

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).padding;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final emailField = TextFormField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: "Email Address",
        hintText: "Your registered email address",
      ),
      onSaved: (String val) {
        this.setEmailAddress(val);
      },
    );
    final passwordField = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        hintText: "Your password",
        labelText: "Password",
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      onSaved: (String val) {
        this.setPassword(val);
      },
    );

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
        _formKey.currentState.save();
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
