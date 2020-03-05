import 'package:flutter/material.dart';

class UserForgot extends StatefulWidget {
  @override
  _UserForgotState createState() => _UserForgotState();
}

class _UserForgotState extends State<UserForgot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account recovery"),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text("forgot"),
        ),
      ),
    );
  }
}
