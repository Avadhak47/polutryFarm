import 'package:flutter/material.dart';

class BirdStatusCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
          child: Text(
            'Current Status',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 80,
          child: Row(
            children: [
              Expanded(child: _buildStatusCard(Icons.location_on, '68', 'alive birds', Colors.orange)),
              SizedBox(width: 10), // Padding between cards
              Expanded(child: _buildStatusCard(Icons.store, '50', 'ready to market', Colors.blue)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusCard(IconData icon, String count, String label, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10), // Padding from left and right
      decoration: BoxDecoration(
        color: Color(0xFFFFFBF1), // Background color: #FFFBF1
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black12, // Soft shadow
            offset: Offset(0, 2),  // Horizontal and vertical offset
            blurRadius: 6.0,       // Blur effect
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 24, color: color),
            SizedBox(width: 10), // Padding between icon and text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  count,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
