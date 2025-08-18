
import 'package:flutter/foundation.dart';

import 'flutter_client_sse_modified.dart';
import 'sse_event_model_modified.dart';


class SSEService {
  Stream<SSEModel>? _client;

  Stream<SSEModel>? listenToSSE({required String url}) {
    if (kDebugMode) {
      print("🔗 Connecting to SSE: $url");
    }
    try {
      _client = SSEClient.subscribeToSSE(
        url: url,
        header: {
          "Accept": "text/event-stream",
          "Cache-Control": "no-cache",
        },
      );

      return _client?.map((sseModel) {
        return sseModel;
      });
    } catch (e, k) {
      if (kDebugMode) {
        print("error: $e \n stackTrace: $k");
      }
      return null;
    }
  }

  static void closeConnection() {
    SSEClient.unsubscribeFromSSE();
  }
}
