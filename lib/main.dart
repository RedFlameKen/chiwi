import 'package:chiwi/pages/init_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
  RendererBinding.instance.ensureSemantics();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chiwi AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
<<<<<<<<< Temporary merge branch 1
      //home: const LandingPage()//changed this for testing purposes
      home: const ReviwermakerPage()
=========
      home: InitPage()
    );
  }
}
