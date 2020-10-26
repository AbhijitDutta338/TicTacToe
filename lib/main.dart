import 'package:flutter/material.dart';
import 'package:tictactoe/Game.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "tic tac toe",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Game(),
    );
  }
}
