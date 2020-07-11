import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_w_firebase/utils/route_generator.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Widget createApp(BuildContext context, String initRoute) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter W Firebase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: initRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }

  Future<FirebaseUser> getFirebaseUser() async {
    var user = await _firebaseAuth.currentUser();
    print('user: $user');
    print(user == null);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return createApp(context, '/login');
  }
}
