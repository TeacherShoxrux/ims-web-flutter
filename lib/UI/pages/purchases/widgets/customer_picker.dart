// Mijozlarni qidirish va tanlash widgeti
import 'package:flutter/material.dart';
import 'package:ims_web/models/customers_model/customerSearch_model.dart';
import 'package:ims_web/services/customer_service.dart';

class CustomerSearchWidget extends StatefulWidget {
  final Function(String) onChangedSearchCustomer;
  final List<CustomersearchModel> customers;
  final Function(String) onCustomerSelected;
  final void Function(CustomersearchModel)? onSelected;
  //final List<CustomersearchModel> customer;
  CustomerSearchWidget({
    required this.customers,
    required this.onCustomerSelected,
    required this.onChangedSearchCustomer,
    //required this.customer,
    this.onSelected,
  });

  @override
  _CustomerSearchWidgetState createState() => _CustomerSearchWidgetState();
}

class _CustomerSearchWidgetState extends State<CustomerSearchWidget> {
  String selectedCustomer = 'Cash';
  List<CustomersearchModel> filteredCustomers = [];
  TextEditingController searchController = TextEditingController();
  final customerService = CustomerService();

  @override
  void initState() {
    super.initState();
    filteredCustomers = widget.customers;
    searchController.addListener(_filterCustomers);
  }

  void _filterCustomers() async {
    String query = searchController.text.toLowerCase();
    filteredCustomers = await customerService.searchAllCustomer(text: query);

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
        Autocomplete<CustomersearchModel>(
          optionsBuilder: (textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return Iterable<CustomersearchModel>.empty();
            } else {
              return filteredCustomers.where(
                (customer) => customer.name.toLowerCase().contains(
                  textEditingValue.text.toLowerCase(),
                ),
              );
            }
          },
          displayStringForOption: (CustomersearchModel customer) {
            return customer.name;
          },
          onSelected: (CustomersearchModel selection) {
            searchController.text = selection.name;
            widget.onCustomerSelected(selection.name);
            if (widget.onSelected != null) {
              widget.onSelected!(selection);
            }
          },
          fieldViewBuilder: (
            context,
            textEditingController,
            focusNode,
            onFieldSubmitted,
          ) {
            return TextField(
              onChanged: (value) {
                _filterCustomers();
              },
              controller: searchController,
              focusNode: focusNode,
              onEditingComplete: onFieldSubmitted,
              decoration: InputDecoration(
                hintText: 'Search Customer',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
          optionsViewBuilder: (context, onSelected, options) {
            return Material(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final customer = options.elementAt(index);
                  return ListTile(title: Text(customer.name));
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: 5,
              ),
            );
          },
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedCustomer,
          items:
              filteredCustomers.map((customer) {
                return DropdownMenuItem<String>(
                  value: customer.name,
                  child: Text(customer.name!),
                );
              }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedCustomer = newValue!;
              widget.onCustomerSelected(selectedCustomer);
            });
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}
