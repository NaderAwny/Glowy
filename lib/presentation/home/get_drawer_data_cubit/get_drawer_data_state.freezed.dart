// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_drawer_data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GetDrawerDataState {

 FlowState? get flowState; DrawerAppObject? get data;
/// Create a copy of GetDrawerDataState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetDrawerDataStateCopyWith<GetDrawerDataState> get copyWith => _$GetDrawerDataStateCopyWithImpl<GetDrawerDataState>(this as GetDrawerDataState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetDrawerDataState&&(identical(other.flowState, flowState) || other.flowState == flowState)&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,flowState,data);

@override
String toString() {
  return 'GetDrawerDataState(flowState: $flowState, data: $data)';
}


}

/// @nodoc
abstract mixin class $GetDrawerDataStateCopyWith<$Res>  {
  factory $GetDrawerDataStateCopyWith(GetDrawerDataState value, $Res Function(GetDrawerDataState) _then) = _$GetDrawerDataStateCopyWithImpl;
@useResult
$Res call({
 FlowState? flowState, DrawerAppObject? data
});




}
/// @nodoc
class _$GetDrawerDataStateCopyWithImpl<$Res>
    implements $GetDrawerDataStateCopyWith<$Res> {
  _$GetDrawerDataStateCopyWithImpl(this._self, this._then);

  final GetDrawerDataState _self;
  final $Res Function(GetDrawerDataState) _then;

/// Create a copy of GetDrawerDataState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? flowState = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
flowState: freezed == flowState ? _self.flowState : flowState // ignore: cast_nullable_to_non_nullable
as FlowState?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as DrawerAppObject?,
  ));
}

}


/// Adds pattern-matching-related methods to [GetDrawerDataState].
extension GetDrawerDataStatePatterns on GetDrawerDataState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetDrawerDataState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetDrawerDataState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetDrawerDataState value)  $default,){
final _that = this;
switch (_that) {
case _GetDrawerDataState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetDrawerDataState value)?  $default,){
final _that = this;
switch (_that) {
case _GetDrawerDataState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FlowState? flowState,  DrawerAppObject? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetDrawerDataState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FlowState? flowState,  DrawerAppObject? data)  $default,) {final _that = this;
switch (_that) {
case _GetDrawerDataState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FlowState? flowState,  DrawerAppObject? data)?  $default,) {final _that = this;
switch (_that) {
case _GetDrawerDataState() when $default != null:
return $default(_that.flowState,_that.data);case _:
  return null;

}
}

}

/// @nodoc


class _GetDrawerDataState implements GetDrawerDataState {
  const _GetDrawerDataState({this.flowState, this.data});
  

@override final  FlowState? flowState;
@override final  DrawerAppObject? data;

/// Create a copy of GetDrawerDataState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetDrawerDataStateCopyWith<_GetDrawerDataState> get copyWith => __$GetDrawerDataStateCopyWithImpl<_GetDrawerDataState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetDrawerDataState&&(identical(other.flowState, flowState) || other.flowState == flowState)&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,flowState,data);

@override
String toString() {
  return 'GetDrawerDataState(flowState: $flowState, data: $data)';
}


}

/// @nodoc
abstract mixin class _$GetDrawerDataStateCopyWith<$Res> implements $GetDrawerDataStateCopyWith<$Res> {
  factory _$GetDrawerDataStateCopyWith(_GetDrawerDataState value, $Res Function(_GetDrawerDataState) _then) = __$GetDrawerDataStateCopyWithImpl;
@override @useResult
$Res call({
 FlowState? flowState, DrawerAppObject? data
});




}
/// @nodoc
class __$GetDrawerDataStateCopyWithImpl<$Res>
    implements _$GetDrawerDataStateCopyWith<$Res> {
  __$GetDrawerDataStateCopyWithImpl(this._self, this._then);

  final _GetDrawerDataState _self;
  final $Res Function(_GetDrawerDataState) _then;

/// Create a copy of GetDrawerDataState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? flowState = freezed,Object? data = freezed,}) {
  return _then(_GetDrawerDataState(
flowState: freezed == flowState ? _self.flowState : flowState // ignore: cast_nullable_to_non_nullable
as FlowState?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as DrawerAppObject?,
  ));
}


}

// dart format on
