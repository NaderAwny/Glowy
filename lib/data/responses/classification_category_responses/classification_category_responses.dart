import 'package:glowy/data/responses/base_responses/base_responses.dart';
import 'package:json_annotation/json_annotation.dart';
part 'classification_category_responses.g.dart';

@JsonSerializable()
class ClassificationResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "thumbnailUrl")
  String? thumbnailUrl;
  @JsonKey(name: "itemCount")
  int? itemCount;
  ClassificationResponse({
    this.id,
    this.name,
    this.thumbnailUrl,
    this.itemCount,
  });
  factory ClassificationResponse.fromJson(Map<String, dynamic> json) =>
      _$ClassificationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ClassificationResponseToJson(this);
}

@JsonSerializable()
class ClassificationCategoryResponses {
  @JsonKey(name: "classifications")
  List<ClassificationResponse>? classifications;

  ClassificationCategoryResponses({this.classifications});
  factory ClassificationCategoryResponses.fromJson(Map<String, dynamic> json) =>
      _$ClassificationCategoryResponsesFromJson(json);
  Map<String, dynamic> toJson() =>
      _$ClassificationCategoryResponsesToJson(this);
}

@JsonSerializable()
class ClassificationMainResponse extends BaseResponse {
  @JsonKey(name: "data")
  ClassificationCategoryResponses? data;
  ClassificationMainResponse({this.data, super.success, super.message});
  factory ClassificationMainResponse.fromJson(Map<String, dynamic> json) =>
      _$ClassificationMainResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ClassificationMainResponseToJson(this);
}
