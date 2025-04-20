import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ims_web/models/userInfo_model.dart';
import 'package:ims_web/routes/urls.dart';
import 'package:ims_web/services/auth_service.dart';
import 'package:ims_web/services/product_service.dart';

class CustomSidebar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  CustomSidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  State<CustomSidebar> createState() => _CustomSidebarState();
}

class _CustomSidebarState extends State<CustomSidebar> {
  final List<Map<String, dynamic>> menuItems = const [
    {'icon': Icons.home, 'label': 'Bosh sahifa'},
    {'icon': Icons.category, 'label': 'Kategoriyalar'},
    {'icon': Icons.shopping_bag, 'label': 'Mahsulotlar'},
    {'icon': Icons.shopping_cart_checkout, 'label': 'Mijozlar'},
    // {'icon': Icons.local_shipping, 'label': 'Supplier'},
    {'icon': Icons.lock, 'label': "To'lovlar"},
    // {'icon': Icons.sell, 'label': 'Sales'},
    {'icon': Icons.person, 'label': 'Ishchilar'},
    {'icon': Icons.insert_chart, 'label': 'Hisoblatlar'},
  ];

  final authservice = AuthService();
  final productService = ProductService();

  PlatformFile? image;

  String? imageUrl;

  Future<void> pickImageWeb() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    PlatformFile? file = result?.files.first;

    if (file != null) {
      image = file;
      //
      // if (kDebugMode) {
      //   print("-----------------------------------------------------------------------------------");
      //   imageUrl=await uploadImage();
      //   print(imageUrl);
      //   print("-----------------------------------------------------------------------------------");
      // }
      setState(() {});
    }
  }

  Future<String?> uploadImage() async {
    if (image != null) {
      return await productService.uploadImage(image!);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: const BoxDecoration(
        color: Color(0xFF6A5AE0),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: FutureBuilder(
        future: authservice.getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () async {
                    await pickImageWeb();
                    var imagePath = await uploadImage();
                    await authservice.updateImageUser({
                      "image": imagePath,
                      "email": snapshot.data?.email ?? 'null',
                    });
                    setState(() {});
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      "${Urls.baseUrlImage}/${snapshot.data?.image}",
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  snapshot.data?.fullName ?? 'null',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const Divider(color: Colors.white54, height: 30),
                // Dynamic menu generation
                for (int i = 0; i < menuItems.length; i++)
                  menuItem(
                    icon: menuItems[i]['icon'],
                    title: menuItems[i]['label'],
                    isSelected: i == widget.selectedIndex,
                    onTap: () => widget.onItemSelected(i),
                  ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget menuItem({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white24 : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(title, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

extension on List<UserInfoModel>? {
  get fullName => null;
}
