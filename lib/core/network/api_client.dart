import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants/app_exception_messages.dart';
import '../errors/exceptions.dart';
import '../local_database/auth_db.dart';
import '../model/send_file_model.dart';

class ApiClient {
  static Future<dynamic> get({required String url, String? token}) async {
    final Map<String, String> header = {
      "Content-Type": "application/json",
      if (token != null) 'Authorization': 'Bearer $token',
    };

    if (kDebugMode) {
      print("========================== GET METHOD ==========================");
      print("url => $url");
      print("header => $header");
    }

    final response = await http.get(Uri.parse(url), headers: header);

    if (kDebugMode) {
      print("response.body => ${response.body}");
      print(
        "========================== END GET METHOD ==========================",
      );
      print("response: $response");
      print("response.runtimeType: ${response.runtimeType}");
    }

    final responseData = jsonDecode(response.body);

    if (responseData['success'] == true) {
      if (responseData['data'] != null) {
        if (responseData["total_due"] != null) {
          return responseData;
        }
        return responseData['data'];
      } else {
        throw ServerException(AppExceptionMessage.empty);
      }
    } else {
      throw ServerException(
        responseData['message'] ?? AppExceptionMessage.serverDefault,
      );
    }
  }

  //for post method
  static Future<dynamic> post({
    required String url,
    String? body,
    String? token,
  }) async {
    final Map<String, String> header = {
      "Content-Type": "application/json",
      if (token != null) 'Authorization': 'Bearer $token',
    };

    if (kDebugMode) {
      print("######################## POST METHOD ########################");
      print("url => $url");
      print("header => $header");
      print("body => $body");
    }
    final response = await http.post(
      Uri.parse(url),
      body: body,
      headers: header,
    );

    if (kDebugMode) {
      print("response.body => ${response.body}");
      print(
        "######################## END POST METHOD ########################",
      );
    }

    final responseData = jsonDecode(response.body);

    if (responseData['success'] == true) {
      if (responseData['token'] != null) {
        //store token
        AuthLocalDB.setToken(responseData['token']);
      }
      return responseData['data'];
    } else {
      throw ServerException(
        responseData['message'] ?? AppExceptionMessage.serverDefault,
      );
    }
  }

  //for post method with full response
  static Future<dynamic> postFullResponse({
    required String url,
    String? body,
    String? token,
  }) async {
    final Map<String, String> header = {
      "Content-Type": "application/json",
      if (token != null) 'Authorization': 'Bearer $token',
    };

    if (kDebugMode) {
      print("######################## POST METHOD ########################");
      print("url => $url");
      print("header => $header");
      print("body => $body");
    }
    final response = await http.post(
      Uri.parse(url),
      body: body,
      headers: header,
    );

    if (kDebugMode) {
      print("response.body => ${response.body}");
      print(
        "######################## END POST METHOD ########################",
      );
    }

    final responseData = jsonDecode(response.body);

    if (responseData['success'] == true) {
      if (responseData['token'] != null) {
        //store token
        AuthLocalDB.setToken(responseData['token']);
      }
      return responseData;
    } else {
      throw ServerException(
        responseData['message'] ?? AppExceptionMessage.serverDefault,
      );
    }
  }

  static Future<dynamic> multipartRequestPatch({
    required String url,
    required String? token,
    String? body,
    List<SendFileModel>? files,
  }) async {
    final Map<String, String> header = {
      if (token != null) 'Authorization': 'Bearer $token',
    };

    if (kDebugMode) {
      print(
        "*********************** MULTIPART REQUEST PATCH ***********************",
      );
      print("url => $url");
      print("header => $header");
      print("body => $body");
    }
    final request = http.MultipartRequest("PATCH", Uri.parse(url));

    if (token != null) {
      request.headers.addAll(header);
    }

    if (body != null) {
      final Map<String, dynamic> payload = jsonDecode(body);
      final Map<String, String> stringPayload = {};

      payload.forEach((key, value) {
        if (value != null) {
          stringPayload[key.toString()] = value.toString();
        }
      });
      request.fields.addAll(stringPayload);
    }

    if ((files ?? []).isNotEmpty) {
      for (var file in files!) {
        final multipartFile = await http.MultipartFile.fromPath(
          file.key,
          file.filePath,
        );
        request.files.add(multipartFile);
        // print("object multipartFile => ${multipartFile.filename}");
      }
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (kDebugMode) {
      print("response.body => ${response.body}");
      print(
        "*********************** END MULTIPART REQUEST PATCH ***********************",
      );
    }

    final responseData = jsonDecode(response.body);

    if (responseData['success'] == true) {
      if (responseData['data'] != null) {
        return responseData['data'];
      }

      //when need only success or not
      return responseData['success'];
    } else {
      throw ServerException(
        responseData['message'] ?? AppExceptionMessage.serverDefault,
      );
    }
  }

  //for multipart post method

  static Future<dynamic> multipartRequestPost({
    required String url,
    String? token,
    String? body,
    List<SendFileModel>? files,
  }) async {
    final Map<String, String> header = {
      if (token != null) 'Authorization': 'Bearer $token',
    };

    if (kDebugMode) {
      print(
        "*********************** MULTIPART REQUEST POST ***********************",
      );
      print("url => $url");
      print("header => $header");
      print("body => $body");
    }
    final request = http.MultipartRequest("POST", Uri.parse(url));

    if (token != null) {
      request.headers.addAll(header);
    }

    if (body != null) {
      final Map<String, dynamic> payload = jsonDecode(body);
      final Map<String, String> stringPayload = {};

      payload.forEach((key, value) {
        if (value != null) {
          stringPayload[key.toString()] = value.toString();
        }
      });
      request.fields.addAll(stringPayload);
    }

    if ((files ?? []).isNotEmpty) {
      for (var file in files!) {
        final multipartFile = await http.MultipartFile.fromPath(
          file.key,
          file.filePath,
        );
        request.files.add(multipartFile);
        // print("object multipartFile => ${multipartFile.filename}");
      }
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (kDebugMode) {
      print("response.body => ${response.body}");
      print(
        "*********************** END MULTIPART REQUEST POST ***********************",
      );
    }

    final responseData = jsonDecode(response.body);

    if (responseData['success'] == true) {
      if (responseData['data'] != null) {
        return responseData['data'];
      }

      return responseData;
    } else {
      throw ServerException(
        responseData['message'] ?? AppExceptionMessage.serverDefault,
      );
    }
  }

  //for patch
  static Future<dynamic> patch({
    required String url,
    String? body,
    String? token,
  }) async {
    final Map<String, String> header = {
      "Content-Type": "application/json",
      if (token != null) 'Authorization': 'Bearer $token',
    };

    if (kDebugMode) {
      print("######################## PATCH METHOD ########################");
      print("url => $url");
      print("header => $header");
      print("body => $body");
    }
    final response = await http.patch(
      Uri.parse(url),
      body: body,
      headers: header,
    );

    if (kDebugMode) {
      print("response.body => ${response.body}");
      print(
        "######################## END PATCH METHOD ########################",
      );
    }

    final responseData = jsonDecode(response.body);

    if (responseData['success'] == true) {
      if (responseData['token'] != null) {
        //store token
        // AuthLocalDB().setToken(responseData['token']);
      }

      if (responseData['data'] != null) {
        return responseData['data'];
      }

      //for match otp response. when need only success or not
      return responseData['success'];
    } else {
      throw ServerException(
        responseData['message'] ?? AppExceptionMessage.serverDefault,
      );
    }
  }

  //for delete
  static Future<dynamic> delete({required String url, String? token}) async {
    final Map<String, String> header = {
      "Content-Type": "application/json",
      if (token != null) 'Authorization': 'Bearer $token',
    };

    if (kDebugMode) {
      print(
        "========================== DELETE METHOD ==========================",
      );
      print("url => $url");
      print("header => $header");
    }

    final response = await http.delete(Uri.parse(url), headers: header);

    if (kDebugMode) {
      print("response.body => ${response.body}");
      print(
        "========================== END DELETE METHOD ==========================",
      );
    }

    final responseData = jsonDecode(response.body);

    if (responseData['success'] == true) {
      return true;
    } else {
      throw ServerException(
        responseData['message'] ?? AppExceptionMessage.serverDefault,
      );
    }
  }

  //for only pratial pay screen

 static Future<dynamic> getpartical({required String url, String? token}) async {
    final headers = <String, String>{
      "Content-Type": "application/json",
      if (token != null) 'Authorization': 'Bearer $token',
    };

    if (kDebugMode) {
      print("GET $url");
      print("Headers: $headers");
    }

    final response = await http.get(Uri.parse(url), headers: headers);

    if (kDebugMode) {
      print("Response body: ${response.body}");
    }

    if (response.statusCode != 200) {
      throw ServerException('Failed to load data: ${response.statusCode}');
    }

    final responseData = jsonDecode(response.body);

    if (responseData is! Map<String, dynamic>) {
      throw ServerException("Invalid response format");
    }

    if (responseData['success'] == true) {
      return responseData;
    } else {
      throw ServerException(responseData['message'] ?? "Server error");
    }
  }
}


Future<T> postResponse<T>({
  required String url,
  Map<String, dynamic>? payload,
  String? token,
  required T Function(String) fromJson, // Parsing function for response
  String? from,
}) async {
  Uri uriUrl = Uri.parse(url);

  final Map<String, String> header = {
    "Content-Type": "application/json",
    if (token != null) "Authorization": "Bearer $token",
  };

  try {
    final response = await http.post(
      uriUrl,
      body: payload == null ? null : jsonEncode(payload),
      headers: header,
    ).timeout(const Duration(seconds: 500));

    debugPrint("$from\n postResponse response: ${response.body}");

    // Parse and return the generic model
    return Isolate.run(()=>fromJson(response.body));
  } on TimeoutException {
    throw Exception("The request timed out. Please try again later.");
  } on SocketException {
    throw Exception("Unable to connect to the server. Please check your network connection and try again.");
  } catch (e, k) {
    debugPrint("$from\n Error: $e");
    throw Exception("An error occurred while communicating with the server: $e, $k");
  }
}

