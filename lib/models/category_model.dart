class CategoryModel {
  int id;
  int storeId;
  String name;
  String? description;
  String? image;
  String? createdAt;
  String? updatedAt;

  CategoryModel(
      { required this.id,
        required this.storeId,
        required this.name,
        this.description,
        this.image,
        this.createdAt,
        this.updatedAt});

 factory CategoryModel.fromJson(Map<String, dynamic> json) {
  int  id = json['id'];
  int storeId = json['storeId'];
  String  name = json['name'];
  String?  description = json['description'];
  String?  image = json['image'];
  String?  createdAt = json['createdAt'];
  String?  updatedAt = json['updatedAt'];
  return CategoryModel(id: id, storeId: storeId, name: name,description: description, image: image, createdAt: createdAt,updatedAt:  updatedAt);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['storeId'] = this.storeId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
