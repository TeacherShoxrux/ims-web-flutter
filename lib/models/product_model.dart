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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['salePrice'] = this.salePrice;
    data['purchasePrice'] = this.purchasePrice;
    data['quantity'] = this.quantity;
    data['image'] = this.image;
    return data;
  }
}
