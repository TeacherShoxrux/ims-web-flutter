import 'package:flutter/material.dart';
import 'package:ims_web/UI/pages/category/widgets/add_alert.dart';
import 'package:ims_web/UI/pages/category/widgets/delete_category_alert.dart';

import '../../../services/category_service.dart';


class CategoryListPage extends StatefulWidget {
  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  final categroyService= CategoryService();

  void _showAddCategoryDialog(BuildContext context)async {
   var result= await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
      return AddAlert(categoryService: categroyService,);});
  if(result==true)
    {
      setState(() {
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Fon rangi
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Qidirish',
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
                  "Kategoriyalar ro'yhati",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async{
                    _showAddCategoryDialog(context);
                  },
                  icon: Icon(Icons.add),
                  label: Text("Kategoriya qo'shish"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple, // Tugma rangi
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              color: Colors.purple[300],
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'N#',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Kategoriya',
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
              child: FutureBuilder(
                future: categroyService.getAllCategories(),
                builder: (context,snapshot) {
                  if(snapshot.hasData) {
                    return ListView.builder(
                    itemCount: snapshot.data?.length??0,
                    itemBuilder: (context, index) {
                      return Container(
                        color: index % 2 == 0 ? Colors.white : Colors.grey[100],
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text("${index+1}"),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text( snapshot.data?[index].name??'null'),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      // Edit tugmasi bosilganda
                                      // print('Edit bosildi: ${categories[index]['name']}');
                                    },
                                    icon: Icon(Icons.edit, color: Colors.yellow[700]),
                                  ),
                                  IconButton(
                                    onPressed: ()async {
                                    var confirm= await  showDeleteConfirmationDialog(context,snapshot.data?[index].name??'null');
                                    if(confirm){
                                      var success= await categroyService.deleteCategory(snapshot.data?[index].id??0);
                                      if(success){
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Kategoriya o‘chirildi")),
                                        );
                                        setState(() {

                                        });
                                      }
                                    }
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
                  );
                  }
                  return Center(child: CircularProgressIndicator(),);
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}