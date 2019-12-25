import 'package:flutter/material.dart';
import 'package:ce_admin/app.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MemberPage(title: 'Christ Embassy Admin'),
    );
  }
}
