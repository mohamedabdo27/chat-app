import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Api {
  Api({
    required this.dio,
  });
  final String _baseUrl = "http://192.168.1.193:8080/";
  final Dio dio;
  Future<Map<String, dynamic>> get({
    required String endPoint,
  }) async {
    Response response = await dio.get(
      "$_baseUrl$endPoint",
    );
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    String? authorization,
    String contentType = "application/json",
    required String endPoint,
    @required dynamic body,
  }) async {
    Response response = await dio.post(
      "$_baseUrl$endPoint",
      data: body,
      options: Options(
        headers: {
          'Authorization': authorization,
          'Content-Type': contentType,
        },
      ),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> put({
    required String endPoint,
    @required dynamic body,
  }) async {
    Response response = await dio.put(
      "$_baseUrl$endPoint",
      data: body,
    );
    return response.data;
  }
}
