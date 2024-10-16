import 'package:flutter/material.dart';

class SlotDetails extends StatefulWidget {
  final VoidCallback onBackPressed;

  const SlotDetails({Key? key, required this.onBackPressed}) : super(key: key);

  @override
  _SlotDetailsState createState() => _SlotDetailsState();
}

class _SlotDetailsState extends State<SlotDetails> {
  // Dummy data for slots
  List<Map<String, dynamic>> slots = [
    {
      'slotName': 'Slot Name',
      'weeks': '6 Weeks: 5 days',
      'totalChicks': 1100,
      'sold': 1000,
      'live': 100,
      'mortality': 0,
      'expenses': 200000,
      'income': 250000,
      'balance': 50000,
      'costPerBird': 100,
      'soldBirds': 5000,
      'profitOnBirds': 125000,
      'totalFeed': 15000,
      'feedCost': 120,
      'feedIntake': 3000,
      'bodyWeight': 1000,
      'fcr': 3,
    }
  ];

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: Column(
            children: [
              Icon(Icons.cancel, color: Colors.red, size: 48),
              SizedBox(height: 16),
              Text("Are you sure you want to delete the slot?"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                // Perform the delete action
                Navigator.of(context).pop();
                // You can add your delete logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final slot = slots[0]; // Currently displaying the first slot for example

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: widget.onBackPressed,
            ),
            const SizedBox(width: 8),
            const Text(
              'Close Slots',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(  // Make the body scrollable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSlotHeader(slot),
            SizedBox(height: 16),
            _buildFinancialPerformance(slot),
            SizedBox(height: 16),
            _buildFinancialAnalysis(slot),
            SizedBox(height: 16),
            _buildFeedPerformance(slot),
          ],
        ),
      ),
    );
  }

  Widget _buildSlotHeader(Map<String, dynamic> slot) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  slot['slotName'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  slot['weeks'],
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.person_add_alt_1),
                  onPressed: () {
                    // Add your user addition logic here
                  },
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Add your edit logic here
                  },
                ),
                IconButton(
                  icon: Icon(Icons.cancel, color: Colors.red),
                  onPressed: _showDeleteDialog,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 24),
        // Chick information row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildChickInfo("Total Chicks", slot['totalChicks'], Colors.green),
            SizedBox(width: 10),
            _buildChickInfo("Sold", slot['sold'], Colors.orange),
            SizedBox(width: 10),
            _buildChickInfo("Live", slot['live'], Colors.green),
            SizedBox(width: 10),
            _buildChickInfo("Mortality", slot['mortality'], Colors.red),
          ],
        ),
      ],
    ),
  );
}

  Widget _buildChickInfo(String label, int value, Color color) {
    return Row(
      children: [
        Text(
          "$label: ",
          style: TextStyle(fontSize: 10, color: Colors.grey),
        ),
        Text(
          "$value",
          style: TextStyle(fontSize: 10, color: color),
        ),
      ],
    );
  }

  Widget _buildFinancialPerformance(Map<String, dynamic> slot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Financial Performance",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildFinancialTile("₹ ${slot['expenses']}", "Total Expenses"),
            _buildFinancialTile("₹ ${slot['income']}", "Total Income"),
            _buildFinancialTile("₹ ${slot['balance']}", "Net Balance"),
          ],
        ),
      ],
    );
  }

  Widget _buildFinancialTile(String value, String label) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
          color: Color(0xFFF7F8F9)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(fontSize: 8, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialAnalysis(Map<String, dynamic> slot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Financial Analysis",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildFinancialTile("₹ ${slot['costPerBird']}", "Cost per bird"),
            _buildFinancialTile("₹ ${slot['soldBirds']}", "Sold Birds"),
            _buildFinancialTile("₹ ${slot['profitOnBirds']}", "Profit On sold Birds"),
          ],
        ),
      ],
    );
  }

  Widget _buildFeedPerformance(Map<String, dynamic> slot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Feed",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildFinancialTile("${slot['totalFeed']} kg", "Total Feed Consumed"),
            _buildFinancialTile("₹ ${slot['feedCost']}", "Per Bird Feed Cost"),
          ],
        ),
        SizedBox(height: 16),
        Text(
          "Feed Performance",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildFinancialTile("${slot['feedIntake']} gms", "Per Bird Feed Intake/gms"),
            _buildFinancialTile("${slot['bodyWeight']} gms", "Average Body Weight"),
            _buildFinancialTile("${slot['fcr']}", "FCR"),
          ],
        ),
      ],
    );
  }
}
