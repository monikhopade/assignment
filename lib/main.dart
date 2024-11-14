
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/user_provider.dart';
import 'route/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter User App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            backgroundColor: const Color.fromARGB(255, 210, 119, 193)
          ),
          iconTheme: IconThemeData(
            color: const Color.fromARGB(255, 210, 119, 193)
          )
        ),
        initialRoute: Routes.splashScreen, 
        onGenerateRoute: Routes.generateRoute, 
      ),
    );
  }
}
