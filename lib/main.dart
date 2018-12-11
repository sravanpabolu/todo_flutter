import 'package:flutter/material.dart';
import 'package:todo_app/utils/dbhelper.dart';
import 'package:todo_app/model/todomodel.dart';
import 'package:todo_app/screens/todolist.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //DB
    List<Todo> todos = List<Todo>();
    DBHelper dbhelper = DBHelper();
    dbhelper.initializeDB().then( (result) => dbhelper.getTodos().then( (result) => todos = result));

    DateTime today = DateTime.now();
    Todo todoActivity = Todo("Buy Orange", 1, today.toString(), "make sure they are good");
    dbhelper.insertTodo(todoActivity);

    //return UI
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todos',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'Todos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TodoList(),
    );
  }
}
