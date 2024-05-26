import 'package:flutter/material.dart';
import 'package:sfit/pages/SearchCoachPage.dart';
class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String selectedOption = ''; // Keep track of the selected option
  double priceRange = 50; // Initial price range

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set entire page background color to white
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56), // Default height of AppBar
        child: AppBar(
          backgroundColor: Colors.white, // Set AppBar background color to white
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Navigate back when back arrow is pressed
            },
          ),
          title: Text(
            "Search",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Filter by:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 20), // Add spacing between Filter by text and options
                Expanded(
                  child: Row(
                    children: [
                      buildFilterOption("Experience"),
                      SizedBox(width: 10),
                      buildFilterOption("Available now"),
                      SizedBox(width: 10),
                      buildFilterOption("Active"),
                      SizedBox(width: 10),
                      buildFilterOption("Highly Rated"),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Price range",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "\$10",
                  style: TextStyle(color: Colors.black), // Set price range text color to blue
                ), // Start of price range
                Expanded(
                  child: Slider(
                    value: priceRange,
                    min: 10,
                    max: 100,
                    divisions: 3,
                    onChanged: (value) {
                      setState(() {
                        priceRange = value;
                      });
                    },
                    label: priceRange.toStringAsFixed(0) + '\$', // Display price value
                    activeColor: Colors.blue, // Set price range line color to blue
                  ),
                ),
                Text(
                  "\$100",
                  style: TextStyle(color: Colors.black), // Set price range text color to blue
                ), // End of price range
              ],
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add logic to apply filters
                   Navigator.push(
                    context,MaterialPageRoute(builder: (context) => SearchCoachesPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 120.0, vertical: 16.0),
                ),
                child: Text(
                  "Apply Filters",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFilterOption(String option) {
    bool isSelected = selectedOption == option; // Check if option is selected
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = option; // Set selected option
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
        ),
        child: Text(
          option,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
