// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classification_category_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassificationResponse _$ClassificationResponseFromJson(
  Map<String, dynamic> json,
) => ClassificationResponse(
  id: json['id'] as String?,
  name: json['name'] as String?,
  thumbnailUrl: json['thumbnailUrl'] as String?,
  itemCount: (json['itemCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$ClassificationResponseToJson(
  ClassificationResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'thumbnailUrl': instance.thumbnailUrl,
  'itemCount': instance.itemCount,
};

ClassificationCategoryResponses _$ClassificationCategoryResponsesFromJson(
  Map<String, dynamic> json,
) => ClassificationCategoryResponses(
  classifications: (json['classifications'] as List<dynamic>?)
      ?.map((e) => ClassificationResponse.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ClassificationCategoryResponsesToJson(
  ClassificationCategoryResponses instance,
) => <String, dynamic>{'classifications': instance.classifications};

ClassificationMainResponse _$ClassificationMainResponseFromJson(
  Map<String, dynamic> json,
) => ClassificationMainResponse(
  data: json['data'] == null
      ? null
      : ClassificationCategoryResponses.fromJson(
          json['data'] as Map<String, dynamic>,
        ),
  success: json['success'] as bool?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$ClassificationMainResponseToJson(
  ClassificationMainResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};
