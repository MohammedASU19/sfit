import 'package:flutter/material.dart';
import 'package:sfit/pages/ForgotPasswordPage.dart';
import 'package:sfit/pages/TraineeSignUpPage.dart';
import 'package:sfit/pages/SportsInterestPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sfit/pages/HomePage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sfit/pages/ChooseRolePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool rememberMe = false;

  void _login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (userCredential.user != null) {
        User user = userCredential.user!;
        String uid = user.uid;

        // Determine user type (trainee or coach) and fetch details
        DatabaseReference userRef = FirebaseDatabase.instance.reference().child('trainees').child(uid);
        DataSnapshot snapshot = await userRef.get();

        if (!snapshot.exists) {
          userRef = FirebaseDatabase.instance.reference().child('Coaches').child(uid);
          snapshot = await userRef.get();
        }

        if (snapshot.exists) {
          Map<String, dynamic> userDetails = Map<String, dynamic>.from(snapshot.value as Map);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SportsCoachesPage(userDetails: userDetails),
            ),
          );
        } else {
          print('User details not found for UID: $uid');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The User details not found! Please Login with an authenticated User')),
          );
        }
      } else {
        print('Authentication failed. Please check your login credentials.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Authentication failed. Please check your login credentials.')),
        );
      }
    } catch (e) {
      print('Error signing in: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing in: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/images/SFIT_logo.png',
                width: 200,
                height: 200,
              ),
              SizedBox(height: 20.0),
              Text(
                'SparkFitness',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 5),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Password',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 5),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value!;
                                });
                                print('Remember me: $rememberMe');
                              },
                            ),
                            Text('Remember Me'),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                            );
                          },
                          child: Text(
                            'Forgot your password?',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: _login,
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 94, 204, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: Size(300, 50),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChooseRolePage()),
                          );
                        },
                        child: Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
