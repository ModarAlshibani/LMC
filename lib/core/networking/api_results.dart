import 'package:freezed_annotation/freezed_annotation.dart';
part 'api_results.freezed.dart';

@Freezed()
abstract class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success(T data) = Success<T>;
  const factory ApiResult.failure(String message) = Failure<T>;
}
