import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    @required String url,
    @required Map<String, dynamic> query,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }
}

//api
//https://newsapi.org/s/egypt-news-api

//https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=0d1432980a8f4613b6d80f400545cfef
//https://newsapi.org/v2/top-headlines?country=eg&category=sports&apiKey=0d1432980a8f4613b6d80f400545cfef
//https://newsapi.org/v2/top-headlines?country=eg&category=entertainment&apiKey=0d1432980a8f4613b6d80f400545cfef

//'apiKey': 'beea0f4f3b8e41da9db329c9300863e8'
//'apiKey': '0d1432980a8f4613b6d80f400545cfef'
