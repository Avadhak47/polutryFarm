import 'package:flutter/material.dart';

class TopNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min, // This helps reduce vertical space
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/bird_1.png'),
                    radius: 16, // Reduced from 20
                  ),
                  SizedBox(width: 8),
                  Text('POULTRY VALLEY',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14, // Added to ensure text isn't too large
                      )),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.translate, size: 20), // Specified smaller size
                  SizedBox(width: 12),
                  Icon(Icons.notifications, size: 20), // Specified smaller size
                ],
              ),
            ],
          ),
          SizedBox(height: 4), // Reduced from 10
          Container(
            height: 40, // Explicitly set height for search bar
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 40, // Fixed width for menu icon
                  child: Icon(Icons.menu, size: 20),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      hintStyle: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                SizedBox(
                  width: 40, // Fixed width for mic icon
                  child: Icon(Icons.mic, size: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}