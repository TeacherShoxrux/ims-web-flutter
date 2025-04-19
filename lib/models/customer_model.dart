// class CustomerModel {
//     List<Datum> data;
//     bool isSuccess;
//     int currentPageIndex;
//     int pageCount;
//     dynamic errorMessage;

//     CustomerModel({
//         required this.data,
//         required this.isSuccess,
//         required this.currentPageIndex,
//         required this.pageCount,
//         required this.errorMessage,
//     });

//     factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//         isSuccess: json["isSuccess"],
//         currentPageIndex: json["currentPageIndex"],
//         pageCount: json["pageCount"],
//         errorMessage: json["errorMessage"],
//     );

//     Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "isSuccess": isSuccess,
//         "currentPageIndex": currentPageIndex,
//         "pageCount": pageCount,
//         "errorMessage": errorMessage,
//     };
// }

class CustomerDataModel {
    int id;
    String name;
    String phone;
    String createdAt;

    CustomerDataModel({
        required this.id,
        required this.name,
        required this.phone,
        required this.createdAt,
    });

    factory CustomerDataModel.fromJson(Map<String, dynamic> json) => CustomerDataModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        createdAt: json["createdAt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "createdAt": createdAt,
    };
}
