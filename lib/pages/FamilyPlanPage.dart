import 'package:flutter/material.dart';

class FamilyPlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: Scaffold(
        backgroundColor: Colors.white, // Set background color to white
        appBar: AppBar(
          title: Text(
            'Family Plan',
            style: TextStyle(color: Colors.black), // Set text color to black
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black, // Set icon color to black
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10), // Adjust margin for the bell icon
              child: IconButton(
                icon: Icon(Icons.notifications),
                color: Colors.black, // Set icon color to black
                onPressed: () {
                  // Implement notification functionality
                },
              ),
            ),
          ],
          backgroundColor: Colors.white, // Set app bar background color to white
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Plan Details',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 200, // Increased image size
                      child: Image.network(
                        'https://kajabi-storefronts-production.kajabi-cdn.com/kajabi-storefronts-production/file-uploads/themes/2155085722/settings_images/7a07fe-006a-47e6-d885-651cec38541d_2.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Price: \$29.99/Month',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Features:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Unlimited access to all family fitness classes',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Special Offer: First month free!',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Subscription Form',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Implement subscription functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue, // Change button color
                        minimumSize: Size(double.infinity, 50), // Full width button
                      ),
                      child: Text(
                        'Subscribe Now',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Subscribe now to enjoy family fitness sessions with your loved ones!',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: Colors.lightBlue),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}