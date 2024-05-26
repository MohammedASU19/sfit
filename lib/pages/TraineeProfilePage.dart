import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sfit/pages/FavoriteCoachesListPage.dart';
import 'package:sfit/pages/SearchCoachPage.dart';
import 'package:sfit/pages/Homepage.dart';

class TraineeProfilePage extends StatefulWidget {
  @override
  _TraineeProfilePageState createState() => _TraineeProfilePageState();
}

class _TraineeProfilePageState extends State<TraineeProfilePage> {
  late User _currentUser;
  late DatabaseReference _userRef;
  Map<String, dynamic> _userData = {};

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser!;
    _userRef = FirebaseDatabase.instance.reference().child('trainees').child(_currentUser.uid);

    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      _userRef.onValue.listen((event) {
        if (event.snapshot.value != null && event.snapshot.value is Map<dynamic, dynamic>) {
          setState(() {
            _userData = Map<String, dynamic>.from(event.snapshot.value as Map<dynamic, dynamic>);
          });
        } else {
          print('Error: User data not available or in unexpected format');
        }
      });
    } catch (error) {
      print("Error retrieving user data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Trainee Profile',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // User Profile Section
                    Container(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: _userData.isNotEmpty && _userData['profileImageUrl'] != null
                                ? NetworkImage(_userData['profileImageUrl'])
                                : NetworkImage('https://cdn-icons-png.flaticon.com/512/177/177660.png'),
                          ),
                          SizedBox(height: 10),
                          Text(
                            _userData.isNotEmpty
                                ? '${_userData['firstName']} ${_userData['lastName']}' // Display user's first and last name
                                : 'User Name', // Placeholder text
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          // Display Username and Birthdate in blue boxes
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '@${_userData['username'] ?? 'Username'}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${_userData['day'] ?? 'Day'} ${_userData['month'] ?? 'Month'} ${_userData['year'] ?? 'Year'}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Edit Profile and Settings Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Add functionality for editing profile
                          },
                          child: Container(
                            height: 50,
                            width: 330,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Center(
                              child: Text(
                                'Edit Profile',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            // Add functionality for navigating to settings
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Icon(Icons.settings),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Other Sections (My Sessions, Notifications, Get Help, About App)
                    GestureDetector(
                      onTap: () {
                        // Add functionality for My Sessions
                      },
                      child: Container(
                        height: 80,
                        color: Colors.grey[200],
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Icon(Icons.event),
                            SizedBox(width: 10),
                            Text(
                              'My Sessions',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        // Add functionality for Notifications
                      },
                      child: Container(
                        height: 80,
                        color: Colors.grey[200],
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Icon(Icons.notifications),
                            SizedBox(width: 10),
                            Text(
                              'Notifications',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        // Add functionality for Get Help
                      },
                      child: Container(
                        height: 80,
                        color: Colors.grey[200],
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Icon(Icons.sports_soccer),
                            SizedBox(width: 10),
                            Text(
                              'Get Help',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        // Add functionality for About App
                      },
                      child: Container(
                        height: 80,
                        color: Colors.grey[200],
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Icon(Icons.help),
                            SizedBox(width: 10),
                            Text(
                              'About App',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, size: 30),
              color: const Color.fromARGB(255, 44, 184, 249),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SportsCoachesPage(userDetails: {},)),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.search, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SportsCoachesPage(userDetails: {},)),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.favorite, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoriteCoaches(title: 'Favorite Coaches')),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.person, size: 30),
              onPressed: () {
                // No need to navigate to TraineeProfilePage since we are already on it
              },
            ),
          ],
        ),
      ),
    );
  }
}