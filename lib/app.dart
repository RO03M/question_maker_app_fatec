import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:question_maker_app/routes/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple
        )
      ),
      initialRoute: RoutesManager.login,
      onGenerateRoute: RoutesManager.controller,
    );
  }
}