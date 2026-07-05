// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListApp _$ListAppFromJson(Map<String, dynamic> json) => ListApp(
  json['id'] as String?,
  json['name'] as String?,
  json['platform'] as String?,
  (json['categories'] as List<dynamic>?)
      ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ListAppToJson(ListApp instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'platform': instance.platform,
  'categories': instance.categories,
};

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  json['id'] as String?,
  json['name'] as String?,
  json['type'] as String?,
  (json['displayOrder'] as num?)?.toInt(),
  (json['imageCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'type': instance.type,
  'displayOrder': instance.displayOrder,
  'imageCount': instance.imageCount,
};

HomeDataResponse _$HomeDataResponseFromJson(Map<String, dynamic> json) =>
    HomeDataResponse(
      (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['apps'] as List<dynamic>?)
          ?.map((e) => ListApp.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeDataResponseToJson(HomeDataResponse instance) =>
    <String, dynamic>{'categories': instance.categories, 'apps': instance.apps};

HomeResponse _$HomeResponseFromJson(Map<String, dynamic> json) => HomeResponse(
  data: json['data'] == null
      ? null
      : HomeDataResponse.fromJson(json['data'] as Map<String, dynamic>),
  success: json['success'] as bool?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$HomeResponseToJson(HomeResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
