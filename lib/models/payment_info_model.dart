class PaymentInfoModel {
  final Data? data;
  final bool isSuccess;
  final int currentPageIndex;
  final int pageCount;
  final String? errorMessage;

  PaymentInfoModel({
    required this.data,
    required this.isSuccess,
    required this.currentPageIndex,
    required this.pageCount,
    this.errorMessage,
  });

  factory PaymentInfoModel.fromJson(Map<String, dynamic> json) {
    return PaymentInfoModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      isSuccess: json['isSuccess'] ?? false,
      currentPageIndex: json['currentPageIndex'] ?? 0,
      pageCount: json['pageCount'] ?? 0,
      errorMessage: json['errorMessage'],
    );
  }
}

class Data {
  final int id;
  final String createdAt;
  final double amount;
  final String paymentMethod;
  final int? userId;
  final Customer customer;
  final List<Product> products;

  Data({
    required this.id,
    required this.createdAt,
    required this.amount,
    required this.paymentMethod,
    required this.userId,
    required this.customer,
    required this.products,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      createdAt: json['createdAt'],
      amount: (json['amount'] as num).toDouble(),
      paymentMethod: json['paymentMethod'],
      userId: json['userId'],
      customer: Customer.fromJson(json['customer']),
      products: (json['products'] as List)
          .map((e) => Product.fromJson(e))
          .toList(),
    );
  }
}

class Customer {
  final int id;
  final String? name;
  final String? phone;
  final String? info;
  final String? createdAt;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    this.info,
    this.createdAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      info: json['info'],
      createdAt: json['createdAt'],
    );
  }
}

class Product {
  final int id;
  final String name;
  final String? description;
  final String? categoryName;
  final double? salePrice;
  final double? purchasePrice;
  final int? quantity;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.description,
    this.categoryName,
    required this.salePrice,
    required this.purchasePrice,
    required this.quantity,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      categoryName: json['categoryName'],
      salePrice: (json['salePrice'] as num).toDouble(),
      purchasePrice: (json['purchasePrice'] as num).toDouble(),
      quantity: json['quantity'],
      image: json['image'],
    );
  }
}
