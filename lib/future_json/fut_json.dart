import 'package:flutter/material.dart';
import 'package:future_builder/future_json/pagina2.dart';
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
    http.Response data = await http.get("https://fortnite-api.theapinetwork.com/store/get");
    Map<String, dynamic> jsonData = json.decode(data.body);
    
    var opciones = jsonData["data"];

    List<User> nom = [];

    for (var i in opciones) {
      
      User user = User(i["item"]["name"],i["item"]["description"],i["item"]["images"]["icon"]);

      nom.add(user);

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
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("cargando...."),
                ),
              );
            }else if(snapshot.data != null){
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  var jiji = snapshot.data[index].description == null ? "no tiene poder": snapshot.data[index].description;
                  return ListTile(
                    leading: CircleAvatar(
                      //child: Text("${index+1}", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white),),
                      backgroundImage: NetworkImage(snapshot.data[index].imagen),
                    ),
                    title: Text(snapshot.data[index].name),
                    subtitle: Text(jiji),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => DetailPage(snapshot.data[index])
                      ));
                    },
                  );
                },
              );
            }
          },
        ),
        
      ),
      
    );
  }
}

class User {
  
  final String name;
  final String description;
  final String imagen;
  
  User(this.name, this.description, this.imagen);
}
