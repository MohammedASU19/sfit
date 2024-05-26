import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sfit/pages/LoginPage.dart';
import 'package:sfit/pages/TermsConPage.dart';

class CoachSignUpPage extends StatefulWidget {
  @override
  _CoachSignUpPageState createState() => _CoachSignUpPageState();
}

class _CoachSignUpPageState extends State<CoachSignUpPage> {
  DatabaseReference databaseRef = FirebaseDatabase.instance.reference().child("Coaches");

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String? _gender;
  String? _birthDay;
  String? _birthMonth;
  String? _birthYear;
  String? _specialization;
  bool _canTrainSpecialNeeds = false;
  final FirebaseAuth _UserDetailsAuth = FirebaseAuth.instance;

  void _signUpCoach() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      final UserCredential userCredential = await _UserDetailsAuth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      final User? user = userCredential.user;

      if (user != null) {
        final newCoach = {
          'first_name': _firstNameController.text,
          'last_name': _lastNameController.text,
          'phone_number': _phoneNumberController.text,
          'email': _emailController.text,
          'username': _usernameController.text,
          'gender': _gender,
          'birthdate': '$_birthDay-$_birthMonth-$_birthYear',
          'specialization': _specialization,
          'can_train_special_needs': _canTrainSpecialNeeds,
          'password': _passwordController.text, // Save the actual password text
        };

        // Save coach's details to Realtime Database
        await databaseRef.child(user.uid).set(newCoach);

        // Navigate to Login Page after successful signup
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } catch (e) {
      print(e); // Print any error that occurs during signup
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Coach Sign Up',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(width: 20.0),
            GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(
                    'https://cdn-icons-png.flaticon.com/512/2585/2585583.png'),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 2.0,
                    color: Colors.grey[300],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Personal Information',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    height: 2.0,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'First Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 3.0),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TextField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Last Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 3.0),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TextField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Phone Number',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 3.0),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TextField(
                            controller: _phoneNumberController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Email',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 3.0),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Username',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 3.0),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Password',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 3.0),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Confirm Password',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 3.0),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TextField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Gender',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: DropdownButton<String>(
                            value: _gender,
                            isExpanded: true,
                            items: ['Male', 'Female'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _gender = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            Text(
                              'Birthdate (Day/Month/Year)',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 80.0,
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: DropdownButton<String>(
                                value: _birthDay,
                                isExpanded: true,
                                items: List.generate(31, (index) {
                                  return DropdownMenuItem<String>(
                                    value: (index + 1).toString(),
                                    child: Text((index + 1).toString()),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _birthDay = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Container(
                              width: 100.0,
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: DropdownButton<String>(
                                value: _birthMonth,
                                isExpanded: true,
                                items: List.generate(12, (index) {
                                  return DropdownMenuItem<String>(
                                    value: (index + 1).toString(),
                                    child: Text((index + 1).toString()),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _birthMonth = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Container(
                              width: 100.0,
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: DropdownButton<String>(
                                value: _birthYear,
                                isExpanded: true,
                                items: List.generate(DateTime.now().year - 1969, (index) {
                                  return DropdownMenuItem<String>(
                                    value: (1970 + index).toString(),
                                    child: Text((1970 + index).toString()),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _birthYear = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Coaching Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    height: 2.0,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Specialization in Sport',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: DropdownButton<String>(
                            value: _specialization,
                            isExpanded: true,
                            items: [
                              'Football',
                              'Basketball',
                              'Table Tennis',
                              'Tennis',
                              'Badminton',
                              'Taekwondo',
                              'Volleyball',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _specialization = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            Text(
                              'Can train Special Needs individuals?',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10.0),
                            Checkbox(
                              value: _canTrainSpecialNeeds,
                              onChanged: (value) {
                                setState(() {
                                  _canTrainSpecialNeeds = value!;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Certifications',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 94, 204, 255),
                            ),
                            child: Text(
                              'Add Certificate',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Experience',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start Date (Day/Month/Year)',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'End Date (Day/Month/Year)',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Description',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TextField(
                            maxLines: 4,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                              hintText: 'Enter a description',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 94, 204, 255),
                                ),
                                child: Text(
                                  'Add more',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,                     
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                        onPressed: _signUpCoach,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 94, 204, 255),
                        ),
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('2024 SFIT App'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TermsConditionsPage()),
                            );
                          },
                          child: Text(
                            'Terms of Service',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Text('/'),
                        SizedBox(width: 10.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TermsConditionsPage()),
                            );
                          },
                          child: Text(
                            'Privacy Policy',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
