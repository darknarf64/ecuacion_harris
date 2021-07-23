import 'package:ecuacion_harris/home_page.dart';
import 'package:ecuacion_harris/macronutrientes.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculo requerimiento energético',
      debugShowCheckedModeBanner: false,
      initialRoute: 'homePage',
      routes: {
        'homePage': (BuildContext context) => HomePage(),
        'macronutrientes': (BuildContext context) => Macronutrientes()
      },
    );
  }
}
