import 'package:json_annotation/json_annotation.dart';
import 'package:glowy/data/responses/base_responses/base_responses.dart';

part 'list_app.g.dart';

@JsonSerializable()
class ListApp {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "platform")
  String? platform;
  @JsonKey(name: "categories")
  List<Category>? categories;
  ListApp(this.id, this.name, this.platform, this.categories);
  // from json
  factory ListApp.fromJson(Map<String, dynamic> json) =>
      _$ListAppFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$ListAppToJson(this);
}

@JsonSerializable()
class Category {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "displayOrder")
  int? displayOrder;
  @JsonKey(name: "imageCount")
  int? imageCount;
  Category(this.id, this.name, this.type, this.displayOrder, this.imageCount);
  // from json
  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class HomeDataResponse {
  @JsonKey(name: "categories")
  List<Category>? categories;
  @JsonKey(name: "apps")
  List<ListApp>? apps;
  HomeDataResponse(this.categories, this.apps);
  // from json
  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);
  // to json
  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);
}

@JsonSerializable()
class HomeResponse extends BaseResponse {
  @JsonKey(name: "data")
  HomeDataResponse? data;
  HomeResponse({this.data, super.success, super.message});
  // from json
  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);
  // to json
  @override
  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}
