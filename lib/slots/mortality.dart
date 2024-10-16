import 'package:farm_app/slots/addMortality.dart';
import 'package:flutter/material.dart';

class MortalityScreen extends StatefulWidget {
  final VoidCallback onBackPressed;

  MortalityScreen({Key? key, required this.onBackPressed}) : super(key: key);

  @override
  _MortalityScreenState createState() => _MortalityScreenState();
}

class _MortalityScreenState extends State<MortalityScreen> {
  bool showAddMortality = false;

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final List<MortalityEntry> entries = [
      MortalityEntry(date: "19/11/2022", birds: 4, cause: "heat"),
      MortalityEntry(date: "19/11/2022", birds: 4, cause: "heat"),
      MortalityEntry(date: "19/11/2022", birds: 4, cause: "heat"),
    ];

    int totalMortality = entries.fold(0, (sum, entry) => sum + entry.birds);
    double mortalityPercentage =
        (totalMortality / 100) * 100; // Assuming 100 total birds

    return showAddMortality
        ? AddmortalityScreen(BackPressed: _hideMortalityForm)
        : Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: widget.onBackPressed,
              ),
              title: Text(
                'Mortality',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  _buildSortingAndTotals(totalMortality, mortalityPercentage),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      child: ListView.separated(
                        itemCount: entries.length,
                        itemBuilder: (context, index) =>
                            _buildListItem(entries[index]),
                        separatorBuilder: (context, index) =>
                            const Divider(height: 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => setState(() => showAddMortality = true),
              backgroundColor: Colors.orange,
              shape: const CircleBorder(),
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endFloat,
          );
  }

  Widget _buildSortingAndTotals(int totalMortality, double mortalityPercentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Dropdown button
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4.5),
            child: DropdownButton<String>(
              value: "Weekly",
              underline: SizedBox(),
              isDense: true,
              items: ["Weekly", "Monthly", "Yearly"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(fontSize: 11)),
                );
              }).toList(),
              onChanged: (_) {},
            ),
          ),
          // Total Mortality
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text("Total Mortality: $totalMortality",
                style: TextStyle(fontSize: 11)),
          ),
          // Mortality Percentage
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
                "Mortality %: ${mortalityPercentage.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(MortalityEntry entry) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(entry.date, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 4),
              Text("${entry.birds} Birds",
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
          Text("Cause: ${entry.cause}",
              style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  void _hideMortalityForm() {
    setState(() {
      showAddMortality = false;
    });
  }
}

class MortalityEntry {
  final String date;
  final int birds;
  final String cause;

  MortalityEntry({required this.date, required this.birds, required this.cause});
}
