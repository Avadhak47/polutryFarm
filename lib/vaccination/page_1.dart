import 'package:farm_app/vaccination/add_vac.dart';
import 'package:flutter/material.dart';

class VaccinationScreen extends StatefulWidget {
  @override
  _VaccinationScreenState createState() => _VaccinationScreenState();
}

class _VaccinationScreenState extends State<VaccinationScreen> {
  bool showStatus = true; // Toggle between Status and History
  final List<Map<String, dynamic>> statusItems = [
    {'title': 'Vaccination 1', 'date': '14/07/2024', 'status': 'Vaccine Done', 'bgColor': Colors.grey[200]},
    {'title': 'Vaccination 2', 'date': '14/07/2024', 'status': '5 days left', 'bgColor': Colors.yellow[50]},
    {'title': 'Vaccination 3', 'date': '14/07/2024', 'status': '20 days left', 'bgColor': Colors.white},
  ];

  final List<Map<String, dynamic>> historyItems = [
    {'title': 'Past Vaccination 1', 'date': '14/06/2024', 'status': 'Completed', 'bgColor': Colors.grey[200]},
    {'title': 'Past Vaccination 2', 'date': '14/05/2024', 'status': 'Completed', 'bgColor': Colors.grey[200]},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Vaccination', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: 'S001',
                  items: [
                    DropdownMenuItem(value: 'S001', child: Text('S001')),
                  ],
                  onChanged: (String? newValue) {},
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => showStatus = true),
                    child: Column(
                      children: [
                        Text('Status',
                            style: TextStyle(
                                color: showStatus ? Colors.orange : Colors.grey,
                                fontWeight: showStatus ? FontWeight.bold : FontWeight.normal
                            )
                        ),
                        SizedBox(height: 8),
                        Container(
                            height: 2,
                            color: showStatus ? Colors.orange : Colors.grey[300]
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => showStatus = false),
                    child: Column(
                      children: [
                        Text('History',
                            style: TextStyle(
                                color: !showStatus ? Colors.orange : Colors.grey,
                                fontWeight: !showStatus ? FontWeight.bold : FontWeight.normal
                            )
                        ),
                        SizedBox(height: 8),
                        Container(
                            height: 2,
                            color: !showStatus ? Colors.orange : Colors.grey[300]
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: showStatus ? statusItems.length : historyItems.length,
              itemBuilder: (context, index) {
                final item = showStatus ? statusItems[index] : historyItems[index];
                return _buildVaccinationItem(
                  item['title'],
                  item['date'],
                  item['status'],
                  item['bgColor'] ?? Colors.white,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddVaccineDetailsScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
      )
      ,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildVaccinationItem(String title, String date, String status, Color bgColor) {
    return Container(
      padding: EdgeInsets.all(16),
      color: bgColor,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(date, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Text(status, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}