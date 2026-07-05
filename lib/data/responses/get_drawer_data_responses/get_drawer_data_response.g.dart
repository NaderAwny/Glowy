// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_drawer_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrawerApp _$DrawerAppFromJson(Map<String, dynamic> json) => DrawerApp(
  id: json['id'] as String?,
  name: json['name'] as String?,
  description: json['description'] as String?,
  platform: json['platform'] as String?,
  about: json['about'] as String?,
  privacyPolicy: json['privacyPolicy'] as String?,
  termsOfUse: json['termsOfUse'] as String?,
  androidShareLink: json['androidShareLink'] as String?,
  iphoneShareLink: json['iphoneShareLink'] as String?,
  contactEmail: json['contactEmail'] as String?,
  categories: (json['categories'] as List<dynamic>?)
      ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DrawerAppToJson(DrawerApp instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'platform': instance.platform,
  'about': instance.about,
  'privacyPolicy': instance.privacyPolicy,
  'termsOfUse': instance.termsOfUse,
  'androidShareLink': instance.androidShareLink,
  'iphoneShareLink': instance.iphoneShareLink,
  'contactEmail': instance.contactEmail,
  'categories': instance.categories,
};

GetDrawerDataResponseData _$GetDrawerDataResponseDataFromJson(
  Map<String, dynamic> json,
) => GetDrawerDataResponseData(
  app: json['app'] == null
      ? null
      : DrawerApp.fromJson(json['app'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GetDrawerDataResponseDataToJson(
  GetDrawerDataResponseData instance,
) => <String, dynamic>{'app': instance.app};

GetDrawerDataResponse _$GetDrawerDataResponseFromJson(
  Map<String, dynamic> json,
) => GetDrawerDataResponse(
  data: json['data'] == null
      ? null
      : GetDrawerDataResponseData.fromJson(
          json['data'] as Map<String, dynamic>,
        ),
  success: json['success'] as bool?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$GetDrawerDataResponseToJson(
  GetDrawerDataResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};
