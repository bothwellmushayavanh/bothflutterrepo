// ignore_for_file: prefer_const_constructors, override_on_non_overriding_member, prefer_const_literals_to_create_immutables

import 'package:myapp/home.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

@override
  void initState() {
    
    super.initState();

_navigatetoHome();


  }

  _navigatetoHome() async
  {
    await Future.delayed(Duration(milliseconds: 4500),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));

  }


  @override
  Widget build(BuildContext context) {
      
    return Scaffold(
     body: SafeArea(
        child:Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('Welcome', 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                  ),
                  SizedBox(height: 20,),

                  Text('Welcome to SoftQuick Technologies. SoftQiuick Technologies make life easlier',
                 textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,

                  ),
                  ),

 SizedBox(height: 20,),

                  Text('Designed by SoftQuick Technologies',
                 textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                  ),
                  ),
                  
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height/3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/welcome.png'),
                    ),
                ),
              ),
Column(
  children: [
    Text('Lets Enjoy Technology Today Together'),
    
  ],
)







            ],

          ),

          
          
        ),
        ),
    );

      

    
  }
}