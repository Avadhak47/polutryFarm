import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddVaccineDetailsScreen extends StatefulWidget {
  @override
  _AddVaccineDetailsScreenState createState() => _AddVaccineDetailsScreenState();
}

class _AddVaccineDetailsScreenState extends State<AddVaccineDetailsScreen> {
  DateTime? selectedDate;
  String? selectedSlot;
  String? selectedVaccine;

  // Static data (replace with API data in the future)
  final List<String> slotNames = ['Morning', 'Afternoon', 'Evening'];
  final List<String> vaccineNames = ['Vaccine A', 'Vaccine B', 'Vaccine C'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Add vaccine details', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildDatePicker(),
            SizedBox(height: 16),
            _buildDropdown('Slot Name', selectedSlot, slotNames, (value) => setState(() => selectedSlot = value)),
            SizedBox(height: 16),
            _buildDropdown('Vaccine name', selectedVaccine, vaccineNames, (value) => setState(() => selectedVaccine = value)),
            Spacer(),
            _buildAddButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextField(
          decoration: InputDecoration(
            hintText: selectedDate == null ? 'Date' : DateFormat('dd/MM/yyyy').format(selectedDate!),
            suffixIcon: Icon(Icons.calendar_today, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String hint, String? value, List<String> items, Function(String?) onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(hint),
          value: value,
          icon: Icon(Icons.arrow_drop_down, color: Colors.orange),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: Text('ADD', style: TextStyle(fontSize: 16)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: _addVaccineDetails,
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _addVaccineDetails() {
    if (selectedDate != null && selectedSlot != null && selectedVaccine != null) {
      final vaccineDetails = {
        'date': DateFormat('dd/MM/yyyy').format(selectedDate!),
        'slotName': selectedSlot,
        'vaccineName': selectedVaccine,
      };
      print(vaccineDetails); // Print to console
      // TODO: Send data to API or store locally
      Navigator.of(context).pop(); // Return to previous screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }
}