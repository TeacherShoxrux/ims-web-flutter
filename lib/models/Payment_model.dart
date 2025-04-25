class PaymentModel {
    int id;
    String paymentMethod;
    int? amount;
    String? customerName;
    String? userFullName;
    String? customerPhone;
    String? createdAt;

    PaymentModel({
        required this.id,
        required this.paymentMethod,
        required this.amount,
        required this.customerName,
        required this.userFullName,
        required this.customerPhone,
        required this.createdAt,
    });

    factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json["id"],
        paymentMethod: json["paymentMethod"],
        amount: json["amount"],
        customerName: json["customerName"],
        userFullName: json['userFullName'],
        customerPhone: json["customerPhone"],
        createdAt: json["createdAt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "paymentMethod": paymentMethod,
        "amount": amount,
        "customerName": customerName,
        "userFullName":userFullName,
        "customerPhone": customerPhone,
        "createdAt": createdAt,
    };
}