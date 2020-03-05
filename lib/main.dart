import 'package:crud_flutter/routes.dart' as prefix0;
import 'package:crud_flutter/src/ui/user_login.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CRUD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: prefix0.routes,
      home: UserLogin(),
    );
  }
}
