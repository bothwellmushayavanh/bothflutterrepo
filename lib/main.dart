
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables



import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/welcome.dart';
import 'package:flutter/material.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Welcome(),
  ));
  
}


