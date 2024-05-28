import 'package:flutter/material.dart';
import 'package:sfit/pages/TraineeSignUpPage.dart';
// void main() {
//   runApp(SportsConnectApp());
// }

// class SportsConnectApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ChooseDisabilityPage(),
//     );
//   }
// }

class ChooseDisabilityPage extends StatelessWidget {
  const ChooseDisabilityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "SportsConnect",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              // Add your settings functionality here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              "Choose what you have",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.grey),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.5, // Adjusted aspect ratio for cards
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: <Widget>[
                  _buildCard("Physical Disability", Icons.accessible, context),
                  _buildCard("Visual Impairment", Icons.remove_red_eye, context),
                  _buildCard("Autism Spectrum", Icons.personal_injury_rounded, context),
                  _buildCard("Hearing Impairment", Icons.hearing, context),
                  _buildCard("Intellectual Disability", Icons.people, context),
                  _buildCard("Sensory Processing Disorder", Icons.pan_tool, context),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: 100, // Adjusted width of the button
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    // Add your next button functionality here
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const SignUpPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold, // Set text to bold
                      fontSize: 16, // Adjust text size
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String text, IconData icon, BuildContext context) {
    return Card(
      color: Colors.grey[300],
      child: InkWell(
        onTap: () {
          // Add your card tap functionality here
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 40,
                color: Colors.black,
              ),
              const SizedBox(height: 10),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}