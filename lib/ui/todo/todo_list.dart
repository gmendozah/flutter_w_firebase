import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage();

  @override
  _TodoListPage createState() => _TodoListPage();
}

class _TodoListPage extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TODO List',
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Center(
        child: Text('Hello World!'),
      ),
    );
  }
}
