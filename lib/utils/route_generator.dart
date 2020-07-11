import 'package:flutter/material.dart';
import 'package:flutter_w_firebase/ui/login/login.dart';
import 'package:flutter_w_firebase/ui/todo/todo_list.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final dynamic args = settings.arguments;

    switch (settings.name) {
      case '/login':
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
        );
        break;
      case '/todo_list':
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              TodoListPage(),
        );
        break;
      case '/main_menu':
        return PageRouteBuilder();
        break;
    }
  }
}
