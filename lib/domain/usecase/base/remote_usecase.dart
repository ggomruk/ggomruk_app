import '../../repository/repository.dart';

abstract class RemoteUsecase<T extends Repository> {
  Future call(T repository);
}

abstract class StreamUsecase<T> {
  Stream<dynamic> call(T repository);
}