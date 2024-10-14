import 'package:farm_app/home/card_1.dart';
import 'package:farm_app/home/status_code.dart';
import 'package:flutter/material.dart';

class PoultryDashboard extends StatelessWidget {
  final VoidCallback onSeeDetails;

  PoultryDashboard({Key? key, required this.onSeeDetails}) : super(key: key);

  final List<Map<String, String>> categories = [
    {'name': 'Birds', 'image': 'assets/bird_1.png', 'link': 'https://example.com/birds'},
    {'name': 'Medicine', 'image': 'assets/med_1.png', 'link': 'https://example.com/birds'},
    {'name': 'Eggs', 'image': 'assets/egg_1.png', 'link': 'https://example.com/birds'},
    {'name': 'Feeds', 'image': 'assets/feed.png', 'link': 'https://example.com/birds'},
    {'name': 'Equipment', 'image': 'assets/hen1.jpg', 'link': 'https://example.com/birds'},
    {'name': 'Vaccines', 'image': 'assets/vaccination.png', 'link': 'https://example.com/birds'},
    {'name': 'Supplements', 'image': 'assets/hen1.jpg', 'link': 'https://example.com/birds'},
    {'name': 'Services', 'image': 'assets/hen1.jpg', 'link': 'https://example.com/birds'},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Today's rate for Broiler is 220 INR",
                        style: TextStyle(color: Colors.green, fontSize: 12),
                      ),
                      Icon(Icons.trending_up, color: Colors.green, size: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
          BirdStatusCards(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage('assets/hen1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jure',
                          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'NLM',
                          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'yojana se',
                          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton.icon(
                          onPressed: onSeeDetails,
                          icon: Icon(Icons.arrow_forward, color: Colors.black),
                          label: Text('See Details', style: TextStyle(color: Colors.black)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryCard(
                title: categories[index]['name']!,
                imagePath: categories[index]['image']!,
                link: categories[index]['link']!,
              );
            },
          ),
        ],
      ),
    );
  }
}