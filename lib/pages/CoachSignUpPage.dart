import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:sfit/pages/LoginPage.dart';
import 'package:sfit/pages/TermsConPage.dart';

class CoachSignUpPage extends StatefulWidget {
  const CoachSignUpPage({super.key});

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
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  String? _gender;
  String? _birthDay;
  String? _birthMonth;
  String? _birthYear;
  String? _specialization;
  bool _canTrainSpecialNeeds = false;
  bool _obscurePassword = true;
  final FirebaseAuth _UserDetailsAuth = FirebaseAuth.instance;

  File? _image;
  String? _imageUrl;

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
    );
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      await _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    if (_image != null) {
      try {
        final firebase_storage.Reference storageRef =
            firebase_storage.FirebaseStorage.instance.ref().child('coach_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
        await storageRef.putFile(_image!);
        _imageUrl = await storageRef.getDownloadURL();
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }

  void _signUpCoach() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
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
          'profileImageUrl': _imageUrl, // Save the image URL
        };

        // Save coach's details to Realtime Database
        await databaseRef.child(user.uid).set(newCoach);

        // Navigate to Login Page after successful signup
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    } catch (e) {
      print(e); // Print any error that occurs during signup
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.day}-${picked.month}-${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Coach Sign Up',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 20.0),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  _pickImage();
                },
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: const Color.fromARGB(255, 94, 204, 255), // Blue background color
                  child: _image != null
                      ? ClipOval(
                          child: Image.file(
                            _image!,
                            width: 140,
                            height: 140,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(Icons.person, size: 70, color: Colors.white), // White icon color
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _firstNameController,
                decoration: _inputDecoration('First name'),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _lastNameController,
                decoration: _inputDecoration('Last name'),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _phoneNumberController,
                decoration: _inputDecoration('Phone number').copyWith(
                  prefixText: '+962 ',
                  suffixIcon: const Icon(Icons.call),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _emailController,
                decoration: _inputDecoration('Email').copyWith(
                  suffixIcon: const Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _usernameController,
                decoration: _inputDecoration('Username').copyWith(
                  suffixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _passwordController,
                decoration: _inputDecoration('Create password').copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscurePassword,
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: _inputDecoration('Repeat password').copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscurePassword,
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Gender',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
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
              const SizedBox(height: 10.0),
              const Row(
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
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
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
                  const SizedBox(width: 10.0),
                  Container(
                    width: 100.0,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
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
                  const SizedBox(width: 10.0),
                  Container(
                    width: 100.0,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
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
              const SizedBox(height: 20.0),
              const Text(
                'Coaching Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.left,
              ),
              Container(
                height: 2.0,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 10.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Specialization in Sport',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
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
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Can train Special Needs individuals?',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
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
                    const SizedBox(height: 10.0),
                    const Text(
                      'Certifications',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 94, 204, 255),
                        ),
                        child: const Text(
                          'Add Certificate',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Experience',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Start Date (Day/Month/Year)',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5.0),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TextField(
                            controller: _startDateController,
                            readOnly: true,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                              border: InputBorder.none,
                              hintText: 'Select start date',
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.calendar_today),
                                onPressed: () {
                                  _selectDate(context, _startDateController);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'End Date (Day/Month/Year)',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5.0),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TextField(
                            controller: _endDateController,
                            readOnly: true,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                              border: InputBorder.none,
                              hintText: 'Select end date',
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.calendar_today),
                                onPressed: () {
                                  _selectDate(context, _endDateController);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Description',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const TextField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                          hintText: 'Enter a description',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 94, 204, 255),
                            ),
                            child: const Text(
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
              const SizedBox(height: 20.0),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: 120.0, // Adjust the width as needed
                    height: 50.0, // Adjust the height as needed
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 94, 204, 255), // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0), // Rounded corners
                        ),
                        minimumSize: const Size(120, 50), // Minimum size
                      ),
                      onPressed: _signUpCoach,
                      child: const Text(
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
              ),
              const SizedBox(height: 20.0),
              const Padding(
                padding: EdgeInsets.all(8.0),
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
                              builder: (context) => const TermsConditionsPage()),
                        );
                      },
                      child: const Text(
                        'Terms of Service',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    const Text('/'),
                    const SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TermsConditionsPage()),
                        );
                      },
                      child: const Text(
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
      ),
    );
  }
}
