import 'package:flutter/material.dart';
import 'MyHomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromRGBO(72, 61, 139, 1.0)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
