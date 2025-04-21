class StatisticModel {
    int totalSales;
    int totalProduct;
    int totalCustomer;
    String topProduct;
    int topProductQuantity;

    StatisticModel({
        required this.totalSales,
        required this.totalProduct,
        required this.totalCustomer,
        required this.topProduct,
        required this.topProductQuantity,
    });

    factory StatisticModel.fromJson(Map<String, dynamic> json) => StatisticModel(
        totalSales: json["totalSales"],
        totalProduct: json["totalProduct"],
        totalCustomer: json["totalCustomer"],
        topProduct: json["topProduct"],
        topProductQuantity: json["topProductQuantity"],
    );

    Map<String, dynamic> toJson() => {
        "totalSales": totalSales,
        "totalProduct": totalProduct,
        "totalCustomer": totalCustomer,
        "topProduct": topProduct,
        "topProductQuantity": topProductQuantity,
    };
}