import 'package:shopping_app/firebase/fcm_payload.dart';

abstract class FCMMessageHandler {
  FCMMessageHandler();

  void handle(FCMPayload payload);
}
