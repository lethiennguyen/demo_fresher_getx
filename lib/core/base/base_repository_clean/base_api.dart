import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import '../../../shared/constants/const.src.dart';
import '../../values/const.dart';
import '../../values/key.dart';

class EnumRequestMethod {
  ///các type request API
  static const String POST = "POST";

  static const String GET = "GET";

  static const String DELETE = "DELETE";

  static const String PUT = "PUT";
}

class BaseApi {
  static final BaseApi _singleton = BaseApi._();

  factory BaseApi() => _singleton;

  BaseApi._();

  static Dio dio = getBaseDio();

  static Dio getBaseDio() {
    Dio dio = Dio();

    dio.options = buildDefaultOptions();

    return dio;
  }

  static BaseOptions buildDefaultOptions() {
    return BaseOptions()
      ..connectTimeout = AppConst.requestTimeOut
      ..receiveTimeout = AppConst.requestTimeOut;
  }

  static void close() {
    dio.close(force: true);
    updateCurrentDio();
  }

  static void updateCurrentDio() {
    dio = getBaseDio();
  }

  static Dio getCurrentDio() {
    return dio;
  }

  void setOnErrorListener(Function(Object error) onErrorCallBack) {
    this.onErrorCallBack = onErrorCallBack;
  }

  late Function(Object error) onErrorCallBack;

  /// [isQueryParametersPost]: `true`: phương thức post gửi params, mặc định = `false`
  ///
  /// [dioOptions]: option của Dio() sử dụng khi gọi api có option riêng
  ///
  /// [functionError]: chạy function riêng khi request xảy ra Exception (mặc định sử dụng [showDialogError])
  Future<dynamic> sendRequest(
    String action,
    String requestMethod, {
    dynamic jsonMap,
    bool isDownload = false,
    String? urlOther,
    Map<String, String>? headersUrlOther,
    bool isQueryParametersPost = false,
    BaseOptions? dioOptions,
    Function(Object error)? functionError,
    bool isToken =
        true, // mặc định request nào cũng cần token, login thì set false
    bool isHaveVersion = true,
    bool getHeader = false,
    Duration? timeOut,
    CancelToken? cancelToken,
    // Map<String, String>? headerAdds,
  }) async {
    dio.options = dioOptions ?? buildDefaultOptions();

    final Response response;

    final String url = urlOther ?? (ApiUrl.baseUrl + action);

    final Map<String, String> headers =
        headersUrlOther ?? await getBaseHeader();
    final Options options = isDownload
        ? Options(
            headers: headers,
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status != null && status < 500;
            })
        : Options(
            headers: headers,
            method: requestMethod.toString(),
            responseType: ResponseType.json,
          );

    try {
      if (requestMethod == EnumRequestMethod.POST) {
        if (isQueryParametersPost) {
          response = await dio.post(
            url,
            queryParameters: jsonMap,
            options: options,
            cancelToken: cancelToken,
          );
        } else {
          response = await dio.post(
            url,
            data: jsonMap,
            options: options,
            cancelToken: cancelToken,
          );
        }
      } else if (requestMethod == EnumRequestMethod.DELETE) {
        response = await dio.delete(
          url,
          queryParameters: jsonMap,
          options: options,
          cancelToken: cancelToken,
        );
      } else if (requestMethod == EnumRequestMethod.PUT) {
        if (isQueryParametersPost) {
          response = await dio.put(
            url,
            queryParameters: jsonMap,
            options: options,
            cancelToken: cancelToken,
          );
        } else {
          response = await dio.put(
            url,
            data: jsonMap,
            options: options,
            cancelToken: cancelToken,
          );
        }
      } else {
        response = await dio.get(
          url,
          queryParameters: jsonMap,
          options: options,
          cancelToken: cancelToken,
        );
      }
      if (getHeader) {
        return response.headers.map;
      } else {
        return response;
      }
    } catch (e) {
      //return functionError != null ? functionError(e) : showDialogError(e);
      print(e);
    }
  }

  // dynamic showDialogError(dynamic e) {
  //   if (e.response != null && e.response is Map) {
  //     return e.response;
  //   }
  //   onErrorCallBack(e);
  // }

  Future<Map<String, String>> getBaseHeader() async {
    //final String token = HIVE_APP.get(AppKey.keyToken, defaultValue: '');
    final authBox = await Hive.openBox(HiveBoxNames.auth);
    final String token = authBox.get(HiveKeys.token, defaultValue: '');
    if (token.isNotEmpty) {
      return {
        "Content-Type": "application/json",
        "Authorization": token,
      };
    }

    return {
      "Content-Type": "application/json",
    };
  }
}
