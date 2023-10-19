import 'package:dio/dio.dart';

abstract class NetworkExceptions {
  static String getErrorMessageFromDioException(error) {
    String errorMessage = "Something went wrong";
    if (error is Exception) {
      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.badCertificate:
            errorMessage = error.message!;
            break;
          case DioExceptionType.badResponse:
            if (error.response != null) {
              errorMessage =
                  'Error Code: ${error.response?.statusCode.toString()} ${error.response?.data['message']}';
            } else {
              errorMessage = error.message!;
            }
            break;
          case DioExceptionType.cancel:
            break;
          case DioExceptionType.connectionError:
            if (error.response != null) {
              errorMessage =
                  'Error Code: ${error.response?.statusCode.toString()} ${error.response?.data['message']}';
            } else {
              errorMessage = "Connection error, check your network";
            }
            break;
          case DioExceptionType.connectionTimeout:
            break;
          case DioExceptionType.receiveTimeout:
            break;
          case DioExceptionType.sendTimeout:
            break;
          case DioExceptionType.unknown:
            break;
        }
      }
    }
    return errorMessage;
  }
}
