import 'package:dio/dio.dart';
import 'package:glowy/data/responses/classification_category_responses/classification_category_responses.dart';
import 'package:glowy/data/responses/get_drawer_data_responses/get_drawer_data_response.dart';
import 'package:glowy/data/responses/image_category_responses/image_category_responses.dart';
import 'package:glowy/data/responses/list_app_responses/list_app.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../app/constants.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @GET("/mobile/apps")
  Future<HomeResponse> listApp();

  @GET("/mobile/apps/{appId}")
  Future<GetDrawerDataResponse> getDrawerData(@Path("appId") String appId);

  @GET("/mobile/apps/{appId}/categories/{categoryId}/content")
  Future<ImageCategory> getImageCategoryContent(
    @Path('appId') String appId,
    @Path('categoryId') String categoryId,
    @Query('page') int page,
    @Query('limit') int limit,
  );
  @GET("/mobile/apps/{appId}/categories/{categoryId}/classifications")
  Future<ClassificationMainResponse> getImageCategoryClassification(
    @Path('appId') String appId,
    @Path('categoryId') String categoryId,
  );

  @GET("/mobile/apps/{appId}/categories/{categoryIdClassification}/content")
  Future<ImageCategory> getImageCategoryContentClassification(
    @Path("appId") String appId,
    @Path("categoryIdClassification") String categoryIdClassification,
    @Query("page") int page,
    @Query("limit") int limit,
    @Query("classificationId") String classificationId,
  );
}
