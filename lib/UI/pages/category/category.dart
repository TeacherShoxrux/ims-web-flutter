import 'package:flutter/material.dart';
import 'package:ims_web/UI/pages/category/widgets/add_alert.dart';


class CategoryListPage extends StatelessWidget {
  // Ro'yxat uchun ma'lumotlar
  final List<Map<String, String>> categories = [
    {'sr': '1', 'name': 'Category 2'},
    {'sr': '2', 'name': 'Category 1'},
  ];
  void _showAddCategoryDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
      return AddAlert();});}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Fon rangi
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Qidiruv paneli
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Here',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            // Sarlavha va Add New tugmasi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Category List',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _showAddCategoryDialog(context);
                  },
                  icon: Icon(Icons.add),
                  label: Text('Add New'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple, // Tugma rangi
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Ro'yxat sarlavhasi
            Container(
              color: Colors.purple[300],
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Sr#',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Category',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(), // Bo'sh joy ikonlar uchun
                  ),
                ],
              ),
            ),
            // Ro'yxat elementlari
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: index % 2 == 0 ? Colors.white : Colors.grey[100],
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(categories[index]['sr']!),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(categories[index]['name']!),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  // Edit tugmasi bosilganda
                                  print('Edit bosildi: ${categories[index]['name']}');
                                },
                                icon: Icon(Icons.edit, color: Colors.yellow[700]),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Delete tugmasi bosilganda
                                  print('Delete bosildi: ${categories[index]['name']}');
                                },
                                icon: Icon(Icons.delete, color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}