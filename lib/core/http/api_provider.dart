import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter_application_1/core/constant/end_points/api_url.dart';
import 'dio_error_handle.dart';
import 'http_method.dart';

class ApiProvider {
  static var options = BaseOptions(
      baseUrl: baseUrl, connectTimeout: const Duration(seconds: 10));
  static final Dio dio = Dio(options);

  static Future<Either<String, T>> sendObjectRequest<T>({
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? data,
    Function(Map<String, dynamic>)? converter,
    Function(dynamic)? converter2,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    File? file,
    File? secondFile,
    List<File>? imageFiles,
    List<File>? videoFiles,
    String? fileVideoKey,
    String? fileKey,
    String? secondFileKey,
    String? contentType,
    required String strString,
  }) async {
    final Map<String, dynamic> dataMap = {};
    Response? response;
    try {
      if (data != null) {
        dataMap.addAll(data);
      }
      if (file != null) {
        if (fileKey != null && fileKey != '') {
          String fileName = file.path.split("/").last;
          debugPrint('fileNamexxxx in file');
          debugPrint(fileName);
          late MultipartFile multipartFile;
          multipartFile =
              await MultipartFile.fromFile(file.path, filename: fileName);
          dataMap.addAll({fileKey: multipartFile});
        }
      }
      if (secondFile != null) {
        if (secondFileKey != null && secondFileKey != '') {
          String fileName = secondFile.path.split("/").last;
          debugPrint('fileNamexxxx in secondFile');
          debugPrint(fileName);
          late MultipartFile multipartFile;
          multipartFile =
              await MultipartFile.fromFile(secondFile.path, filename: fileName);
          dataMap.addAll({secondFileKey: multipartFile});
        }
      }
      if (imageFiles != null && imageFiles.isNotEmpty) {
        List<MultipartFile> multipartFiles = [];
        int i = 0;
        for (var element in imageFiles) {
          String fileName = element.path.split("/").last;
          debugPrint('fileNamexxxx in imageFiles');
          debugPrint(fileName);
          multipartFiles.add(
              await MultipartFile.fromFile(element.path, filename: fileName));
          debugPrint(multipartFiles[i].filename);
        }
        dataMap.addAll({
          fileKey!: multipartFiles,
        });
      }
      if (videoFiles != null && videoFiles.isNotEmpty) {
        debugPrint('fileNamexxxx in videoooos');
        List<MultipartFile> multipartFiles = [];
        for (var element in videoFiles) {
          String fileName = element.path.split("/").last;
          debugPrint('fileNamexxxxvideoooos');
          debugPrint(videoFiles.first.path);
          multipartFiles.add(
              await MultipartFile.fromFile(element.path, filename: fileName));
        }
        dataMap.addAll({
          fileVideoKey!: multipartFiles,
        });
      }
      debugPrint('[$method: $url] data : [$data]');
      debugPrint('queryParameters : [$queryParameters]');

      dio.options.headers = headers;
      switch (method) {
        case HttpMethod.GET:
          response = await dio.get(
            url,
            queryParameters: queryParameters,
          );
          break;
        case HttpMethod.POST:
          dio.options.headers['Content-Type'] = contentType;
          response = await dio.post(
            url,
            data: dataMap,
            queryParameters: queryParameters ?? {},
            onSendProgress: (int sent, int total) {
              debugPrint(
                  'progress: ${(sent / total * 100).toStringAsFixed(0)}% ($sent/$total)');
            },
          );
          break;
        case HttpMethod.PUT:
          response = await dio.put(
            url,
            data: FormData.fromMap(dataMap),
            queryParameters: queryParameters,
          );
          break;
        case HttpMethod.DELETE:
          response = await dio.delete(
            url,
            data: data,
            queryParameters: queryParameters,
          );
          break;
      }
      var decodedJson;
      if (kDebugMode) {
        dio.interceptors.add(PrettyDioLogger(
            request: true,
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 90));
      }

      if (response.data is String) {
        debugPrint(response.toString());
        decodedJson = json.decode(response.data);
        debugPrint(decodedJson);
      } else {
        decodedJson = response.data;
      }
      if (kDebugMode) {
        printWrapped(decodedJson.toString());
      }
      if ((response.statusCode)! > 199 && (response.statusCode)! < 300) {
        if (decodedJson != null) {
          if (decodedJson != Map && converter2 != null) {
            return Right(converter2(response.data));
          } else {
            return Right(converter!(response.data));
          }
        } else {
          return Left(response.data['message']);
        }
      } else {
        return Left(response.data['message']);
      }
    } on DioException catch (e) {
      Map dioError = DioErrorsHandler.onError(e);

      if (kDebugMode) {
        print(e);
      }

      final errorData = e.response?.data;

      if (errorData is Map<String, dynamic>) {
        final errorMessage =
            errorData['error']?['message'] ?? 'An error occurred';
        return Left(errorMessage);
      }

      return Left(dioError.toString());
    } on SocketException catch (e, stacktrace) {
      if (kDebugMode) {
        debugPrint('SocketException');
        print(e);
        print(stacktrace);
      }
      return const Left('please check your connection');
    }
  }

  static Future<Either<String, String>> sendObjectWithOutResponseRequest<T>({
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      debugPrint('[$method: $url] data : $data');
      debugPrint('queryParameters : [$queryParameters]');
      debugPrint(jsonEncode(data));
      dio.options.headers = headers;
      Response response;
      switch (method) {
        case HttpMethod.GET:
          response = await dio.get(
            url,
            queryParameters: queryParameters,
          );
          break;
        case HttpMethod.POST:
          response = await dio.post(
            url,
            data: data,
            queryParameters: queryParameters ?? {},
          );
          break;
        case HttpMethod.PUT:
          response = await dio.put(
            url,
            data: data,
            queryParameters: queryParameters,
          );
          break;
        case HttpMethod.DELETE:
          response = await dio.delete(
            url,
            data: data,
            queryParameters: queryParameters,
          );
          break;
      }

      var decodedJson;

      if (response.data is String) {
        decodedJson = json.decode(response.data);
      } else {
        decodedJson = response.data;
      }

      if (decodedJson['data'] == false || decodedJson['data'] == true) {
        decodedJson['data'] = {'': ''};
      }
      if (kDebugMode) {
        printWrapped(decodedJson.toString());
      }

      if ((response.statusCode)! > 199 && (response.statusCode)! < 300) {
        if (decodedJson['success'] == true) {
          return Right(decodedJson['message']);
        } else {
          return Left(response.data['message']);
        }
      } else {
        return Left(response.data['message']);
      }
    } on DioException catch (e) {
      Map dioError = DioErrorsHandler.onError(e);
      if (kDebugMode) {
        print(e);
      }
      return Left(e.response?.data['message'] ?? dioError['message']);
    } on SocketException catch (e, stacktrace) {
      if (kDebugMode) {
        debugPrint('SocketException');
        print(e);
        print(stacktrace);
      }
      return const Left('please check your connection');
    }
  }

  static void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
  }
}
