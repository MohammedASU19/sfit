import 'package:flutter/material.dart';
import 'package:sfit/pages/GroupPlanPage.dart';
import 'package:sfit/pages/FamilyPlanPage.dart';

class SubscriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'SFIT Plans',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SubscriptionCard(
              title: 'Family Plan',
              price: '\$29.99/day',
              features: [
                'Up to 5 family members',
                '2 hours training session',
                'Access to personal coach',
              ],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FamilyPlanPage()),
                );
              },
            ),
            SubscriptionCard(
              title: 'Group Plan',
              price: '\$49.99/day',
              features: [
                'Up to 10 group members',
                'Weekly team training sessions',
                'Access to group coach',
              ],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GroupPlanPage()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.lightBlue),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.favorite, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_circle, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final String title;
  final String price;
  final List<String> features;
  final VoidCallback onPressed;

  const SubscriptionCard({
    required this.title,
    required this.price,
    required this.features,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
          ),
          SizedBox(height: 10.0),
          Text(
            price,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: features.map((feature) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Icon(
                      feature.contains('family members') ? Icons.people :
                      feature.contains('training session') ? Icons.access_time :
                      Icons.person,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10.0),
                    Expanded(child: Text(feature, style: TextStyle(fontSize: 16, color: Colors.black))),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 10.0),
          Center(
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text('Subscribe', style: TextStyle(fontSize: 16, color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
