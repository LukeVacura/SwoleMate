import 'package:flutter/material.dart';
import 'package:myapp/entry.dart';
import 'dart:async';
import 'database/database.dart';
import 'model/employee.dart';

final scaffoldKey = new GlobalKey<ScaffoldState>();

// Currently uses EMPLOYEELIST as that was the example tutorial I was following...
// I didn't wanna change it as I was going through the tutorial because I wasn't confident enough to lol

Future<List<Employee>> fetchEmployeesFromDatabase() async {
  var dbHelper = DBHelper();
  Future<List<Employee>> employees = dbHelper.getEmployees();
  return employees;
}

class MyEmployeeList extends StatefulWidget {
  @override
  MyEmployeeListPageState createState() => new MyEmployeeListPageState();
}

class MyEmployeeListPageState extends State<MyEmployeeList> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
       key: scaffoldKey,
      appBar: new AppBar(
        title: new Text('List'),
        actions: <Widget>[
            new IconButton(
              icon: const Icon(Icons.view_list),
              tooltip: 'Next choice',
              onPressed: () {
              navigateToEmployeeList();
              },
            ),
          ]
      ),
      body: new Container(
        padding: new EdgeInsets.all(16.0),
        child: new FutureBuilder<List<Employee>>(
          future: fetchEmployeesFromDatabase(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(snapshot.data[index].firstName,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text(snapshot.data[index].lastName,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                          new Divider()
                        ]);
                  });
            } else if (snapshot.hasError) {
              return new Text("${snapshot.error}");
            }
            return new Container(alignment: AlignmentDirectional.center,child: new CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  void navigateToEmployeeList(){
     Navigator.push(
    context,
    new MaterialPageRoute(builder: (context) => new MyHomePage()),
  );
  }
}