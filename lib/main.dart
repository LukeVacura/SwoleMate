import 'package:flutter/material.dart';

void main() => runApp(GettingStarted());

class GettingStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        
      ),
    title: "SwoleMate",
    home: new Scaffold(
    appBar: new AppBar(
        title: new Text("SwoleMate", style: TextStyle(fontSize: 16.0),),
        
        centerTitle: true,
        actions: <Widget>[
           Padding(
             padding: const EdgeInsets.only(right: 16.0),
             
            ),
          ],
  elevation: 0.0,
 
),
 drawer: Drawer(
   child: new ListView(
     children: <Widget>[
       new UserAccountsDrawerHeader(
         accountName: new Text("John Smith"),
         accountEmail: new Text("JohnSmith@gmail.com"),
         decoration: new BoxDecoration(
           image: new DecorationImage(
             fit: BoxFit.fill,
             image: new NetworkImage('https://cdn-images-1.medium.com/max/1200/1*lTEHN86OS67Nf-3-jUM73w.jpeg')
           )
         )
       ),
       new ListTile(
         title: new Text("Home"),
         trailing: new Icon(Icons.home)
       ),
        new ListTile(
         title: new Text("Profile"),
         trailing: new Icon(Icons.person)
       ),
        new ListTile(
         title: new Text("Progress"),
         trailing: new Icon(Icons.pie_chart)
       )
     ]
   ),
 ),
      body: new MainContent(),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        backgroundColor: Colors.red,
        onPressed: () {
          print("Clicked");
        },
      ),
      )
    );
    

  }
}

class MainContent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return new Scaffold(
      body: Card(
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ListTile(
            title: Text('Todays Workout'),
           
          ),
          
        ],
       
      ),
     
    ),
  );
  }
}

class WorkoutList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return ListView.builder(
        itemCount: 20,
        itemBuilder: (context, RowNum) { 
          return new Excercise();
        }
      );
  }
}

class Excercise extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Center(
   child: Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const ListTile(
          leading: Icon(Icons.album),
          title: Text('Test Excercise'),
          subtitle: Text('5 reps'),
          
        ),
        
      ],
    ),
  ),
    );
  }
}


