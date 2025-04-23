class BaseModel<T>{
  final T? data;
  final bool isSuccess;
  final int currentPageIndex;
  final int pageCount;
  final String? errorMessage;

  BaseModel({
    required this.data,
    required this.isSuccess,
    required this.currentPageIndex,
    required this.pageCount,
    this.errorMessage,
  });

  factory BaseModel.fromJson(
      Map<String, dynamic> json,
      T Function(dynamic json) fromJsonT,
      ) {
    return BaseModel<T>(
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      isSuccess: json['isSuccess'] ?? false,
      currentPageIndex: json['currentPageIndex'] ?? 0,
      pageCount: json['pageCount'] ?? 0,
      errorMessage: json['errorMessage'],
    );
  }
}