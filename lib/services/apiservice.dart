import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:pandawatest/model/constant.dart';
import 'package:pandawatest/model/response/loginresponse.dart';
import 'package:pandawatest/model/response/user/user.dart';
import 'package:pandawatest/model/response/userresponse.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class APIService {
  String endpoint = BASE_URL;
  Dio dio = Dio();
  Logger logger = Logger();

  APIService() {
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
    };
    dio.options = BaseOptions(
      baseUrl: BASE_URL,
      headers: headers,
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 5000),
    );
    dio.interceptors.add(PrettyDioLogger());
  }

  Future<LoginResponse> postLogin(String username, String password) async {
    final Uri uri = Uri.parse(endpoint).replace(path: 'auth/login');
    try {
      String postData =
          jsonEncode({'username': username, 'password': password});
      Response response = await dio.postUri(uri, data: postData);
      Map<String, dynamic> json = response.data;
      var user = User.fromJson(json);
      var data = LoginResponse(user: user, token: json['token']);
      return data;
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<User> postRegister(
      String email, String username, String password) async {
    final Uri uri = Uri.parse(endpoint).replace(path: 'users/add');
    try {
      String postData = jsonEncode(
          {'email': email, 'username': username, 'password': password});
      Response response = await dio.postUri(uri, data: postData);
      Map<String, dynamic> json = response.data;
      var user = User.fromJson(json);
      return user;
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<List<User>?> getUser(Map<String, dynamic> param) async {
    final Uri uri =
        Uri.parse(endpoint).replace(path: 'users', queryParameters: param);
    try {
      Response response = await dio.getUri(uri);
      Map<String, dynamic> json = response.data;
      var user = UserResponse.fromJson(json);
      return user.users;
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<List<User>?> getUserByName(Map<String, dynamic> param) async {
    final Uri uri = Uri.parse(endpoint)
        .replace(path: 'users/search', queryParameters: param);
    try {
      Response response = await dio.getUri(uri);
      Map<String, dynamic> json = response.data;
      var user = UserResponse.fromJson(json);
      return user.users;
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<User> getFilteredUser(Map<String, dynamic>? parameter) async {
    final Uri uri = Uri.parse(endpoint)
        .replace(path: 'users/filter', queryParameters: parameter);
    try {
      Response response = await dio.getUri(uri);
      Map<String, dynamic> json = response.data;
      var user = User.fromJson(json);
      return user;
    } on DioException catch (_) {
      rethrow;
    }
  }
}
