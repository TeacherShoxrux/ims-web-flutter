// Mijozlarni qidirish va tanlash widgeti
import 'package:flutter/material.dart';

class CustomerSearchWidget extends StatefulWidget {
  final List<Map<String, String>> customers;
  final Function(String) onCustomerSelected;

  CustomerSearchWidget({required this.customers, required this.onCustomerSelected});

  @override
  _CustomerSearchWidgetState createState() => _CustomerSearchWidgetState();
}

class _CustomerSearchWidgetState extends State<CustomerSearchWidget> {
  String selectedCustomer = 'Cash';
  List<Map<String, String>> filteredCustomers = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCustomers = widget.customers;
    searchController.addListener(_filterCustomers);
  }

  void _filterCustomers() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredCustomers = widget.customers
          .where((customer) => customer['name']!.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search Customer',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedCustomer,
          items: filteredCustomers.map((customer) {
            return DropdownMenuItem<String>(
              value: customer['name'],
              child: Text(customer['name']!),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedCustomer = newValue!;
              widget.onCustomerSelected(selectedCustomer);
            });
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}