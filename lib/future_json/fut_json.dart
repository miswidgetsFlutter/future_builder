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

  Future<dynamic> _getItem() async {
    var data = await http.get("https://fortnite-api.theapinetwork.com/store/get");
    Map<String, dynamic> jsonData = json.decode(data.body);
    
    var opciones = jsonData["data"];

    String nombre = opciones[8]["item"]["name"];

    List<String> nom = [];

    for (var i in opciones) {
      
      nom.add(i["item"]["name"]);
    }

    return nom;
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
            print(snapshot.data);
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("cargando...."),
                ),
              );
            }else{
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.desktop_mac),
                    ),
                    title: Text(snapshot.data[index]),
                    subtitle: Text("del fornais"),
                    onTap: (){},
                  );
                },
              );
            }
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
