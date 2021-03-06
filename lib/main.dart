import 'package:flutter/material.dart';
import 'package:fluttershare/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FlutterShare",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal, accentColor: Colors.purple),
      home: Home(),
    );
  }
}
