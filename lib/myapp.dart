import 'package:flutter/material.dart';
import 'home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     Color couleur=Colors.blue;
    return MaterialApp(
      title: 'Calorie Calcul',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:couleur),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calorie Calcul'),
    );
  }
}
