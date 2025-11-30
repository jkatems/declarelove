import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'home.dart';

void main() {
  runApp(const DeclarationAmourApp());
}

class DeclarationAmourApp extends StatelessWidget {
  const DeclarationAmourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Cœur pour Rihanna',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'PlayfairDisplay',
        useMaterial3: true,
      ),
      home: const PageAccueil(),
      debugShowCheckedModeBanner: false,
    );
  }
}
