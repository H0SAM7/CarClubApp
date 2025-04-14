import 'dart:convert';
import 'dart:developer';

import 'package:car_club/core/utils/constants.dart';
import 'package:http/http.dart' as http;

class NotificationsServices {



  Future<void> sendNotification(String title, String message,String accessToken) async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Authorization':
          'Bearer $accessToken',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse(
        'https://fcm.googleapis.com/v1/projects/carculb-1080f/messages:send');

    var body = {
      "message": {
        "topic": notifiGroup,
        "notification": {"title": title, "body": message},
        "data": {"story_id": "story_12345"}
      }
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      log('resBody=========$resBody');
    } else {
      log('res.reasonPhrase=========${res.reasonPhrase}' );
    }
  }
}
