import 'package:json_annotation/json_annotation.dart';
import 'package:glowy/data/responses/base_responses/base_responses.dart';

part 'image_category_responses.g.dart';

@JsonSerializable()
class ItemsImageCategory {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "url")
  String? url;
  @JsonKey(name: "thumbUrl")
  String? thumbUrl;
  @JsonKey(name: "isTopRated")
  bool? isTopRated;
  @JsonKey(name: "mediaType")
  String? mediaType;
  @JsonKey(name: "classificationId")
  String? classificationId;
  @JsonKey(name: "classificationName")
  String? classificationName;
  @JsonKey(name: "classificationThumbnailUrl")
  String? classificationThumbnailUrl;
  @JsonKey(name: "createdAt")
  String? createdAt;

  ItemsImageCategory({
    this.id,
    this.url,
    this.thumbUrl,
    this.isTopRated,
    this.mediaType,
    this.classificationId,
    this.classificationName,
    this.classificationThumbnailUrl,
    this.createdAt,
  });

  factory ItemsImageCategory.fromJson(Map<String, dynamic> json) =>
      _$ItemsImageCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsImageCategoryToJson(this);
}

@JsonSerializable()
class Pagination {
  @JsonKey(name: "page")
  int? page;
  @JsonKey(name: "limit")
  int? limit;
  @JsonKey(name: "total")
  int? total;
  @JsonKey(name: "totalPages")
  int? totalPages;
  Pagination({this.page, this.limit, this.total, this.totalPages});

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

@JsonSerializable()
class ImageCategoryResponses {
  @JsonKey(name: "items")
  List<ItemsImageCategory>? items;
  @JsonKey(name: "pagination")
  Pagination? pagination;
  ImageCategoryResponses({this.items, this.pagination});
  factory ImageCategoryResponses.fromJson(Map<String, dynamic> json) =>
      _$ImageCategoryResponsesFromJson(json);
  Map<String, dynamic> toJson() => _$ImageCategoryResponsesToJson(this);
}

@JsonSerializable()
class ImageCategory extends BaseResponse {
  @JsonKey(name: "data")
  ImageCategoryResponses? data;
  ImageCategory({this.data, super.success, super.message});
  factory ImageCategory.fromJson(Map<String, dynamic> json) =>
      _$ImageCategoryFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ImageCategoryToJson(this);
}
