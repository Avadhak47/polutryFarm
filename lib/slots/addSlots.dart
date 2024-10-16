import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateNewSlotScreen extends StatefulWidget {
  final VoidCallback BackPressed;

  CreateNewSlotScreen({Key? key, required this.BackPressed})
      : super(key: key);

  @override
  _CreateNewSlotScreenState createState() => _CreateNewSlotScreenState();
}

class _CreateNewSlotScreenState extends State<CreateNewSlotScreen> {
  DateTime selectedDate = DateTime.now();
  String generatedId = '';
  String selectedBreed = '';
  String selectedSupplier = '';
  int quantity = 0;
  bool isLoading = false;
  bool isSuccess = false;
  // VoidCallback onBackPressed = BackPressed;

  @override
  void initState() {
    super.initState();
    generateId();
  }

  void generateId() {
    // Simple ID generation logic. You might want to implement a more robust system.
    setState(() {
      generatedId =
          'UBIN${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: widget.BackPressed,
        ),
        title: Text('Create New Slot',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16)),
      ),
      body: isLoading
          ? _buildLoadingScreen()
          : isSuccess
              ? _buildSuccessScreen()
              : _buildForm(),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDateField(),
          SizedBox(height: 16),
          _buildIdField(),
          SizedBox(height: 16),
          _buildBreedDropdown(),
          SizedBox(height: 16),
          _buildQuantityField(),
          SizedBox(height: 16),
          _buildSupplierDropdown(),
          SizedBox(height: 32),
          ElevatedButton(
            child: Text('APPLY'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: _submitForm,
          ),
        ],
      ),
    );
  }

  Widget _buildDateField() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Date',
            suffixIcon: Icon(Icons.calendar_today, color: Colors.orange),
            border: OutlineInputBorder(),
          ),
          controller: TextEditingController(
            text: DateFormat('dd MMMM yyyy').format(selectedDate),
          ),
        ),
      ),
    );
  }

  Widget _buildIdField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'ID',
        border: OutlineInputBorder(),
      ),
      controller: TextEditingController(text: generatedId),
      readOnly: true,
    );
  }

  Widget _buildBreedDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Select Breed',
        border: OutlineInputBorder(),
      ),
      value: selectedBreed.isEmpty ? null : selectedBreed,
      onChanged: (String? newValue) {
        setState(() {
          selectedBreed = newValue!;
        });
      },
      items: <String>['Broiler', 'Layer', 'Duck', 'Turkey']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildQuantityField() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Quantity',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            controller: TextEditingController(text: quantity.toString()),
            readOnly: true,
          ),
        ),
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            setState(() {
              if (quantity > 0) quantity--;
            });
          },
        ),
        Text(quantity.toString()),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              quantity++;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSupplierDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Select Supplier',
        border: OutlineInputBorder(),
      ),
      value: selectedSupplier.isEmpty ? null : selectedSupplier,
      onChanged: (String? newValue) {
        setState(() {
          selectedSupplier = newValue!;
        });
      },
      items: <String>['Government', 'Private']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void _submitForm() {
    setState(() {
      isLoading = true;
    });
    // Simulate API call
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
        isSuccess = true;
      });
    });
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Creating new slot...'),
        ],
      ),
    );
  }

  Widget _buildSuccessScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 64),
          SizedBox(height: 16),
          Text(
            'New slot created!!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('New Slot has been successfully created'),
        ],
      ),
    );
  }
}
