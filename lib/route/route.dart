// routes.dart
import 'package:assignment/splash_screen.dart';
import 'package:assignment/user/user_form.dart';
import 'package:assignment/user/users_list.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashScreen = '/';
  static const String userListScreen = '/userListScreen';
  static const String userFormScreen = '/userFormScreen';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case userListScreen:
        return _createSlideTransition( UsersListScreen());
      case userFormScreen:
        return _createSlideTransition(UserFormScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  static PageRouteBuilder _createSlideTransition(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(-1.0, -1.0); 
      var end = Offset(0.0, 0.0);
      var curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}

}
