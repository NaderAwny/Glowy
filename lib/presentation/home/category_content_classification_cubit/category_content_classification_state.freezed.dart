// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_content_classification_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoryContentClassificationState {

 FlowState? get flowState; ImageCategoryObject? get data; bool get isLoadingMore; bool get hasMore;
/// Create a copy of CategoryContentClassificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryContentClassificationStateCopyWith<CategoryContentClassificationState> get copyWith => _$CategoryContentClassificationStateCopyWithImpl<CategoryContentClassificationState>(this as CategoryContentClassificationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryContentClassificationState&&(identical(other.flowState, flowState) || other.flowState == flowState)&&(identical(other.data, data) || other.data == data)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,flowState,data,isLoadingMore,hasMore);

@override
String toString() {
  return 'CategoryContentClassificationState(flowState: $flowState, data: $data, isLoadingMore: $isLoadingMore, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $CategoryContentClassificationStateCopyWith<$Res>  {
  factory $CategoryContentClassificationStateCopyWith(CategoryContentClassificationState value, $Res Function(CategoryContentClassificationState) _then) = _$CategoryContentClassificationStateCopyWithImpl;
@useResult
$Res call({
 FlowState? flowState, ImageCategoryObject? data, bool isLoadingMore, bool hasMore
});




}
/// @nodoc
class _$CategoryContentClassificationStateCopyWithImpl<$Res>
    implements $CategoryContentClassificationStateCopyWith<$Res> {
  _$CategoryContentClassificationStateCopyWithImpl(this._self, this._then);

  final CategoryContentClassificationState _self;
  final $Res Function(CategoryContentClassificationState) _then;

/// Create a copy of CategoryContentClassificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? flowState = freezed,Object? data = freezed,Object? isLoadingMore = null,Object? hasMore = null,}) {
  return _then(_self.copyWith(
flowState: freezed == flowState ? _self.flowState : flowState // ignore: cast_nullable_to_non_nullable
as FlowState?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ImageCategoryObject?,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryContentClassificationState].
extension CategoryContentClassificationStatePatterns on CategoryContentClassificationState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryContentClassificationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryContentClassificationState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryContentClassificationState value)  $default,){
final _that = this;
switch (_that) {
case _CategoryContentClassificationState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryContentClassificationState value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryContentClassificationState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FlowState? flowState,  ImageCategoryObject? data,  bool isLoadingMore,  bool hasMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryContentClassificationState() when $default != null:
return $default(_that.flowState,_that.data,_that.isLoadingMore,_that.hasMore);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FlowState? flowState,  ImageCategoryObject? data,  bool isLoadingMore,  bool hasMore)  $default,) {final _that = this;
switch (_that) {
case _CategoryContentClassificationState():
return $default(_that.flowState,_that.data,_that.isLoadingMore,_that.hasMore);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FlowState? flowState,  ImageCategoryObject? data,  bool isLoadingMore,  bool hasMore)?  $default,) {final _that = this;
switch (_that) {
case _CategoryContentClassificationState() when $default != null:
return $default(_that.flowState,_that.data,_that.isLoadingMore,_that.hasMore);case _:
  return null;

}
}

}

/// @nodoc


class _CategoryContentClassificationState implements CategoryContentClassificationState {
  const _CategoryContentClassificationState({this.flowState, this.data, this.isLoadingMore = false, this.hasMore = true});
  

@override final  FlowState? flowState;
@override final  ImageCategoryObject? data;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool hasMore;

/// Create a copy of CategoryContentClassificationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryContentClassificationStateCopyWith<_CategoryContentClassificationState> get copyWith => __$CategoryContentClassificationStateCopyWithImpl<_CategoryContentClassificationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryContentClassificationState&&(identical(other.flowState, flowState) || other.flowState == flowState)&&(identical(other.data, data) || other.data == data)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,flowState,data,isLoadingMore,hasMore);

@override
String toString() {
  return 'CategoryContentClassificationState(flowState: $flowState, data: $data, isLoadingMore: $isLoadingMore, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class _$CategoryContentClassificationStateCopyWith<$Res> implements $CategoryContentClassificationStateCopyWith<$Res> {
  factory _$CategoryContentClassificationStateCopyWith(_CategoryContentClassificationState value, $Res Function(_CategoryContentClassificationState) _then) = __$CategoryContentClassificationStateCopyWithImpl;
@override @useResult
$Res call({
 FlowState? flowState, ImageCategoryObject? data, bool isLoadingMore, bool hasMore
});




}
/// @nodoc
class __$CategoryContentClassificationStateCopyWithImpl<$Res>
    implements _$CategoryContentClassificationStateCopyWith<$Res> {
  __$CategoryContentClassificationStateCopyWithImpl(this._self, this._then);

  final _CategoryContentClassificationState _self;
  final $Res Function(_CategoryContentClassificationState) _then;

/// Create a copy of CategoryContentClassificationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? flowState = freezed,Object? data = freezed,Object? isLoadingMore = null,Object? hasMore = null,}) {
  return _then(_CategoryContentClassificationState(
flowState: freezed == flowState ? _self.flowState : flowState // ignore: cast_nullable_to_non_nullable
as FlowState?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ImageCategoryObject?,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
