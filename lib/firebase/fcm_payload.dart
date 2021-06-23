import 'dart:convert';
import 'dart:io';

class FCMPayload {
  final String title;
  final String body;
  final String type;
  final String from;
  final Map<String, dynamic> data;

  bool get isDataMessage => title == null && body == null;

  FCMPayload({this.title, this.body, this.type, this.data, this.from});

  factory FCMPayload.create(Map<String, dynamic> message) {
    String title;
    String body;
    String type;
    String from;
    Map<String, dynamic> data;

    if (Platform.isAndroid) {
      if (message.containsKey("notification")) {
        final notificationPayload = Map<String, dynamic>.from(message["notification"] as Map);
        title = notificationPayload["title"] as String;
        body = notificationPayload["body"] as String;
      }
      if (message.containsKey("data")) {
        final dataPayload = Map<String, dynamic>.from(message["data"] as Map);
        type = dataPayload["type"] as String;
        from = message["from"] as String;
        if (dataPayload.containsKey("item_data")) {
          data = Map<String, dynamic>.from(json.decode(dataPayload["item_data"] as String) as Map);
        }
      }
    } else {
      if (message.containsKey("aps")) {
        final aps = Map<String, dynamic>.from(message["aps"] as Map);
        if (aps.containsKey("alert")) {
          final alert = Map<String, dynamic>.from(aps["alert"] as Map);
          title = alert["title"] as String;
          body = alert["body"] as String;
        }
      }
      type = message["type"] as String;
      from = message["from"] as String;
      if (message.containsKey("item_data")) {
        data = Map<String, dynamic>.from(json.decode(message["item_data"] as String) as Map<String, dynamic>);
      }
    }

    return FCMPayload(title: title, body: body, type: type, data: data, from: from);
  }

  factory FCMPayload.fromJson(String json) {
    try {
      final parsed = jsonDecode(json) as Map<String, dynamic>;
      return FCMPayload(
        title: parsed["title"] as String,
        body: parsed["body"] as String,
        type: parsed["type"] as String,
        from: parsed["from"] as String,
        data: parsed["data"] as Map<String, dynamic>,
      );
    } on FormatException {
      throw FormatException("Invalid Json: $json");
    }
  }

  String toJson() => jsonEncode({
        "title": title,
        "body": body,
        "type": type,
        "from": from,
        "data": data,
      });
}
