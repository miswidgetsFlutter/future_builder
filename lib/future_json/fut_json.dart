import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int inc = 1;

  Future<dynamic> _getItem() async {
    var data = await http.get("https://fortnite-api.theapinetwork.com/store/get");
    Map<String, dynamic> jsonData = json.decode(data.body);
    
    var opciones = jsonData["data"];

    String nombre = opciones[8]["item"]["name"];

    return nombre;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getItem(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            return Center(
              child: Text(snapshot.data),
            );
          },
        ),
        
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.description),
        onPressed: (){
          _getItem();
        },
      ),
    );
  }
}

class Item {
  final String name;
  final String description;
  final String type;
  final String legendary;

  Item(this.name, this.description, this.type, this.legendary);
}
