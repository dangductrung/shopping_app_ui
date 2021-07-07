import 'package:dio/dio.dart';
import 'package:shopping_app/backend/http_client.dart';
import 'package:shopping_app/injector.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shopping_app/config/config.dart';
import 'package:shopping_app/models/client.dart';
import 'package:shopping_app/models/notification_model.dart';

part 'fcm_service.g.dart';

@lazySingleton
@RestApi(baseUrl: Config.BASE_URL)
abstract class FCMService {
  @factoryMethod
  factory FCMService() => _FCMService(injector<HttpClient>().dio);

  @POST("/fcm/add")
  Future<void> registerFCM(@Query("token") String token);

  @DELETE("/fcm/remove")
  Future<void> removeToken(@Query("token") String token);
}
