import 'package:flutter/material.dart';

class CertificatesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color of the scaffold to white
      appBar: AppBar(
        backgroundColor: Colors.white, // Set background color of the app bar to white
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // Set back arrow color to black
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Coach Certificates',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), // Set text color to black and bold
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CertificateCard(
              imageUrl: 'https://marketplace.canva.com/EADaoR1v0uE/1/0/1600w/canva-dark-blue-%26-beige-simple-sport-certificate-8vBJASueSfE.jpg',
              title: 'Certificate 1',
              certificationType: 'Certification Type: Level 3 Coaching',
            ),
            SizedBox(height: 20),
            CertificateCard(
              imageUrl: 'https://marketplace.canva.com/EADaoR1v0uE/1/0/1600w/canva-dark-blue-%26-beige-simple-sport-certificate-8vBJASueSfE.jpg',
              title: 'Certificate 2',
              certificationType: 'Certification Type: Football Coaching',
            ),
            SizedBox(height: 20),
            CertificateCard(
              imageUrl: 'https://marketplace.canva.com/EADaoR1v0uE/1/0/1600w/canva-dark-blue-%26-beige-simple-sport-certificate-8vBJASueSfE.jpg',
              title: 'Certificate 3',
              certificationType: 'Certification Type: Tennis Coaching',
            ),
          ],
        ),
      ),
    );
  }
}

class CertificateCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String certificationType;

  const CertificateCard({
    required this.imageUrl,
    required this.title,
    required this.certificationType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imageUrl,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(certificationType),
              ],
            ),
          ),
        ],
      ),
    );
  }
}