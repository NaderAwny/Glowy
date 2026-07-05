// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_category_content_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GetCategoryContentState {

 FlowState? get flowState; ImageCategoryObject? get data; bool get isLoadingMore; bool get hasMore;
/// Create a copy of GetCategoryContentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetCategoryContentStateCopyWith<GetCategoryContentState> get copyWith => _$GetCategoryContentStateCopyWithImpl<GetCategoryContentState>(this as GetCategoryContentState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetCategoryContentState&&(identical(other.flowState, flowState) || other.flowState == flowState)&&(identical(other.data, data) || other.data == data)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,flowState,data,isLoadingMore,hasMore);

@override
String toString() {
  return 'GetCategoryContentState(flowState: $flowState, data: $data, isLoadingMore: $isLoadingMore, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $GetCategoryContentStateCopyWith<$Res>  {
  factory $GetCategoryContentStateCopyWith(GetCategoryContentState value, $Res Function(GetCategoryContentState) _then) = _$GetCategoryContentStateCopyWithImpl;
@useResult
$Res call({
 FlowState? flowState, ImageCategoryObject? data, bool isLoadingMore, bool hasMore
});




}
/// @nodoc
class _$GetCategoryContentStateCopyWithImpl<$Res>
    implements $GetCategoryContentStateCopyWith<$Res> {
  _$GetCategoryContentStateCopyWithImpl(this._self, this._then);

  final GetCategoryContentState _self;
  final $Res Function(GetCategoryContentState) _then;

/// Create a copy of GetCategoryContentState
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


/// Adds pattern-matching-related methods to [GetCategoryContentState].
extension GetCategoryContentStatePatterns on GetCategoryContentState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetCategoryContentState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetCategoryContentState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetCategoryContentState value)  $default,){
final _that = this;
switch (_that) {
case _GetCategoryContentState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetCategoryContentState value)?  $default,){
final _that = this;
switch (_that) {
case _GetCategoryContentState() when $default != null:
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
case _GetCategoryContentState() when $default != null:
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
case _GetCategoryContentState():
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
case _GetCategoryContentState() when $default != null:
return $default(_that.flowState,_that.data,_that.isLoadingMore,_that.hasMore);case _:
  return null;

}
}

}

/// @nodoc


class _GetCategoryContentState implements GetCategoryContentState {
  const _GetCategoryContentState({this.flowState, this.data, this.isLoadingMore = false, this.hasMore = true});
  

@override final  FlowState? flowState;
@override final  ImageCategoryObject? data;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool hasMore;

/// Create a copy of GetCategoryContentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetCategoryContentStateCopyWith<_GetCategoryContentState> get copyWith => __$GetCategoryContentStateCopyWithImpl<_GetCategoryContentState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetCategoryContentState&&(identical(other.flowState, flowState) || other.flowState == flowState)&&(identical(other.data, data) || other.data == data)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,flowState,data,isLoadingMore,hasMore);

@override
String toString() {
  return 'GetCategoryContentState(flowState: $flowState, data: $data, isLoadingMore: $isLoadingMore, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class _$GetCategoryContentStateCopyWith<$Res> implements $GetCategoryContentStateCopyWith<$Res> {
  factory _$GetCategoryContentStateCopyWith(_GetCategoryContentState value, $Res Function(_GetCategoryContentState) _then) = __$GetCategoryContentStateCopyWithImpl;
@override @useResult
$Res call({
 FlowState? flowState, ImageCategoryObject? data, bool isLoadingMore, bool hasMore
});




}
/// @nodoc
class __$GetCategoryContentStateCopyWithImpl<$Res>
    implements _$GetCategoryContentStateCopyWith<$Res> {
  __$GetCategoryContentStateCopyWithImpl(this._self, this._then);

  final _GetCategoryContentState _self;
  final $Res Function(_GetCategoryContentState) _then;

/// Create a copy of GetCategoryContentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? flowState = freezed,Object? data = freezed,Object? isLoadingMore = null,Object? hasMore = null,}) {
  return _then(_GetCategoryContentState(
flowState: freezed == flowState ? _self.flowState : flowState // ignore: cast_nullable_to_non_nullable
as FlowState?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ImageCategoryObject?,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
