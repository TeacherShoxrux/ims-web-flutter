class UselAllModel {
    int id;
    String phone;
    String fullName;
    dynamic password;
    dynamic image;
    String role;

    UselAllModel({
        required this.id,
        required this.phone,
        required this.fullName,
        required this.password,
        required this.image,
        required this.role,
    });

    factory UselAllModel.fromJson(Map<String, dynamic> json) => UselAllModel(
        id: json["id"],
        phone: json["phone"],
        fullName: json["fullName"],
        password: json["password"],
        image: json["image"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "fullName": fullName,
        "password": password,
        "image": image,
        "role": role,
    };
}