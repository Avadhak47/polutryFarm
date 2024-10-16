import 'package:farm_app/slots/addSlots.dart';
import 'package:farm_app/slots/closedSlotInfo.dart';
import 'package:farm_app/slots/slotsMenu.dart';
import 'package:farm_app/vaccination/add_vac.dart';
import 'package:flutter/material.dart';

class SlotsScreen extends StatefulWidget {
  const SlotsScreen({super.key});

  @override
  _SlotsScreenState createState() => _SlotsScreenState();
}

class _SlotsScreenState extends State<SlotsScreen> {
  bool showSlotMenuScreen = false;
  bool showCreateSlotForm = false;
  bool showClosedSlotDetail = false;
  bool showStatus = true; // Toggle between Status and History
  List<Map<String, dynamic>> Active = [
    {'title': 'Slot 1', 'status': 'alive', 'weeks': '2', 'days': '3'},
    {'title': 'Slot 2', 'status': 'alive', 'weeks': '3', 'days': '5'},
    {'title': 'Slot 3', 'status': 'alive', 'weeks': '7', 'days': '2'},
  ];

  List<Map<String, dynamic>> closed = [
    {'title': 'Slot 1', 'status': 'cleared', 'weeks': '10', 'days': '3'},
    {'title': 'Slot 2', 'status': 'cleared', 'weeks': '10', 'days': '3'},
    {'title': 'Slot 3', 'status': 'cleared', 'weeks': '10', 'days': '3'},
  ];

  @override
  Widget build(BuildContext context) {
    return showCreateSlotForm
        ? CreateNewSlotScreen(BackPressed: _hideCreateSlotForm)
        : showSlotMenuScreen
            ? SlotNameMenuScreen(onBackPressed: _hideSlotMenuForm)
            : showClosedSlotDetail ? SlotDetails(onBackPressed: _hideClosedSlotDetails)
            : Scaffold(
                appBar: AppBar(
                  titleSpacing: 0,
                  title: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Manage Your Slot',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      Spacer(),
                      Text(
                        'Total Slots: ${showStatus ? Active.length : closed.length}', // Replace with dynamic slot count if necessary
                        style: TextStyle(color: Colors.green, fontSize: 14),
                      ),
                      const SizedBox(width: 14)
                    ],
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 17),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => showStatus = true),
                                child: Column(
                                  children: [
                                    Text('Active Slots',
                                        style: TextStyle(
                                            color: showStatus
                                                ? Colors.orange
                                                : Colors.grey,
                                            fontWeight: showStatus
                                                ? FontWeight.bold
                                                : FontWeight.normal)),
                                    const SizedBox(height: 8),
                                    Container(
                                        height: 2,
                                        color: showStatus
                                            ? Colors.orange
                                            : Colors.grey[300]),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => showStatus = false),
                                child: Column(
                                  children: [
                                    Text('Closed Slots',
                                        style: TextStyle(
                                            color: !showStatus
                                                ? Colors.orange
                                                : Colors.grey,
                                            fontWeight: !showStatus
                                                ? FontWeight.bold
                                                : FontWeight.normal)),
                                    const SizedBox(height: 8),
                                    Container(
                                        height: 2,
                                        color: !showStatus
                                            ? Colors.orange
                                            : Colors.grey[300]),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      showStatus && Active.isEmpty
                          ? _buildNoSlotsMessage() // Display message for no active slots
                          : !showStatus && closed.isEmpty
                              ? _buildNoSlotsMessage() // Display message for no closed slots
                              : Container(
                                  height:
                                      400, // Adjust the height based on your screen size
                                  child: ListView.builder(
                                    itemCount: showStatus
                                        ? Active.length
                                        : closed.length,
                                    itemBuilder: (context, index) {
                                      final item = showStatus
                                          ? Active[index]
                                          : closed[index];
                                      return _buildSlotItem(
                                          item['title'],
                                          item['status'],
                                          item['weeks'],
                                          item['days']);
                                    },
                                  ),
                                ),
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () => setState(() => showCreateSlotForm = true),
                  backgroundColor: Colors.orange,
                  shape: const CircleBorder(),
                  child: const Icon(Icons.add, color: Colors.white, size: 28),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endFloat,
              );
  }

  // Widget for the message when no slots are available
  Widget _buildNoSlotsMessage() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 70),
            const Text(
              "No Slot's Created",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Tap on ",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Container(
                  padding: const EdgeInsets.all(
                      2.0), // Add some padding around the icon
                  decoration: BoxDecoration(
                    color: Color(0xFFF29F05), // Background color for the icon
                    shape: BoxShape.circle, // Make the shape circular
                  ),
                  child: const Icon(Icons.add,
                      size: 20,
                      color: Colors.white), // Change icon color to white
                ),
                const Text(
                  " below to create new slots",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlotItem(
      String title, String status, String weeks, String days) {
    return GestureDetector(
      // You can also use InkWell if you prefer a ripple effect
      onTap: () => setState(() => showStatus ? showSlotMenuScreen = true : showClosedSlotDetail = true),
      child: Container(
        padding: const EdgeInsets.all(16),
        color: (status == 'cleared')
            ? const Color(0xFFF1F1F1)
            : const Color(0xFFFFFBF1),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Text("$weeks Weeks, $days Days",
                style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  void _hideCreateSlotForm() {
    setState(() {
      showCreateSlotForm = false;
    });
  }

  void _hideSlotMenuForm() {
    setState(() {
      showSlotMenuScreen = false;
    });
  }

  void _hideClosedSlotDetails() {
    setState(() {
      showClosedSlotDetail = false;
    });
  }
}
