import 'package:farm_app/slots/slots.dart';
import 'package:farm_app/vaccination/add_vac.dart';
import 'package:flutter/material.dart';
import 'package:farm_app/home/bottom_nav.dart';
import 'package:farm_app/home/home_1.dart';
import 'package:farm_app/home/home_2.dart';
import 'package:farm_app/home/top_nav.dart';
import 'package:farm_app/vaccination/page_1.dart';
// Assuming PoultryDashboard is another screen you have imported

class RenderPage extends StatefulWidget {
  @override
  _RenderPageState createState() => _RenderPageState();
}

class _RenderPageState extends State<RenderPage> {
  int _selectedIndex = 0; // To track the selected index from BottomNav
  bool showHome = false; // The existing toggle condition

  // This method is for toggling between HomePage() and other pages
  void toggleView() {
    setState(() {
      showHome = !showHome;
    });
  }

  // Handle changing the page according to BottomNav's selected index
  void _onNavItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Conditionally render pages based on the selected index and showHome
  Widget _getSelectedPage() {
    // If `showHome` is true, display HomePage regardless of BottomNav selection
    if (showHome) {
      return HomePage(); // Replace with your HomePage widget
    }

    // Otherwise, show the page based on the selected index
    switch (_selectedIndex) {
      case 0:
        return PoultryDashboard(
            onSeeDetails: toggleView); // Replace with your HomePage widget
      case 1:
        return SlotsScreen(); // Replace with your PoultryDashboard widget
      case 2:
        return HomePage(); // Replace with Form (Render4) widget
      case 3:
        return HomePage(); // Replace with VetScreen widget
      default:
        return PoultryDashboard(
            onSeeDetails: toggleView); // Default page if none is selected
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: TopNav(), // Assuming TopNav is your top navigation widget
          ),
        ),
      ),
      body: _getSelectedPage(), // The page to be rendered based on selection
      bottomNavigationBar: BottomNav(
        onItemSelected: _onNavItemSelected, // Pass callback to BottomNav
      ),
    );
  }
}
