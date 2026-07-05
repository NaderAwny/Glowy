import 'package:json_annotation/json_annotation.dart';
import 'package:glowy/data/responses/base_responses/base_responses.dart';
import 'package:glowy/data/responses/list_app_responses/list_app.dart';

part 'get_drawer_data_response.g.dart';

@JsonSerializable()
class DrawerApp {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "platform")
  String? platform;
  @JsonKey(name: "about")
  String? about;
  @JsonKey(name: "privacyPolicy")
  String? privacyPolicy;
  @JsonKey(name: "termsOfUse")
  String? termsOfUse;
  @JsonKey(name: "androidShareLink")
  String? androidShareLink;
  @JsonKey(name: "iphoneShareLink")
  String? iphoneShareLink;
  @JsonKey(name: "contactEmail")
  String? contactEmail;
  @JsonKey(name: "categories")
  List<Category>? categories;

  DrawerApp({
    this.id,
    this.name,
    this.description,
    this.platform,
    this.about,
    this.privacyPolicy,
    this.termsOfUse,
    this.androidShareLink,
    this.iphoneShareLink,
    this.contactEmail,
    this.categories,
  });

  factory DrawerApp.fromJson(Map<String, dynamic> json) =>
      _$DrawerAppFromJson(json);

  Map<String, dynamic> toJson() => _$DrawerAppToJson(this);
}

@JsonSerializable()
class GetDrawerDataResponseData {
  @JsonKey(name: "app")
  DrawerApp? app;

  GetDrawerDataResponseData({this.app});

  factory GetDrawerDataResponseData.fromJson(Map<String, dynamic> json) =>
      _$GetDrawerDataResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetDrawerDataResponseDataToJson(this);
}

@JsonSerializable()
class GetDrawerDataResponse extends BaseResponse {
  @JsonKey(name: "data")
  GetDrawerDataResponseData? data;

  GetDrawerDataResponse({this.data, super.success, super.message});

  factory GetDrawerDataResponse.fromJson(Map<String, dynamic> json) =>
      _$GetDrawerDataResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetDrawerDataResponseToJson(this);
}
