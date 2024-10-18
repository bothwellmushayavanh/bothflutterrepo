// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class FeesPayment extends StatelessWidget {
  const FeesPayment({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: const [Color(0xffb81736), Color(0xff281537)],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 22),
                child: Text(
                  'Fees Payment',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(  // Wrap the Column in SingleChildScrollView
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 40), // Added spacing at the top
                      TextField(
  decoration: InputDecoration(
    suffixIcon: Icon(
      Icons.check,
      color: Colors.grey,
    ),
    label: Text(
      'Student Name',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xffB81736),
      ),
    ),
  ),
  inputFormatters: [
    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')), // Allow only letters and spaces
  ],
),

                        SizedBox(height: 20,),
                        TextField(
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.check,
                              color: Colors.grey,
                            ),
                            label: Text(
                              'Amount',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffB81736),
                              ),
                            ),
                          ),
                        ),
                       

                        SizedBox(height: 40), // Added spacing at the top
                       DropdownButtonFormField<int>(
  decoration: InputDecoration(
    suffixIcon: Icon(
      Icons.check,
      color: Colors.grey,
    ),
    label: Text(
      'Grade',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xffB81736),
      ),
    ),
  ),
  items: List.generate(7, (index) => index + 1) // Generate grades 1 to 7
      .map((grade) => DropdownMenuItem<int>(
            value: grade,
            child: Text('Grade $grade'),
          ))
      .toList(),
  onChanged: (value) {
    // Handle the change
    print('Selected grade: $value');
  },
),


 SizedBox(height: 40), // Added spacing at the top
  DropdownButtonFormField<String>(
  decoration: InputDecoration(
    suffixIcon: Icon(
      Icons.check,
      color: Colors.grey,
    ),
    label: Text(
      'Term',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xffB81736),
      ),
    ),
  ),
  items: List.generate(3, (index) => 'Term ${index + 1}') // Generate Term 1 to Term 3
      .map((term) => DropdownMenuItem<String>(
            value: term,
            child: Text(term),
          ))
      .toList(),
  onChanged: (value) {
    // Handle the change
    print('Selected term: $value');
  },
),


SizedBox(height: 40),
                        
                        SizedBox(height: 50),
                        Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              colors: const [Color(0xffb81736), Color(0xff281537)],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Submit ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                       
                        SizedBox(height: 20), // Add extra space at the bottom
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
