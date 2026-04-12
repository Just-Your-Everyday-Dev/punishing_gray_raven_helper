import 'dart:io';

import 'package:dio/dio.dart';

import '../constants/const_imports.dart';

class ErrorHelper {
  static String handleError(Object error) {
    try {
      var errorMsg = StringConsts.sww;

      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.cancel:
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.receiveTimeout:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.badCertificate:
          case DioExceptionType.connectionError:
            errorMsg = error.message ?? StringConsts.sww;
            break;
          case DioExceptionType.badResponse:
          case DioExceptionType.unknown:
            errorMsg = getErrorStringFrom(error: error);
            break;
        }
      } else if (error is SocketException) {
        errorMsg = 'No internet connection ${error.toString()}';
      } else if (error is FormatException) {
        errorMsg = error.message;
      }
      return errorMsg;
    } catch (e) {
      return StringConsts.sww;
    }
  }

  static String getErrorStringFrom({required DioException error}) {
    final response = error.response;
    final data = response?.data;

    var errorString = '';

    if (data is Map) {
      errorString =
          data['message'] ??
          response?.statusMessage ??
          error.message ??
          StringConsts.sww;
    } else {
      errorString =
          response?.statusMessage ?? error.message ?? StringConsts.sww;
    }

    switch (response?.statusCode ?? 0) {
      case 401:
      case 403:
        break;
      case 409:
        errorString = 'Error due to a conflict';
        break;
      case 500:
        errorString = 'Internal Server Error';
        break;
      case 503:
        errorString = 'Service unavailable';
        break;
      default:
        break;
    }

    return errorString;
  }
}