import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_w_firebase/data/ui/choice.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage();

  @override
  _TodoListPage createState() => _TodoListPage();
}

class _TodoListPage extends State<TodoListPage> {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static const List<Choice> choices = const <Choice>[
    const Choice(title: 'Cerrar Sesión', icon: Icons.exit_to_app, id: 1),
  ];

  void _selectChoice(Choice choice) {
    switch (choice.id) {
      case 1:
        _signOut(context);
        break;
    }
  }

  _TodoListPage() {
    //throw Exception();
  }

  signOutUser() {
    _firebaseAuth.signOut();
    Navigator.of(context).pushReplacementNamed('/login');
  }

  Future<bool> _signOut(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('¿Desea cerrar sesión?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                  signOutUser();
                },
                child: new Text('Si'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TODO List',
          overflow: TextOverflow.ellipsis,
        ),
        actions: <Widget>[
          PopupMenuButton<Choice>(
            onSelected: _selectChoice,
            itemBuilder: (BuildContext context) {
              return choices.map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        choice.icon,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        choice.title,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Hello World!'),
      ),
    );
  }
}
