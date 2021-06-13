import 'package:dio/dio.dart';
import 'package:shopping_app/backend/http_client.dart';
import 'package:shopping_app/injector.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shopping_app/config/config.dart';
import 'package:shopping_app/models/client.dart';
import 'package:shopping_app/models/product.dart';

part 'product_service.g.dart';

@lazySingleton
@RestApi(baseUrl: Config.BASE_URL)
abstract class ProductService {
  @factoryMethod
  factory ProductService() => _ProductService(injector<HttpClient>().dio);

  @GET("/search")
  Future<List<Product>> search(@Body() Map<String, dynamic> params, @Query("page") int page);

  @GET("/product/latest")
  Future<List<Product>> getListLastItem();

  @GET("/follow/list")
  Future<List<Product>> getFollowList(@Query("page") int page);

  @GET("/product/chart")
  Future<List<Product>> getChartData(@Query("product") int productId);

  @POST("/follow/add")
  Future<void> followProduct(@Query("product") int productId);

  @POST("/follow/unfollow")
  Future<void> unFollowProduct(@Query("product") int productId);
}
