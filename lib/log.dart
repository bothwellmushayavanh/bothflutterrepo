// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/user/userdashboard.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Authentication instance

  Future<void> _loginUser(BuildContext context) async {
  String email = _emailController.text.trim();
  String password = _passwordController.text.trim();

  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Check if the user is authenticated
    if (userCredential.user != null) {
      // Navigate to the dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserDashboard()),
      );
    }
  } on FirebaseAuthException catch (e) {
    String message;
    if (e.code == 'user-not-found') {
      message = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      message = 'Incorrect password.';
    } else {
      message = 'An error occurred. Please try again.';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}


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
                padding: const EdgeInsets.only(top: 70.0, left: 22),
                child: Text(
                  'Sign in ',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 40),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.check,
                              color: Colors.grey,
                            ),
                            label: Text(
                              'Email',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffB81736),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            label: Text(
                              'Password',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffB81736),
                              ),
                            ),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Forget Password',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB81736),
                            ),
                          ),
                        ),
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
                          child: ElevatedButton(
                            onPressed: () {
                              // _loginUser(context);
                               Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserDashboard()),
      );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(300, 55),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'SIGN IN',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 170),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "Sign up",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
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
