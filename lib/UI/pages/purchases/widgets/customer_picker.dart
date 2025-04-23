// Mijozlarni qidirish va tanlash widgeti
import 'package:flutter/material.dart';
import 'package:ims_web/models/customers_model/customerSearch_model.dart';
import 'package:ims_web/services/customer_service.dart';

class CustomerSearchWidget extends StatefulWidget {
  final Function(String) onChangedSearchCustomer;
  final List<CustomersearchModel> customers;
  final Function(CustomersearchModel)? onCustomerSelected;
  final void Function(CustomersearchModel)? onSelected;
  //final List<CustomersearchModel> customer;
  const CustomerSearchWidget({
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
    // searchController.addListener(_filterCustomers);
  }

  void _filterCustomers() async {
    // String query = searchController.text.toLowerCase();
    // filteredCustomers =
  }

  @override
  void dispose() {
    // searchController.dispose();
    super.dispose();
  }

  CustomersearchModel? selection;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Autocomplete<CustomersearchModel>(
          optionsBuilder: (textEditingValue) async {
            if (textEditingValue.text.isEmpty) {
              return Iterable<CustomersearchModel>.empty();
            } else {
              await Future.delayed(Duration(seconds: 1));
              return await customerService.searchAllCustomer(
                text: textEditingValue.text,
              );
            }
          },
          displayStringForOption: (CustomersearchModel customer) {
            return customer.name;
          },
          onSelected: (CustomersearchModel selection) {
            print(selection);
            searchController.text = selection.name;
            widget.onCustomerSelected!(selection);
            if (widget.onSelected != null) {
              widget.onSelected!(selection);
            }
          },
          optionsViewBuilder: (BuildContext context,Function(CustomersearchModel) onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 400,
                  ), // bu yerda width nazorat qilinadi
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      // final String option = options.elementAt(index);
                      return ListTile(
                        title: Text(
                          options.elementAt(index).name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text("(${options.elementAt(index).phone})"),
                        onTap: ()=> onSelected(options.elementAt(index))
                      );
                    },
                  ),
                ),
              ),
            );
          },
          fieldViewBuilder: fieldViewBuilder
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
            // setState(() {
            //   selectedCustomer = newValue!;
            //   widget.onCustomerSelected!(selectedCustomer as CustomersearchModel);
            // });
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }

  Widget fieldViewBuilder(
    BuildContext context,
    TextEditingController textEditingController,
    FocusNode focusNode,
    VoidCallback onFieldSubmitted,
  ) {
    return TextField(
      controller: textEditingController,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: 'Mijoz qidirish',
        hintText: 'Izlash',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
    );
  }
}
