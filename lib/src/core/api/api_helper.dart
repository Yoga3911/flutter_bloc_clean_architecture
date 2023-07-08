import 'dart:io';

import 'package:dio/dio.dart';

import 'api_exception.dart';

class ApiHelper {
  final Dio _dio;
  const ApiHelper(this._dio);

  Future<Map<String, dynamic>> execute({
    required Method method,
    required String url,
    dynamic data,
  }) async {
    try {
      Response? response;
      switch (method) {
        case Method.get:
          response = await _dio.get(url);
          break;
        case Method.post:
          response = await _dio.post(url);
          break;
        case Method.put:
          response = await _dio.put(url);
          break;
        case Method.patch:
          response = await _dio.patch(url);
          break;
        case Method.delete:
          response = await _dio.delete(url);
          break;
      }

      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioException catch (e) {
      return _returnResponse(e.response!);
    }
  }

  Map<String, dynamic> _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 201:
        return response.data;
      case 400:
        throw BadRequestException(response.data["message"].toString());
      case 401:
        throw UnauthorizedException(response.data["message"].toString());
      case 403:
        throw ForbiddenException(response.data["message"].toString());
      case 404:
        throw NotFoundException(response.data["message"].toString());
      case 422:
        throw UnprocessableContentException(
            response.data["message"].toString());
      case 500:
        throw InternalServerException(response.data["message"].toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

enum Method { get, post, put, patch, delete }
