import 'package:farm_app/home/render.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String>> birds = [
    {'name': 'Broiler', 'image': 'assets/hen1.jpg'},
    {'name': 'Desi', 'image': 'assets/hen1.jpg'},
    {'name': 'Kuroiler', 'image': 'assets/hen1.jpg'},
    {'name': 'Chick', 'image': 'assets/hen1.jpg'},
    {'name': 'Cockerel', 'image': 'assets/hen1.jpg'},
    {'name': 'Layer', 'image': 'assets/hen1.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => RenderPage()),
              );
            },
          ),
          title: Text('Popular Birds Category'),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(16),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: birds.map((bird) => _buildBirdCard(bird['name']!, bird['image']!)).toList(),
        )
    );
  }

  Widget _buildBirdCard(String title, String imagePath) {
    return BirdCard(title: title, imagePath: imagePath);
  }
}

class BirdCard extends StatefulWidget {
  final String title;
  final String imagePath;

  BirdCard({required this.title, required this.imagePath});

  @override
  _BirdCardState createState() => _BirdCardState();
}

class _BirdCardState extends State<BirdCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: _isPressed ? Border.all(color: Colors.yellow, width: 2) : null,
          image: DecorationImage(
            image: AssetImage(widget.imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.all(12),
          child: Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}