import 'package:dio/dio.dart';
import 'package:shopping_app/backend/http_client.dart';
import 'package:shopping_app/injector.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shopping_app/config/config.dart';
import 'package:shopping_app/models/client.dart';
import 'package:shopping_app/models/product.dart';
import 'package:shopping_app/models/profile.dart';

part 'profile_service.g.dart';

@lazySingleton
@RestApi(baseUrl: Config.BASE_URL)
abstract class ProfileService {
  @factoryMethod
  factory ProfileService() => _ProfileService(injector<HttpClient>().dio);

  @GET("/profile/info")
  Future<Profile> getInfo();

  @POST("/profile/update")
  Future<Profile> updateProfile(@Body() Map<String, dynamic> params);
}
