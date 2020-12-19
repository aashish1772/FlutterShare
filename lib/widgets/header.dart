import 'package:flutter/material.dart';

AppBar header(context, {bool isTitle = false, String text = ''}) {
  return AppBar(
    centerTitle: true,
    title: Text(
      isTitle ? 'FlutterShare' : text,
      style: TextStyle(
        fontFamily: isTitle ? "Signatra" : "",
        color: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        fontSize: isTitle ? 50 : 25,
      ),
    ),
  );
}
