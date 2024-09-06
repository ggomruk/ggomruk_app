import '../../../core/error/error_response.dart';

sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get data => this is Success<T> ? (this as Success<T>).data : null;
  ErrorResponse? get error => this is Failure<T> ? (this as Failure<T>).error : null;

  R when<R>({
    required R Function(T data) success,
    required R Function(ErrorResponse error) failure,
  }) {
    return switch (this) {
      Success(data: final data) => success(data),
      Failure(error: final error) => failure(error),
    };
  }
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends Result<T> {
  final ErrorResponse error;
  const Failure(this.error);
}

// Utility functions to create Result instances
Result<T> success<T>(T data) => Success(data);
Result<T> failure<T>(ErrorResponse error) => Failure(error);