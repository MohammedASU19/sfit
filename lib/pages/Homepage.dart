import 'package:flutter/material.dart';
import 'package:sfit/pages/SearchCoachPage.dart';
import 'package:sfit/pages/FavoriteCoachesListPage.dart';
import 'package:sfit/pages/CoachProfilePage.dart';
import 'package:sfit/pages/TraineeProfilePage.dart';
import 'package:sfit/pages/DrawerPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sfit/pages/SportsInterestPage.dart';
class SportsCoachesPage extends StatelessWidget {
  final Map<String, dynamic> userDetails;

  SportsCoachesPage({required this.userDetails});

  Future<bool> _isCoach() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DatabaseReference coachRef = FirebaseDatabase.instance.reference().child('Coaches').child(user.uid);
      DataSnapshot snapshot = await coachRef.get();
      return snapshot.exists;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color of the scaffold to white
      appBar: AppBar(
        backgroundColor: Colors.white, // Set background color of the app bar to white
        title: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(userDetails['profileImageUrl'] ?? 'https://cdn-icons-png.flaticon.com/512/2585/2585583.png'),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Welcome', style: TextStyle(color: Colors.black)), // Set text color to black
                Text(
                  userDetails['username'] ?? 'User',
                  style: TextStyle(color: Colors.black), // Set text color to black
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
      drawer: MyDrawer(userDetails: userDetails),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text(
                  'See another sport?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SportsInterestsPage(userDetails: userDetails)),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.sports_soccer, size: 40),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.sports_basketball, size: 40),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.sports_tennis, size: 40),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.sports_mma, size: 40),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Best ranked coaches',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://cdn.shopify.com/s/files/1/0472/7455/7591/files/matjaz1.jpg?v=1623150466'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  'Table Tennis',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Raed Al-Sharif',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: const Color.fromARGB(255, 44, 184, 249),
                                child: Text(
                                  '#1',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Icon(Icons.star),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    // Handle arrow tap
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Quick Sessions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://www.britishparatabletennis.com/cdn/shop/articles/newcoach_1000x.png?v=1623150313'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Table Tennis',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Mohammad Oqaily',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://c8.alamy.com/comp/2PYXK1K/05-may-2023-hesse-frankfurtmain-jrg-rokopf-national-mens-table-tennis-coach-and-josephina-neumann-13-ttc-berlinyouth-national-player-and-u13-world-number-one-stand-next-to-each-other-in-a-show-match-the-national-table-tennis-coach-and-the-up-and-coming-talent-will-be-promoting-the-wtt-champions-in-the-fall-in-frankfurtm-2910-511-at-the-myzeil-shopping-center-photo-andreas-arnolddpa-2PYXK1K.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Table Tennis',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Amro Reda',
                              style: TextStyle(
                                color: Colors.black,
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
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white, // Set background color of the bottom app bar to white
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, size: 30),
              color: const Color.fromARGB(255, 44, 184, 249),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchCoachesPage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.favorite, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoriteCoaches(title: 'Favorite Coaches',)),
                );
              },
            ),
            FutureBuilder<bool>(
              future: _isCoach(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  bool isCoach = snapshot.data ?? false;
                  return IconButton(
                    icon: Icon(Icons.person, size: 30),
                    onPressed: () {
                      if (isCoach) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CoachProfilePage()),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TraineeProfilePage()),
                        );
                      }
                    },
                  );
                } else {
                  return Icon(Icons.person, size: 30);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
