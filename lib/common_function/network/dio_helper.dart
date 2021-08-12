import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as main;
import 'package:injectable/injectable.dart';
import 'package:paytack/common_function/network/response_success.dart';
import 'package:paytack/common_function/secure_storage.dart';
import 'global_file.dart';

enum Method { GET, POST, DELETE, PUT, HEAD, PATCH }

const MethodValues = {
  Method.GET: 'get',
  Method.POST: 'post',
  Method.DELETE: 'delete',
  Method.PUT: 'put',
  Method.HEAD: 'head',
  Method.PATCH: 'patch'
};

typedef HttpSuccessCallback<T> = void Function(T data);
typedef HttpFailureCallback = void Function(ErrorEntity data);

final CancelToken _cancelToken = new CancelToken();

_parseAndDecode(String response) {
  return jsonDecode(response);
}

_parseJson(String text) {
  return compute(_parseAndDecode, text);
}

final apiBaseHelper = DioHelper();

@injectable
class DioHelper {
  Future request<T>(
      {String baseUrl = '',
      Method method = Method.GET,
      String path = '',
      Map<String, String>? headers,
      Options? options,
      String contentType = Headers.jsonContentType,
      dynamic data, //Stream.fromIterable(data.map((e) => [e]))
      Map<String, dynamic>? parameter,
      @required HttpSuccessCallback<T>? success,
      @required HttpFailureCallback? error}) async {
    var response;
    if (!await checkNetworkConnectivity()) {
      return success;
    }
    try {
      final baseOptions = BaseOptions(
          baseUrl: Uri.encodeFull(baseUrl),
          contentType: contentType,
          headers: headers,
          //responseType: ResponseType.bytes,
          receiveDataWhenStatusError: false,
          connectTimeout: 60000,
          receiveTimeout: 3000);

      final dio = Dio(baseOptions)
        ..interceptors.addAll(getDefaultInterceptor());

      Options requestOptions = options ?? Options();
      requestOptions.headers = requestOptions.headers ?? Map();
      final token = await CommonStorage.readSecureStorageData("access_token");
      if (token != null) {
        print(token);
        print("token");
        headers = {'Authorization': 'Bearer $token'};
        requestOptions.headers!.addAll(headers);
      }

      // TODO COOKIE MANAGE
      /*
        CookieJar cookieJar = CookieJar();
        dio.interceptors.add(CookieManager(cookieJar));
      */

      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          return true;
        };
      };

      (dio.transformer as DefaultTransformer).jsonDecodeCallback = _parseJson;
      switch (method) {
        case Method.GET:
          response = await dio.get(
            baseUrl,
            options: Options(
              headers: headers,
            ),
          );
          break;
        case Method.POST:
          response = await dio.post(
            baseUrl,
            data: json.encode(parameter),
            options: Options(
              headers: headers,
            ),
          );
          break;
        case Method.PUT:
          response = await dio.put(
            baseUrl,
            data: parameter,
            options: Options(
              headers: headers,
            ),
          );
          break;
        case Method.DELETE:
          response = await dio.delete(
            baseUrl,
            data: parameter,
            options: Options(
              headers: headers,
            ),
          );

          break;
        default:
      }

      if (success != null) {
        success(response.data);
      }

      return response.data;
    } on DioError catch (e) {
      error!(_getError(e));
    }
  }

  // REQUEST CANCEL
  cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  // LOG DISPLAY
  List<Interceptor> getDefaultInterceptor() {
    return [LogInterceptor(requestBody: true, responseBody: true)];
  }

  /// AUTHORIZATION HEADER
  Future<Map<String, dynamic>> getAuthorizationHeader() async {
    Map<String, dynamic>? headers;
    final token = await CommonStorage.readSecureStorageData("access_token");
    if (token != null) {
      headers = {'Authorization': 'Bearer $token'};
    }
    return headers!;
  }

  ErrorEntity _getError(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        return ErrorEntity(code: -1, message: 'dioRequestCancellation'.tr);
        break;
      case DioErrorType.connectTimeout:
        {
          return ErrorEntity(code: -1, message: 'dioConnectionTimeOut'.tr);
        }
        break;
      case DioErrorType.sendTimeout:
        {
          return ErrorEntity(code: -1, message: 'dioRequestTimeOut'.tr);
        }
        break;
      case DioErrorType.receiveTimeout:
        {
          return ErrorEntity(code: -1, message: 'dioResponseTimeout'.tr);
        }
        break;
      case DioErrorType.response:
        {
          try {
            int? errCode = error.response!.statusCode;
            switch (errCode) {
              case 400:
                return ErrorEntity(
                    code: errCode, message: 'dioRequestSyntaxError'.tr);
                break;
              case 403:
                return ErrorEntity(
                    code: errCode, message: 'dioServerRefusedToExecute'.tr);
                break;
              case 404:
                return ErrorEntity(
                    code: errCode, message: 'dioNotConnectServer'.tr);
                break;
              case 405:
                return ErrorEntity(
                    code: errCode, message: 'dioRequestForbidden'.tr);
                break;
              case 500:
                return ErrorEntity(
                    code: errCode, message: 'dioServerInternalError'.tr);
                break;
              case 502:
                return ErrorEntity(
                    code: errCode, message: 'dioInvalidRequest'.tr);
              case 503:
                return ErrorEntity(code: errCode, message: 'dioServerDown'.tr);
                break;
              case 505:
                return ErrorEntity(
                    code: errCode, message: 'dioHttpNotSupport'.tr);
                break;
              default:
                return ErrorEntity(
                    code: errCode, message: 'dioUnknownMistake'.tr);
            }
          } on Exception catch (_) {
            return ErrorEntity(code: -1, message: 'dioUnknownError'.tr);
          }
        }
        break;
      default:
        return ErrorEntity(code: -1, message: error.message);
    }
  }
}

Future<bool> checkNetworkConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  } else if (connectivityResult == ConnectivityResult.none) {
    return false;
  } else {
    return false;
  }
}

//GET THE ERROR FROM API
class ErrorEntity {
  final int? code;
  final String? message;

  ErrorEntity({this.code, this.message});
}
