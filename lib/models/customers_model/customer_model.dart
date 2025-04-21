
class CustomerDataModel {
    int id;
    String name;
    String phone;
    String createdAt;
    String? info;

    CustomerDataModel({
        required this.id,
        required this.name,
        required this.phone,
        required this.createdAt,
         this.info,
    });

    factory CustomerDataModel.fromJson(Map<String, dynamic> json) => CustomerDataModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        createdAt: json["createdAt"],
        info: json['info']
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "createdAt": createdAt,
        "info":info,
    };
}
