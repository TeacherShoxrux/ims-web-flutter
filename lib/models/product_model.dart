class ProductModel {
  int id;
  String name;
  String? description;
  int salePrice;
  int purchasePrice;
  int quantity;
  int quantityPay = 1;
  String? image;
  String? categoryName;
 // String uint;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.salePrice,
    required this.purchasePrice,
    required this.quantity,
    required this.image,
    required this.categoryName,
   // required this.uint,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    int id = json['id'];
    String name = json['name'];
    String? description = json['description'];
    int salePrice = json['salePrice'];
    int purchasePrice = json['purchasePrice'];
    int quantity = json['quantity'];
    String? image = json['image'];
    String? categoryName = json['categoryName'];
   // String unit = json['unit'];
    return ProductModel(
      id: id,
      name: name,
      description: description,
      salePrice: salePrice,
      purchasePrice: purchasePrice,
      quantity: quantity,
      image: image,
      categoryName: categoryName,
      //uint: unit,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    // data['name'] = name;
    data['description'] = description;
    data['price'] = salePrice;
    // data['purchasePrice'] = purchasePrice;
    data['quantity'] = quantityPay;
    // data['image'] = image;
    //data['unit']=uint;
    return data;
  }
}
