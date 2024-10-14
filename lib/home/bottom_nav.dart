import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  final Function(int) onItemSelected; // Callback to pass selected index

  BottomNav({required this.onItemSelected}); // Constructor to accept the callback

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onItemSelected(index); // Trigger the callback to pass selected index
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'Home', 0),
          _buildNavItem(Icons.description, 'Slot', 1),
          _buildNavItem(Icons.article, 'Form', 2),
          _buildNavItem(Icons.favorite, 'Vet', 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _selectedIndex == index ? Colors.orange : Colors.grey),
          Text(label, style: TextStyle(color: _selectedIndex == index ? Colors.orange : Colors.grey)),
        ],
      ),
    );
  }
}
