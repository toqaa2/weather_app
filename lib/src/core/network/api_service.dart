
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//Dio Helper That's Connect and Talk to API.
abstract class ApiService {
  static late Dio dio;

  //Here The Initialize of Dio and Start Connect to API Using baseUrl.
  static init() {
    dio = Dio(
      BaseOptions(
        //Here the URL of API.
        baseUrl: dotenv.env["BASEURL"] ?? "",
        // connectTimeout: const Duration(minutes: 1),
        // sendTimeout:const Duration(minutes: 1) ,
        receiveTimeout: const Duration(minutes: 1) ,
        //   receiveDataWhenStatusError: true,
        //Here we Put The Headers Needed in The API.
        headers: {
          'Authorization': dotenv.env["BASICTOKEN"] ?? "",
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    );
  }

  //This Function to call API and get Some Data based on url(End Points) and Headers needed in API to get the Specific Data.
  static Future<Response> getData({
    required String endPoint,
    String? token,
    Options? options,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer ${token ?? ''}',
      };
      final Response response = await dio.get(
        endPoint,
        options: options,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //This Function that's Used To Post Data to API based on URL(End Points) and Headers.
  static Future<Response> postData({
    required String endPoint,
     data,
    String? token,
    String? contentType,
    Options? options,
    bool accessToken = false,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      if (token != null) {
        dio.options.headers = {'Authorization': 'Bearer $token'};
      }
      if (accessToken) {
        dio.options.headers = {
          'Authorization': dotenv.env['BASICTOKEN'],
          'Content-Type': contentType ?? 'application/x-www-form-urlencoded',
        };
      }



      final Response response = await dio.post(
        endPoint,
        data: data,
        options: options,
        queryParameters: queryParameters,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //This Function That's Used to Update Some Date based on URL(End Points) and Send what's you need to Update as Map.
  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
    // bool files = false,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer ${token ?? ''}',
      };
      final Response response = await dio.put(
        url,
        data: data,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //This Function That's Used to Update Some Date based on URL(End Points) and Send what's you need to Update as Map.
  static Future<Response> patchData({
    required String url,
    required Map<String, dynamic> data,
    required String token,
    bool files = false,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      // 'Authorization': token ,
      'Content-Type': 'application/json',
    };
    return await dio.patch(
      url,
      data: data,
    );
  }

  //This Function that's Used To Delete Data to API based on URL(End Points) and Headers.
  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
    String? token,
    //String lang = 'en',
  }) async {
    try {
      dio.options.headers = {
        'Authorization': 'Bearer $token',
        // 'Authorization': token ,
        //'Content-Type': 'application/json',
      };
      final Response response = await dio.delete(
        url,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
