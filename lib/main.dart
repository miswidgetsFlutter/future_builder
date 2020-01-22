import 'package:flutter/material.dart';
import 'package:future_builder/future_json/fut_json.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: "Users"),
    );
  }
}



