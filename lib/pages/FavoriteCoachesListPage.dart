import 'package:flutter/material.dart';

class FavoriteCoaches extends StatelessWidget {
  FavoriteCoaches({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      appBar: AppBar(
        backgroundColor: Colors.white, // Set the app bar background color to white
        centerTitle: true,
        title: Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                this.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Icon(Icons.notifications, color: Colors.black),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 1,
            color: Colors.grey[300],
            margin: EdgeInsets.symmetric(vertical: 10),
          ),

          InkWell(
            onTap: () {
              _showCoachDetails(context, 'Sarah Johnson', 'Basketball',
                  'https://media.istockphoto.com/id/174861321/photo/female-basketball-coach.jpg?s=612x612&w=0&k=20&c=n8rFmHnlaMXeP72_pxElkkIpAyWd6-AwVPS8P4HaeUA=');
            },
            child: _buildCoachCard(
              'https://media.istockphoto.com/id/174861321/photo/female-basketball-coach.jpg?s=612x612&w=0&k=20&c=n8rFmHnlaMXeP72_pxElkkIpAyWd6-AwVPS8P4HaeUA=',
              'Sarah Johnson',
              'Basketball',
            ),
          ),
          InkWell(
            onTap: () {
              _showCoachDetails(context, 'Alex Rodriguez', 'Baseball',
                  'https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w1024/mlb/dqh0gzojb56za0dqwsue');
            },
            child: _buildCoachCard(
              'https://img.mlbstatic.com/mlb-images/image/private/t_16x9/t_w1024/mlb/dqh0gzojb56za0dqwsue',
              'Alex Rodriguez',
              'Baseball',
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // Set the bottom navigation bar background color to white
        elevation: 0, // Remove the shadow effect
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false, // Hide the labels
        showUnselectedLabels: false, // Hide the labels
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildCoachCard(String imageUrl, String name, String sport) {
    return Container(
      width: 410, // Set width
      height: 100, // Set height 
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Add padding
      child: Card(
        color: Colors.grey[200], // Set the card background color to grey
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(20), // Adjust border radius as needed
            child: Image.network(
              imageUrl,
              width: 70, // Set image width
              height: 70, // Set image height
              fit: BoxFit.cover, // Adjust how the image fits into the space
            ),
          ),
          title: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold), // Make the name bold
          ),
          subtitle: Text(sport),
          trailing: Icon(Icons.delete_forever),
        ),
      ),
    );
  }

  void _showCoachDetails(BuildContext context, String name, String sport,
      String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 10),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Coach Details',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 20),
                    CircleAvatar(
                      backgroundImage: NetworkImage(imageUrl),
                      radius: 50,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Name: $name',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sport: $sport',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 10),
                        _getSportIcon(sport),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 5, // Adjusted position of the close button
                top: 5, // Adjusted position of the close button
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 15,
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getSportIcon(String sport) {
    switch (sport.toLowerCase()) {
      case 'basketball':
        return Icon(Icons.sports_basketball);
      case 'baseball':
        return Icon(Icons.sports_baseball);
      default:
        return Icon(Icons.sports);
    }
  }
}
