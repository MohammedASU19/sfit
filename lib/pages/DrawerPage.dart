import 'package:flutter/material.dart';
import 'package:sfit/pages/SubscriptionPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sfit/pages/LoginPage.dart';

class MyDrawer extends StatelessWidget {
  final Map<String, dynamic>? userDetails;

  MyDrawer({required this.userDetails});

  @override
  Widget build(BuildContext context) {
    if (userDetails == null) {
      return Center(child: CircularProgressIndicator());
    }

    String username = userDetails!['username'] ?? 'Username';
    String? profileImageUrl = userDetails!['profileImageUrl'];

    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 20.0),
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: profileImageUrl != null ? NetworkImage(profileImageUrl) : null,
                  backgroundColor: Colors.blue,
                  child: profileImageUrl == null
                      ? Icon(
                          Icons.account_circle,
                          size: 50.0,
                          color: Colors.white,
                        )
                      : null,
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: TextStyle(fontSize: 20.0),
                        overflow: TextOverflow.ellipsis, // Ensures text does not overflow
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        height: 1.0,
                        width: double.infinity,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.sports_gymnastics_rounded),
            title: Text('Sessions'),
            onTap: () {
              // Handle Sessions tap
            },
          ),
          ListTile(
            leading: Icon(Icons.sports_kabaddi_rounded),
            title: Text('Coaches'),
            onTap: () {
              // Handle Coaches tap
            },
          ),
          ListTile(
            leading: Icon(Icons.card_membership_rounded),
            title: Text('Plans'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SubscriptionPage()));
              // Handle Plans tap
            },
          ),
          ListTile(
            leading: Icon(Icons.credit_card_rounded),
            title: Text('Subscriptions'),
            onTap: () {
              // Handle Subscriptions tap
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_month_sharp),
            title: Text('Schedule'),
            onTap: () {
              // Handle Schedule tap
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sign out'),
            onTap: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
              } catch (e) {
                print('Error signing out: $e');
              }
            },
          ),
        ],
      ),
    );
  }
}
