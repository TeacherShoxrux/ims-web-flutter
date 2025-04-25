class UserInfoModel {
    int id;
    String phone;
    String fullName;
    String? password;
    String? image;
    String? email;
    String? storeName;
    String? storeImage;
    String? storeAddress;
    String role;

    UserInfoModel({
        required this.id,
        required this.phone,
        required this.fullName,
         this.password,
         this.image,
         this.email,
        required this.role,
        this.storeName,
        this.storeImage,
        this.storeAddress,
    });

    factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        id: json["id"],
        phone: json["phone"],
        fullName: json["fullName"],
        password: json["password"],
        image: json["image"],
        email: json["email"],
        role: json["role"],
        storeName: json["storeName"],
        storeImage: json["storeImage"],
        storeAddress: json["storeAddress"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "fullName": fullName,
        "password": password,
        "image": image,
        "email": email,
        "role": role,
    };
}
