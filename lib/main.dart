// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todolist/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Home(),
    );
  }
}
