import 'package:flutter/material.dart';
import 'package:myapp/entry.dart';
import 'package:myapp/exerciselist.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'SQFLite DataBase Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        
      ),
      home: new HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Title"),
      ),
      body: new Center(child: new Text("Home Page")),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () {
          print("Clicked");
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new MyEmployeeList()),
          );
        },
      ),
    );
  }
}
