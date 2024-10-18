
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class DailySummary extends StatelessWidget {
  const DailySummary({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Empty Scaffold'),
        ),
        body: Center(
          child: Text(''), // Empty body or you can leave this as an empty Center()
        ),
      ),
    );
   
   
  }
}
