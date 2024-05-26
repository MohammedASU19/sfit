import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:sfit/pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:sfit/pages/GuardianSetup.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Set background color of app bar to white
      ),
      body: SingleChildScrollView(
        child: SignUpForm(),
      ),
      backgroundColor: Colors.white, // Set background color of scaffold to white
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  File? _image;
  String? _imageUrl; // Variable to store the image URL
  String? _firstName;
  String? _lastName;
  int? _day;
  int? _month;
  int? _year;
  String? _phoneNumber;
  String? _email;
  String? _username;
  String? _password;
  String? _repeatPassword;
  bool _individualWithUniqueAbilities = false;
  bool _guardianForTrainees = false;
  bool _obscurePassword = true;
  List<Map<String, dynamic>> _juniorTrainees = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                _pickImage();
              },
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.transparent,
                child: _image != null 
                  ? ClipOval(
                      child: Image.file(
                        _image!,
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(Icons.person, size: 50),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Sign up',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'First name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your first name';
                } else if (value.length < 3) {
                  return 'First name must be at least 3 characters';
                } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                  return 'First name can only contain letters';
                }
                return null;
              },
              onSaved: (value) {
                _firstName = value;
              },
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Last name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your last name';
                } else if (value.length < 3) {
                  return 'Last name must be at least 3 characters';
                } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                  return 'Last name can only contain letters';
                }
                return null;
              },
              onSaved: (value) {
                _lastName = value;
              },
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Text('Birthdate'),
                SizedBox(width: 10.0),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField(
                          items: List.generate(31, (index) {
                            return DropdownMenuItem(
                              child: Text('${index + 1}'),
                              value: index + 1,
                            );
                          }),
                          decoration: InputDecoration(
                            labelText: 'Day',
                          ),
                          onChanged: (int? value) {},
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a day';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _day = value as int?;
                          },
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: DropdownButtonFormField(
                          items: List.generate(12, (index) {
                            return DropdownMenuItem(
                              child: Text('${index + 1}'),
                              value: index + 1,
                            );
                          }),
                          decoration: InputDecoration(
                            labelText: 'Month',
                          ),
                          onChanged: (int? value) {},
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a month';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _month = value as int?;
                          },
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: DropdownButtonFormField(
                          items: List.generate(DateTime.now().year - 1970 + 1, (index) {
                            return DropdownMenuItem(
                              child: Text('${DateTime.now().year - index}'),
                              value: DateTime.now().year - index,
                            );
                          }),
                          decoration: InputDecoration(
                            labelText: 'Year',
                          ),
                          onChanged: (int? value) {},
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a year';
                            } else if (DateTime.now().year - value < 18) {
                              return 'You must be at least 18 years old';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _year = value as int?;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Phone number',
                suffixIcon: Icon(Icons.call),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                } else if (value.length < 10 || value.length > 14) {
                  return 'Phone number must be between 10 and 14 digits';
                }
                return null;
              },
              onSaved: (value) {
                _phoneNumber = value;
              },
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Email',
                suffixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                } else if (!value.contains('@')) {
                  return 'Please enter a valid email address';
                } else if (value.length < 12) {
                  return 'Email must be at least 12 characters long';
                }
                return null;
              },
              onSaved: (value) {
                _email = value;
              },
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Create Username',
                suffixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a username';
                } else if (value.length < 5) {
                  return 'Username must be at least 5 characters';
                } else if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                  return 'Special characters are not allowed';
                }
                return null;
              },
              onSaved: (value) {
                _username = value;
              },
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Create password',
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                } else if (value.length < 8 || value.length > 30) {
                  return 'Password must be between 8 and 30 characters';
                } else if (!RegExp(r'^(?=.*?[0-9@]).{8,}$').hasMatch(value)) {
                  return 'Password must contain a number or symbol';
                }
                return null;
              },
              onChanged: (value) {
                _password = value;
              },
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Repeat password',
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please repeat your password';
                } else if (value != _password) {
                  return 'Passwords do not match';
                }
                return null;
              },
              onChanged: (value) {
                _repeatPassword = value;
              },
            ),
            SizedBox(height: 10.0),
            CheckboxListTile(
              title: Text('Individual with Unique Abilities'),
              value: _individualWithUniqueAbilities,
              onChanged: (newValue) {
                setState(() {
                  _individualWithUniqueAbilities = newValue!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Guardian for Trainees'),
              value: _guardianForTrainees,
              onChanged: (newValue) async {
                setState(() {
                  _guardianForTrainees = newValue!;
                });
                if (_guardianForTrainees) {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GuardianSetupPage(),
                    ),
                  );
                  if (result != null) {
                    setState(() {
                      _juniorTrainees = result;
                    });
                  }
                }
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 94, 204, 255),),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _signUp();
                }
              },
              child: Text('Confirm',
              style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
            ),
          ],
        ),
      ),
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
            firebase_storage.FirebaseStorage.instance.ref().child('profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
        await storageRef.putFile(_image!);
        _imageUrl = await storageRef.getDownloadURL();
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }

  Future<void> _signUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email!,
        password: _password!,
      );
      User? user = userCredential.user;

      if (user != null) {
        DatabaseReference databaseRef = FirebaseDatabase.instance.reference().child('trainees').child(user.uid);
        await databaseRef.set({
          'firstName': _firstName,
          'lastName': _lastName,
          'day': _day,
          'month': _month,
          'year': _year,
          'phoneNumber': _phoneNumber,
          'email': _email,
          'username': _username,
          'password': _password,
          'individualWithUniqueAbilities': _individualWithUniqueAbilities,
          'guardianForTrainees': _guardianForTrainees,
          'profileImageUrl': _imageUrl, // Save the image URL in the database
          'juniorTrainees': _juniorTrainees, // Save the junior trainees details in the database
        });
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    } catch (e) {
      print('Error signing up: $e');
    }
  }
}
