class PaymentChekModel {
  int id;
  String createdAt;
  int amount;
  String paymentMethod;
  int userId;
  Customer customer;
  List<Product> products;

  PaymentChekModel({
    required this.id,
    required this.createdAt,
    required this.amount,
    required this.paymentMethod,
    required this.userId,
    required this.customer,
    required this.products,
  });

  factory PaymentChekModel.fromJson(Map<String, dynamic> json) => PaymentChekModel(
    id: json["id"],
    createdAt:json["createdAt"],
    amount: json["amount"],
    paymentMethod: json["paymentMethod"],
    userId: json["userId"],
    customer: Customer.fromJson(json["customer"]),
    products: List<Product>.from(
      json["products"].map((x) => Product.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt.toString(),
    "amount": amount,
    "paymentMethod": paymentMethod,
    "userId": userId,
    "customer": customer.toJson(),
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Customer {
  int id;
  String name;
  String phone;
  dynamic info;
  dynamic createdAt;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.info,
    required this.createdAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    info: json["info"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "info": info,
    "createdAt": createdAt,
  };
}

class Product {
  int id;
  String name;
  String description;
  dynamic categoryName;
  int salePrice;
  int purchasePrice;
  int quantity;
  String image;
  String? unit;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryName,
    required this.salePrice,
    required this.purchasePrice,
    required this.quantity,
    required this.image,
     this.unit,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    categoryName: json["categoryName"],
    salePrice: json["salePrice"],
    purchasePrice: json["purchasePrice"],
    quantity: json["quantity"],
    image: json["image"],
     unit: json["unit"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "categoryName": categoryName,
    "salePrice": salePrice,
    "purchasePrice": purchasePrice,
    "quantity": quantity,
    "image": image,
    "unit":unit,
  };
}
