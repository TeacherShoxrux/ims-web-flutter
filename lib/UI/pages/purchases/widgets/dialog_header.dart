// Dialogning yuqori qismi widgeti
import 'package:flutter/material.dart';

import 'customer_picker.dart';

class DialogHeaderWidget extends StatelessWidget {
  final List<Map<String, String>> customers;
  final Function(String) onCustomerSelected;
  final VoidCallback onClear;
  final VoidCallback onSave;

  DialogHeaderWidget({
    required this.customers,
    required this.onCustomerSelected,
    required this.onClear,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: Text(
            '15/10/2022',
            style: TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: CustomerSearchWidget(
            customers: customers,
            onCustomerSelected: onCustomerSelected,
          ),
        ),
        SizedBox(width: 16),
        ElevatedButton(
          onPressed: onSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
          ),
          child: Text('SAVE'),
        ),
        SizedBox(width: 8),
        ElevatedButton(
          onPressed: onClear,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: Text('Clear'),
        ),
      ],
    );
  }
}