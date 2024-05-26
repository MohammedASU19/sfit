import 'package:flutter/material.dart';
import 'package:sfit/pages/welcomePage.dart';
import 'package:sfit/pages/DrawerPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sfit/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart'; 
import 'package:firebase_storage/firebase_storage.dart';
Future main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
options: FirebaseOptions(
    apiKey: 'AIzaSyDufYmX2gBSh-S6peEIDG8YmOwdAMeLbwE',
    appId: '1:171465684664:web:8b04cb2516c6d7370aa64d',
    messagingSenderId: '171465684664',
    projectId: 'sfit-cd995',
    authDomain: 'sfit-cd995.firebaseapp.com',
    storageBucket: 'sfit-cd995.appspot.com',
    measurementId: 'G-SP62ZKX2XD',
    databaseURL: 'https://sfit-cd995-default-rtdb.firebaseio.com'
),
);
runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroductionPage(),
       debugShowCheckedModeBanner: false,
    );
  }
}

class IntroductionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage('https://media.istockphoto.com/id/652704318/vector/weightlifting-and-fitness.jpg?b=1&s=612x612&w=0&k=20&c=qWI1fbBXfJ02jYymii5ejwJv35YouYalh9vbT91cWWw='),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      'Sports Connect',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'Connect with the best \n Coaches',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Your ultimate coaching companion',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Image.network(
                      'https://media.istockphoto.com/id/949190756/photo/various-sport-equipments-on-grass.jpg?s=612x612&w=0&k=20&c=s0Lz_k0Vq_9P6JBETBMtLsK0lSKEHg4Tnqz9KlRCSHA=',
                      width: 850,
                      height: 300,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Key App Features',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFeatureBox(Icons.search, 'Find coaches', context),
                  _buildFeatureBox(Icons.calendar_today, 'Schedule \n session', context),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFeatureBox(Icons.trending_up, 'Track \n Progress', context),
                  _buildFeatureBox(Icons.explore, 'Explore our \n plans', context),
                ],
              ),
              SizedBox(height: 20.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User Testimonials',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage('https://t3.ftcdn.net/jpg/02/78/42/76/360_F_278427683_zeS9ihPAO61QhHqdU1fOaPk2UClfgPcW.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'John Doe',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              'The app helped me improve my \ngame significantly. Highly \nrecommended!',
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate to SignUpPage when "Find Coach" button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomePage()),
                  );
                },
                child: Text(
                  'Find Coach',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFooterLabel('Home'),
                  _buildFooterLabel('Coaches'),
                  _buildFooterLabel('Schedule'),
                  _buildFooterLabel('Profile'),
                  _buildFooterLabel('Settings'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureBox(IconData icon, String text, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to SignUpPage when a Key Feature card is pressed
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WelcomePage()),
        );
      },
      child: Container(
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40.0,
            ),
            SizedBox(height: 5.0),
            Text(
              text,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterLabel(String text) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
