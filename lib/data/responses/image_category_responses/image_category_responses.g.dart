// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_category_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemsImageCategory _$ItemsImageCategoryFromJson(Map<String, dynamic> json) =>
    ItemsImageCategory(
      id: json['id'] as String?,
      url: json['url'] as String?,
      thumbUrl: json['thumbUrl'] as String?,
      isTopRated: json['isTopRated'] as bool?,
      mediaType: json['mediaType'] as String?,
      classificationId: json['classificationId'] as String?,
      classificationName: json['classificationName'] as String?,
      classificationThumbnailUrl: json['classificationThumbnailUrl'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$ItemsImageCategoryToJson(ItemsImageCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'thumbUrl': instance.thumbUrl,
      'isTopRated': instance.isTopRated,
      'mediaType': instance.mediaType,
      'classificationId': instance.classificationId,
      'classificationName': instance.classificationName,
      'classificationThumbnailUrl': instance.classificationThumbnailUrl,
      'createdAt': instance.createdAt,
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
  page: (json['page'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
  total: (json['total'] as num?)?.toInt(),
  totalPages: (json['totalPages'] as num?)?.toInt(),
);

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'total': instance.total,
      'totalPages': instance.totalPages,
    };

ImageCategoryResponses _$ImageCategoryResponsesFromJson(
  Map<String, dynamic> json,
) => ImageCategoryResponses(
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => ItemsImageCategory.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: json['pagination'] == null
      ? null
      : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ImageCategoryResponsesToJson(
  ImageCategoryResponses instance,
) => <String, dynamic>{
  'items': instance.items,
  'pagination': instance.pagination,
};

ImageCategory _$ImageCategoryFromJson(Map<String, dynamic> json) =>
    ImageCategory(
      data: json['data'] == null
          ? null
          : ImageCategoryResponses.fromJson(
              json['data'] as Map<String, dynamic>,
            ),
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ImageCategoryToJson(ImageCategory instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
