import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import '/utils/error_handler.dart';
import 'package:flutter/foundation.dart';

import '/utils/request_type.dart';

class DioClient {
  static final _dioClient = DioClient._();
  late final Dio _dio;
  static late String token;

  factory DioClient() {
    return _dioClient;
  }

  DioClient._() {
    token = "";
    _dio = Dio();
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestHeader: true,
          responseHeader: false,
          requestBody: true,
        ),
      );
    }
  }

  final timeOutDuration = const Duration(seconds: kDebugMode ? 180 : 60);

  Future<Response> request({
    required RequestType requestType,
    required String url,
    dynamic body,
    dynamic queryParameters,
    dynamic headers,
  }) async {
    try {
      Response? resp;
      Map<String, String> heading = {
        'Content-Type': 'application/json',
        'accept': '*/*',
      };

      Map<String, String> headingWithToken = {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      };
      switch (requestType) {
        case RequestType.get:
          resp = await _dio
              .get(
                url,
                options: Options(headers: heading),
                queryParameters: queryParameters,
              )
              .timeout(
                timeOutDuration,
              );
          break;
        case RequestType.getWithToken:
          resp = await _dio
              .get(
                url,
                options: Options(headers: headingWithToken),
                queryParameters: queryParameters,
              )
              .timeout(
                timeOutDuration,
              );
          break;
        case RequestType.post:
          resp = await _dio
              .post(
                url.trim(),
                data: jsonEncode(body),
                options: Options(
                  headers: heading,
                ),
              )
              .timeout(
                timeOutDuration,
              );
          break;
        case RequestType.postWithHeaders:
          resp = await _dio
              .post(
                url.trim(),
                data: jsonEncode(body),
                options: Options(
                  headers: {...heading, ...headers},
                ),
              )
              .timeout(
                timeOutDuration,
              );
          break;
        case RequestType.postWithToken:
          resp = await _dio
              .post(
                url,
                data: jsonEncode(body),
                options: Options(
                  headers: headingWithToken,
                ),
              )
              .timeout(
                timeOutDuration,
              );
          break;
        case RequestType.postWithTokenFormData:
          resp = await _dio
              .post(
                url,
                data: body,
                options: Options(
                  headers: headingWithToken,
                ),
              )
              .timeout(
                timeOutDuration,
              );
          break;
        // default:
        //   resp = await throw RequestTypeNotFoundException(
        //     "The HTTP request method is not found",
        //   );
      }
      return resp;
    } on DioError catch (ex) {
      if (ex.error.runtimeType == SocketException) {
        rethrow;
      } else if (kDebugMode && ex.response?.statusCode == 502) {
        throw "Server in deployment phase";
      } else if (ex.response?.data == String) {
        throw ErrorHandler.errorMessage;
      } else if (ex.response?.data["non_field_errors"] != null &&
          ex.response?.data["non_field_errors"] is List) {
        throw ex.response?.data?["non_field_errors"][0] ??
            ErrorHandler.errorMessage;
      }
      throw ex.response?.data?["message"] ?? ErrorHandler.errorMessage;
    } catch (ex) {
      rethrow;
    }
  }
}
