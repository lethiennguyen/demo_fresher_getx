import 'dart:convert';

class ListProductRequestModel {
  final int? categoryId;
  final String? keyword;
  final int? page;
  final int? pageSize;
  ListProductRequestModel(
      {this.categoryId, this.keyword, this.page, this.pageSize});

  ListProductRequestModel copyWith({
    int? categoryId,
    String? keyword,
    int? page,
    int? pageSize,
  }) {
    return ListProductRequestModel(
      categoryId: categoryId ?? this.categoryId,
      keyword: keyword ?? this.keyword,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  factory ListProductRequestModel.fromJson(Map<String, dynamic> json) {
    return ListProductRequestModel(
      categoryId: json["id"],
      keyword: json["keyword"],
      page: json["page"],
      pageSize: json["pageSize"],
    );
  }
  Map<String, dynamic> toJson() => {
        "id": categoryId,
        "keyword": keyword,
        "page": page,
        "pageSize": pageSize,
      };
}
