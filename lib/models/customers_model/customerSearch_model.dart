class CustomersearchModel {
  int id;
  String name;
  String phone;
  String info;
  DateTime createdAt;

  CustomersearchModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.info,
    required this.createdAt,
  });

  factory CustomersearchModel.fromJson(Map<String, dynamic> json) =>
      CustomersearchModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        info: json["info"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "info": info,
    "createdAt": createdAt.toIso8601String(),
  };
}
