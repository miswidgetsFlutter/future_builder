import 'package:flutter/material.dart';


import 'fut_json.dart';

class DetailPage extends StatelessWidget {

  final User user;

  DetailPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(user.name),
        ),
        body: Center(
          child: Image.network(user.imagen),
        ),
    );
  }
}
