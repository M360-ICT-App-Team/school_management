import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../errors/exceptions.dart';
import 'sse_event_model_modified.dart';

/// A client for subscribing to Server-Sent Events (SSE).
class SSEClient {
  static http.Client _client = http.Client();

  static Stream<SSEModel> subscribeToSSE(
      {
      // {required SSERequestType method,
      required String url,
      required Map<String, String> header,
      StreamController<SSEModel>? oldStreamController,
      Map<String, dynamic>? body}) {
    StreamController<SSEModel> streamController = StreamController();
    if (oldStreamController != null) {
      streamController = oldStreamController;
    }
    var lineRegex = RegExp(r'^([^:]*)(?::)?(?: )?(.*)?$');
    var currentSSEModel = SSEModel(data: '', id: '', event: '', error: '');
    if (kDebugMode) {
      print("--SUBSCRIBING TO SSE---");
    }
      try {
        _client = http.Client();
        var request = http.Request(
          "GET",
          // method == SSERequestType.GET ? "GET" : "POST",
          Uri.parse(url),
        );

        /// Adding headers to the request
        header.forEach((key, value) {
          request.headers[key] = value;
        });

        /// Adding body to the request if exists
        if (body != null) {
          request.body = jsonEncode(body);
        }

        Future<http.StreamedResponse> response = _client.send(request);

        /// Listening to the response as a stream
        response.asStream().listen((data) {
          /// Applying transforms and listening to it
          data.stream
            .transform(const Utf8Decoder()).transform(const LineSplitter()).listen(
              (dataLine) {
                if (dataLine.isEmpty) {
                  /// This means that the complete event set has been read.
                  /// We then add the event to the stream
                  streamController.add(currentSSEModel);
                  currentSSEModel = SSEModel(data: '', id: '', event: '', error: '');
                  return;
                }

                /// Get the match of each line through the regex
                Match match = lineRegex.firstMatch(dataLine)!;
                var field = match.group(1);
                if (field!.isEmpty) {
                  return;
                }
                var value = '';
                if (field == 'data') {
                  // If the field is data, we get the data through the substring
                  value = dataLine.substring(
                    5,
                  );
                } else {
                  value = match.group(2) ?? '';
                }
                switch (field) {
                  case 'event':
                    currentSSEModel.event = value;
                    break;
                  case 'data':
                    currentSSEModel.data =
                        '${currentSSEModel.data ?? ''}$value\n';
                    break;
                  case 'id':
                    currentSSEModel.id = value;
                    break;
                  case 'error':
                    currentSSEModel.error = value;
                    break;
                  case 'retry':
                    currentSSEModel.error = "Try again";
                    break;
                  default:
                    if (kDebugMode) {
                      print('---ERROR1---');
                    }
                    if (kDebugMode) {
                      print("dataLine: $dataLine");
                    }
                    currentSSEModel.error = "Something went wrong";
                }
              },
              onError: (e, s) {
                if (kDebugMode) {
                  print('---ERROR2---');
                }
                if (kDebugMode) {
                  print("e: $e");
                }
                final myError = handleException(e,s);
                currentSSEModel.error = myError.message;
                streamController.add(currentSSEModel);
              },
            );
        }
        , onError: (e, s) {
          if (kDebugMode) {
            print('---ERROR3---');
          }
          if (kDebugMode) {
            print("e: $e");
          }
          final myError = handleException(e,s);
          currentSSEModel.error = myError.message;
          streamController.add(currentSSEModel);
        }
        );
      } catch (e, ss) {
        if (kDebugMode) {
          print('---ERROR4---');
        }
        if (kDebugMode) {
          print("e: $e");
        }
        final myError = handleException(e,ss);
        currentSSEModel.error = myError.message;
        streamController.add(currentSSEModel);
      }
      return streamController.stream;

  }

  /// Unsubscribe from the SSE.
  static void unsubscribeFromSSE() {
    _client.close();
  }
}
