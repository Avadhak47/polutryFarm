import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddmortalityScreen extends StatefulWidget {
  final VoidCallback BackPressed;

  AddmortalityScreen({Key? key, required this.BackPressed}) : super(key: key);

  @override
  _AddmortalityScreen createState() => _AddmortalityScreen();
}

class _AddmortalityScreen extends State<AddmortalityScreen> {
  int week = 1;
  int quantity = 0;
  String cause = "Heat";
  bool isLoading = false;
  bool isSuccess = false;
  // VoidCallback onBackPressed = BackPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: widget.BackPressed,
        ),
        title: Text('Mortality',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16)),
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
          _buildWeekDropdown(),
          SizedBox(height: 16),
          _buildQuantityField(),
          SizedBox(height: 16),
          _buildSupplierDropdown(),
          SizedBox(height: 32),
          ElevatedButton(
            child: Text('ADD'),
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


  Widget _buildWeekDropdown() {
  return DropdownButtonFormField<int>(
    decoration: InputDecoration(
      labelText: 'Select week',
      border: OutlineInputBorder(),
    ),
    value: week, // Assuming `week` is an `int`
    onChanged: (int? newValue) {
      setState(() {
        if (newValue != null) {
          week = newValue;
        }
      });
    },
    items: List.generate(10, (index) => index + 1)
        .map<DropdownMenuItem<int>>((int value) {
      return DropdownMenuItem<int>(
        value: value,
        child: Text(value.toString()), // Convert int to string for display
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
      value: cause.isEmpty ? null : cause,
      onChanged: (String? newValue) {
        setState(() {
          cause = newValue!;
        });
      },
      items: <String>['Heat', 'Transport', 'Disease','Unkown']
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
            'Added!!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('New mortality has been successfully added'),
        ],
      ),
    );
  }
}
