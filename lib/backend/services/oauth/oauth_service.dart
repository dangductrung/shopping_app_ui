import 'package:dio/dio.dart';
import 'package:shopping_app/backend/http_client.dart';
import 'package:shopping_app/injector.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shopping_app/config/config.dart';
import 'package:shopping_app/models/client.dart';

part 'oauth_service.g.dart';

@lazySingleton
@RestApi(baseUrl: Config.BASE_URL)
abstract class OauthService {
  @factoryMethod
  factory OauthService() => _OauthService(injector<HttpClient>().dio);

  @POST("/oauth/login")
  Future<Client> login(@Body() Map<String, dynamic> params);

  @POST("/oauth/register")
  Future<Client> register(@Body() Map<String, dynamic> params);
}
