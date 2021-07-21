import 'package:dio/dio.dart';
import 'package:shopping_app/backend/http_client.dart';
import 'package:shopping_app/injector.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shopping_app/config/config.dart';
import 'package:shopping_app/models/chart.dart';
import 'package:shopping_app/models/client.dart';
import 'package:shopping_app/models/fluctuation.dart';
import 'package:shopping_app/models/history_product.dart';
import 'package:shopping_app/models/poster.dart';
import 'package:shopping_app/models/product.dart';

part 'product_service.g.dart';

@lazySingleton
@RestApi(baseUrl: Config.BASE_URL)
abstract class ProductService {
  @factoryMethod
  factory ProductService() => _ProductService(injector<HttpClient>().dio);

  @POST("/search")
  Future<List<Product>> search(@Body() Map<String, dynamic> params, @Query("page") int page);

  @GET("/product/latest")
  Future<List<Product>> getListLastItem();

  @GET("/product/poster")
  Future<Poster> getPoster();

  @GET("/follow/list")
  Future<List<Product>> getFollowList(@Query("page") int page);

  @GET("/product/chart")
  Future<Chart> getChartData(@Query("product") int productId);

  @POST("/follow/add")
  Future<void> followProduct(@Query("product") int productId);

  @POST("/follow/unfollow")
  Future<void> unFollowProduct(@Query("product") int productId);

  @POST("/follow/unnew")
  Future<void> unNewProduct(@Query("id") int id);

  @POST("/report/add")
  Future<void> sendReport(@Body() Map<String, dynamic> params);

  @GET("/product/history")
  Future<List<HistoryProduct>> history(@Query("product") int productId);

  @GET("/product/fluctuation")
  Future<List<Fluctuation>> fluctuation(@Query("page") int page);

  @POST("/product/info")
  Future<Product> detailPrd(@Body() Map<String, dynamic> params);
}
