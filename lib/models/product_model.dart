class ProductModel {
  int id;
  String name;
  String? description;
  num salePrice;
  num purchasePrice;
  int quantity;
  String? image;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.salePrice,
    required this.purchasePrice,
    required this.quantity,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    int id = json['id'];
    String name = json['name'];
    String? description = json['description'];
    double salePrice = json['salePrice'];
    double purchasePrice = json['purchasePrice'];
    int quantity = json['quantity'];
    String? image = json['image'];
    return ProductModel(
      id: id,
      name: name,
      description: description,
      salePrice: salePrice,
      purchasePrice: purchasePrice,
      quantity: quantity,
      image: image,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['salePrice'] = salePrice;
    data['purchasePrice'] = purchasePrice;
    data['quantity'] = quantity;
    data['image'] = image;
    return data;
  }
}
