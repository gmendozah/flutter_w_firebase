import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_w_firebase/services/auth_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  final AuthService _authService = AuthService();
  TextEditingController _usernameCtrl, _passwordCtrl;
  int _counter = 0;
  String _userInfo = '';

  @override
  void initState() {
    super.initState();
    _usernameCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
    _usernameCtrl.text = 'mygvs.mh@gmail.com';
    _passwordCtrl.text = 'contrasena';
  }

  @override
  void dispose() {
    super.dispose();
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  authenticate() async {
    FirebaseUser user = await _authService.signInWithEmailAndPassword(
        _usernameCtrl.text, _passwordCtrl.text);
    setState(() {
      _userInfo = user.uid;
    });
    print('displayName: ${user.displayName}');
    print('phoneNumber: ${user.phoneNumber}');
    print('email: ${user.email}');
    print('uid: ${user.uid}');
    print('photoUrl: ${user.photoUrl}');
    print('providerId: ${user.providerId}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _userInfo,
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
              ),
              TextField(
                controller: _usernameCtrl,
                decoration: InputDecoration(
                    labelText: 'EMAIL',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _passwordCtrl,
                decoration: InputDecoration(
                    labelText: 'CONTRASEŃA',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  color: Theme.of(context).accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    'Iniciar Sesión',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                  onPressed: () {
                    authenticate();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
