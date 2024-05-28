import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: GroupPlanPage(),
  ));
}

class GroupPlanPage extends StatelessWidget {
  const GroupPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Image.network(
            'https://kajabi-storefronts-production.kajabi-cdn.com/kajabi-storefronts-production/file-uploads/themes/2155085722/settings_images/7a07fe-006a-47e6-d885-651cec38541d_2.jpg',
            height: 40.0,
            width: 100.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PlanDetailsCard(
              title: 'Group Plan Details',
              details: [
                'Plan Name: Premium Fitness',
                'Description: Access to premium fitness classes',
                'Price: \$49.99/month',
                'Features: Personal trainer, nutrition plan',
                'Number of Friends:',
              ],
              dropdownItems: [
                '3 friends',
                '4 friends',
                '5 friends',
                '6 friends',
                '7 friends',
                '8 friends',
                '9 friends',
              ],
            ),
            const PlanDetailsCard(
              title: 'Serial Code Sharing',
              details: [
                'Your Serial Code: ABCDEF123',
              ],
              hasButton: true,
            ),
            const SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  textStyle: const TextStyle(fontSize: 20.0, color: Colors.white),
                  minimumSize: const Size(300.0, 50.0),
                ),
                child: const Text('Subscribe Now'),
              ),
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
              icon: const Icon(Icons.home, color: Colors.lightBlue),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.favorite, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.account_circle, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class PlanDetailsCard extends StatelessWidget {
  final String title;
  final List<String> details;
  final List<String>? dropdownItems;
  final bool hasButton;

  const PlanDetailsCard({super.key, 
    required this.title,
    required this.details,
    this.dropdownItems,
    this.hasButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 10.0),
          for (String detail in details)
            detail.contains(':')
                ? Text(detail, style: const TextStyle(fontSize: 16, color: Colors.black))
                : const SizedBox.shrink(),
          if (dropdownItems != null) ...[
            const SizedBox(height: 10.0),
            DropdownButton<String>(
              items: dropdownItems!
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
              onChanged: (value) {},
              hint: const Text('Select number of friends'),
            ),
          ],
          if (hasButton)
            const SizedBox(height: 10.0),
          if (hasButton)
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text('Copy Code', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
        ],
      ),
    );
  }
}
