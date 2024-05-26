import 'package:flutter/material.dart';
import 'package:sfit/pages/FavoriteCoachesListPage.dart';
import 'package:sfit/pages/Homepage.dart';
import 'package:sfit/pages/FilterPage.dart';
import 'package:sfit/pages/ViewCoachProfilePage.dart';

class SearchCoachesPage extends StatefulWidget {
  @override
  _SearchCoachesPageState createState() => _SearchCoachesPageState();
}

class _SearchCoachesPageState extends State<SearchCoachesPage> {
  TextEditingController _searchController = TextEditingController();
  List<Coach> coaches = [
    Coach(name: "Raed Al-Sharif", image: "lib/Images/Raed.png", rating: 4.7, isLocal: true),
    Coach(name: "Mohammad Oqaily", image: "lib/Images/Oqaily.jpeg", rating: 4.5, isLocal: true),
    Coach(name: "Amro Reda", image: "lib/Images/Amro.jpg", rating: 3.8, isLocal: true),
  ];
  List<Coach> filteredCoaches = [];

  @override
  void initState() {
    super.initState();
    filteredCoaches = coaches;
    _searchController.addListener(_filterCoaches);
  }

  void _filterCoaches() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredCoaches = coaches.where((coach) {
        return coach.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
          ),
          title: Text(
            "Search for coaches",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(Icons.filter_alt_rounded),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FilterPage()),
                );
              },
              color: Colors.black,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.grey[200],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        // Implement search action here
                      },
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              ...filteredCoaches.map((coach) => CoachCard(
                coachName: coach.name,
                coachImage: coach.image,
                coachRating: coach.rating,
                isLocalImage: coach.isLocal,
              )),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SportsCoachesPage(userDetails: {})),
                  );
                },
                color: Colors.black,
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Navigate to search
                },
                color: Colors.black,
              ),
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoriteCoaches(title: 'Favorite Coaches')),
                  );
                },
                color: Colors.black,
              ),
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  // Navigate to profile
                },
                color: Colors.black,
              ),
            ],
          ),
          color: Colors.white,
        ),
      ),
    );
  }
}

class CoachCard extends StatefulWidget {
  final String coachName;
  final String coachImage;
  final double coachRating;
  final bool isLocalImage;

  CoachCard({required this.coachName, required this.coachImage, required this.coachRating, this.isLocalImage = false});

  @override
  _CoachCardState createState() => _CoachCardState();
}

class _CoachCardState extends State<CoachCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: Container(
                  height: 150.0,
                  child: widget.isLocalImage
                      ? Image.asset(
                          widget.coachImage,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                      : Image.network(
                          widget.coachImage,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                            return Center(
                              child: Icon(Icons.error),
                            );
                          },
                        ),
                ),
              ),
              Positioned(
                top: 10.0,
                left: 10.0,
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      SizedBox(width: 5.0),
                      Text(
                        widget.coachRating.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10.0,
                right: 10.0,
                child: IconButton(
                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.coachName,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewCoachProfilePage(
                          coachName: widget.coachName,
                          coachImage: widget.coachImage,
                          coachRating: widget.coachRating,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Details",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 94, 204, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Coach {
  final String name;
  final String image;
  final double rating;
  final bool isLocal;

  Coach({required this.name, required this.image, required this.rating, this.isLocal = false});
}
