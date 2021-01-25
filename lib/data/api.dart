import 'package:dio/dio.dart';

class Api {
  Dio _dio;
  Api(Dio dio) {
    _dio = dio;
  }
}