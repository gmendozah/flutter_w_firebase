import 'dart:convert';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_w_firebase/services/auth_service.dart';

class LoginPage extends StatefulWidget {

  LoginPage();

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final AuthService _authService = AuthService();
  TextEditingController _usernameCtrl, _passwordCtrl;
  int _counter = 0;
  String _userInfo = '';
  bool isLoggedIn = false;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  //fb vars

  @override
  void initState() {
    super.initState();
    _usernameCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
    _usernameCtrl.text = 'geovani@gmail.com';
    _passwordCtrl.text = 'contrasena';
  }

  @override
  void dispose() {
    super.dispose();
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
  }

  _MyHomePageState() {}

  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.error:
        print("Error");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");
        onLoginStatusChanged(true);
        getProfileInformation(result.accessToken.token);
        break;
    }
  }

  Future getProfileInformation(String token) async {
    var client = http.Client();

    final graphResponse = await client.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
    final profile = jsonDecode(graphResponse.body);
    print(profile);
    /*setState(() {
      _userInfo = profile.toString();
    });*/
    final AuthCredential credential = FacebookAuthProvider.getCredential(
      accessToken: token,
    );
    FirebaseUser user = await _authService.signInWithCredential(credential);
    loadUser(user);
  }

  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }

  Future authenticate() async {
    FirebaseUser user = await _authService.signInWithEmailAndPassword(
        _usernameCtrl.text, _passwordCtrl.text);
    loadUser(user);
  }

  loadUser(FirebaseUser user) {
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

  Future _handleGoogleSignIn() async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      FirebaseUser user = await _authService.signInWithCredential(credential);
      loadUser(user);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
              FacebookSignInButton(
                onPressed: () => initiateFacebookLogin(),
              ),
              GoogleSignInButton(
                onPressed: () => _handleGoogleSignIn(),
                darkMode: true, // default: false
              ),
            ],
          ),
        ),
      ),
    );
  }
}
