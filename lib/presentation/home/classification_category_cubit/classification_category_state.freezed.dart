// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'classification_category_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ClassificationCategoryState {

 FlowState? get flowState; ClassificationCategoryMainModel? get data;
/// Create a copy of ClassificationCategoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClassificationCategoryStateCopyWith<ClassificationCategoryState> get copyWith => _$ClassificationCategoryStateCopyWithImpl<ClassificationCategoryState>(this as ClassificationCategoryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClassificationCategoryState&&(identical(other.flowState, flowState) || other.flowState == flowState)&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,flowState,data);

@override
String toString() {
  return 'ClassificationCategoryState(flowState: $flowState, data: $data)';
}


}

/// @nodoc
abstract mixin class $ClassificationCategoryStateCopyWith<$Res>  {
  factory $ClassificationCategoryStateCopyWith(ClassificationCategoryState value, $Res Function(ClassificationCategoryState) _then) = _$ClassificationCategoryStateCopyWithImpl;
@useResult
$Res call({
 FlowState? flowState, ClassificationCategoryMainModel? data
});




}
/// @nodoc
class _$ClassificationCategoryStateCopyWithImpl<$Res>
    implements $ClassificationCategoryStateCopyWith<$Res> {
  _$ClassificationCategoryStateCopyWithImpl(this._self, this._then);

  final ClassificationCategoryState _self;
  final $Res Function(ClassificationCategoryState) _then;

/// Create a copy of ClassificationCategoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? flowState = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
flowState: freezed == flowState ? _self.flowState : flowState // ignore: cast_nullable_to_non_nullable
as FlowState?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ClassificationCategoryMainModel?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClassificationCategoryState].
extension ClassificationCategoryStatePatterns on ClassificationCategoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClassificationCategoryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClassificationCategoryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClassificationCategoryState value)  $default,){
final _that = this;
switch (_that) {
case _ClassificationCategoryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClassificationCategoryState value)?  $default,){
final _that = this;
switch (_that) {
case _ClassificationCategoryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FlowState? flowState,  ClassificationCategoryMainModel? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClassificationCategoryState() when $default != null:
return $default(_that.flowState,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FlowState? flowState,  ClassificationCategoryMainModel? data)  $default,) {final _that = this;
switch (_that) {
case _ClassificationCategoryState():
return $default(_that.flowState,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FlowState? flowState,  ClassificationCategoryMainModel? data)?  $default,) {final _that = this;
switch (_that) {
case _ClassificationCategoryState() when $default != null:
return $default(_that.flowState,_that.data);case _:
  return null;

}
}

}

/// @nodoc


class _ClassificationCategoryState implements ClassificationCategoryState {
  const _ClassificationCategoryState({this.flowState, this.data});
  

@override final  FlowState? flowState;
@override final  ClassificationCategoryMainModel? data;

/// Create a copy of ClassificationCategoryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClassificationCategoryStateCopyWith<_ClassificationCategoryState> get copyWith => __$ClassificationCategoryStateCopyWithImpl<_ClassificationCategoryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClassificationCategoryState&&(identical(other.flowState, flowState) || other.flowState == flowState)&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,flowState,data);

@override
String toString() {
  return 'ClassificationCategoryState(flowState: $flowState, data: $data)';
}


}

/// @nodoc
abstract mixin class _$ClassificationCategoryStateCopyWith<$Res> implements $ClassificationCategoryStateCopyWith<$Res> {
  factory _$ClassificationCategoryStateCopyWith(_ClassificationCategoryState value, $Res Function(_ClassificationCategoryState) _then) = __$ClassificationCategoryStateCopyWithImpl;
@override @useResult
$Res call({
 FlowState? flowState, ClassificationCategoryMainModel? data
});




}
/// @nodoc
class __$ClassificationCategoryStateCopyWithImpl<$Res>
    implements _$ClassificationCategoryStateCopyWith<$Res> {
  __$ClassificationCategoryStateCopyWithImpl(this._self, this._then);

  final _ClassificationCategoryState _self;
  final $Res Function(_ClassificationCategoryState) _then;

/// Create a copy of ClassificationCategoryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? flowState = freezed,Object? data = freezed,}) {
  return _then(_ClassificationCategoryState(
flowState: freezed == flowState ? _self.flowState : flowState // ignore: cast_nullable_to_non_nullable
as FlowState?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ClassificationCategoryMainModel?,
  ));
}


}

// dart format on
