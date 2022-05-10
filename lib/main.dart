import 'package:flutter/material.dart';
import 'package:products/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppCatalogo',
      onGenerateRoute: routes,
      initialRoute: 'home',
    );
  }
}