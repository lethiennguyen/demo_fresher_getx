class BaseResponse<T> {
  BaseResponse({
    required this.success,
    required this.message,
    required this.data,
  });
  final bool success;
  final String message;
  final T? data;

  factory BaseResponse.fromJson(
    Map<String, dynamic> json, {
    T Function(Map<String, dynamic> x)? func,
  }) {
    T? convertObject() => func != null ? func(json['data']) : json['data'];
    return BaseResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      data: json['data'] != null ? convertObject() : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
      };
}

class ApiResponse<T> {
  final T? data;
  final String? message;
  final String? errorKey;
  final int? statusCode;
  final PagingModel? paging;

  bool get isSuccess => errorKey == null;

  ApiResponse({
    this.data,
    this.message,
    this.errorKey,
    this.statusCode,
    this.paging,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json, {
    T Function(dynamic data)? func,
  }) {
    return ApiResponse(
      data: func != null && json['data'] != null
          ? func(json['data'])
          : json['data'],
      message: json['message'],
      errorKey: json['error_key'],
      statusCode: json['status_code'],
      paging:
          json['paging'] != null ? PagingModel.fromJson(json['paging']) : null,
    );
  }
}

class PagingModel {
  final int? page;
  final int? limit;
  final int? count;

  PagingModel({
    this.page,
    this.limit,
    this.count,
  });

  factory PagingModel.fromJson(Map<String, dynamic> json) {
    return PagingModel(
      page: json['page'],
      limit: json['limit'],
      count: json['count'],
    );
  }
}
