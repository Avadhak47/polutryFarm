import 'package:flutter/material.dart';
import 'package:farm_app/slots/mortality.dart';
import 'package:farm_app/vaccination/page_1.dart';

class SlotNameMenuScreen extends StatefulWidget {
  final VoidCallback onBackPressed; // Add a callback for the back action

  SlotNameMenuScreen({Key? key, required this.onBackPressed}) : super(key: key);

  @override
  _SlotNameMenuScreenState createState() => _SlotNameMenuScreenState();
}

class _SlotNameMenuScreenState extends State<SlotNameMenuScreen> {
  List<bool> show = [false, false, false, false];

  final List<MenuOption> options = [
    MenuOption(icon: Icons.local_hospital, title: 'Vaccination'),
    MenuOption(icon: Icons.medical_services, title: 'Medicine'),
    MenuOption(icon: Icons.currency_rupee, title: 'Transaction'),
    MenuOption(icon: Icons.show_chart, title: 'Mortality'),
  ];

  @override
  Widget build(BuildContext context) {
    // Show the appropriate screen based on the `show` list
    if (show[0]) {
      return VaccinationScreen();
    } else if (show[3]) {
      return MortalityScreen(onBackPressed: _hideMortality);
    } else {
      return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: widget.onBackPressed,
          ),
          title: Text(
            'Slot Name',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
        body: ListView.separated(
          itemCount: options.length,
          separatorBuilder: (context, index) => Divider(height: 1),
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(options[index].icon, color: Colors.black54),
              title: Text(
                options[index].title,
                style: TextStyle(fontSize: 14),
              ),
              trailing: Icon(Icons.chevron_right, color: Colors.orange),
              onTap: () {
                setState(() {
                  // Show the selected screen by setting the respective index to true
                  show[index] = true;
                });
              },
            );
          },
        ),
      );
    }
  }

  void _hideMortality() {
    setState(() {
      // Hide the Mortality screen and go back to the menu
      show[3] = false;
    });
  }
}

class MenuOption {
  final IconData icon;
  final String title;

  MenuOption({required this.icon, required this.title});
}
