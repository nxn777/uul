import 'package:UUL_Gym/models/app_state.dart';
import 'package:UUL_Gym/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (context) => AppState(),
      child: MaterialApp(
        theme: ThemeData.light().copyWith(canvasColor: Colors.white),
        home: HomeScreen(),
      ),
    );
  }
}
