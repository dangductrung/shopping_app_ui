import 'package:dio/dio.dart';
import 'package:shopping_app/backend/http_client.dart';
import 'package:shopping_app/injector.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shopping_app/config/config.dart';
import 'package:shopping_app/models/client.dart';
import 'package:shopping_app/models/notification_model.dart';

part 'notification_service.g.dart';

@lazySingleton
@RestApi(baseUrl: Config.BASE_URL)
abstract class NotificationService {
  @factoryMethod
  factory NotificationService() => _NotificationService(injector<HttpClient>().dio);

  @GET("/notification/list")
  Future<List<NotificationModel>> getList(@Query("page") int page);

  @POST("/notification/read")
  Future<void> read(@Query("id") int id);

  @POST("/notification/readAll")
  Future<void> readAll();
}
