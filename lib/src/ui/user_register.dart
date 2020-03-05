import 'package:crud_flutter/src/resources/user_register_request.dart';
import 'package:flutter/material.dart';

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

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();

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
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                        hintText: 'Your email address',
                                        labelText: 'Email Address'),
                                    keyboardType: TextInputType.emailAddress,
                                    onSaved: (String val) {
                                      this.setEmailAddress(val);
                                    },
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintText: 'Enter password',
                                      labelText: 'Password',
                                    ),
                                    keyboardType: TextInputType.text,
                                    maxLength: 16,
                                    onSaved: (String val) {
                                      this.setPassword(val);
                                    },
                                  ),
                                  TextFormField(
                                      obscureText: false,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintText: 'Re-type password',
                                        labelText: 'Confirm Password',
                                      ),
                                      keyboardType: TextInputType.text),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'Your mobile number',
                                        labelText: 'Mobile Number'),
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    onSaved: (String val) {
                                      this.setMobile(val);
                                    },
                                  ),
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: InputDecoration(
                                        hintText: 'Your first name',
                                        labelText: 'First Name'),
                                    keyboardType: TextInputType.text,
                                    onSaved: (String val) {
                                      this.setFirstName(val);
                                    },
                                  ),
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: InputDecoration(
                                        hintText: 'Your last name',
                                        labelText: 'Last Name'),
                                    keyboardType: TextInputType.text,
                                    onSaved: (String val) {
                                      this.setLastName(val);
                                    },
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: TextFormField(
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
                                    ),
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
                                        _formKey.currentState.save();
                                        print(_emailAddress);
                                        print(_password);
                                        print(_firstName);
                                        print(_lastName);
                                        print(_mobile);
                                        print(_profession);

                                        registerUserAPI(
                                            context,
                                            _emailAddress,
                                            _password,
                                            _mobile,
                                            _profession,
                                            _firstName,
                                            _lastName);
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
