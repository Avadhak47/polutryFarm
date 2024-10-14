import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final String title;
  final String imagePath;
  final String link;

  const CategoryCard({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.link,
  }) : super(key: key);

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: () {
          // Handle the link tap here, e.g., navigate to the link
          print('Navigating to: ${widget.link}');
        },
        child: Container(
          width: 144,
          height: 144,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovering ? Colors.yellow : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.imagePath,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 8),
              Text(
                widget.title,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}