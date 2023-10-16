import 'package:education_app/core/utils/typedefs.dart';

/// These abstract classes provide a structured way to define and implement use
/// cases in your application. Use cases encapsulate the business logic and
/// domain-specific operations of your application, following the Clean
/// Architecture pattern. By defining these abstract classes, you establish a
/// clear contract for use case implementations across your codebase. This
/// approach enhances code maintainability and testability. Concrete use cases
/// can be created by extending these abstract classes and providing specific
/// implementations for the `call` method, tailored to your application's
/// requirements.

abstract class FutureUsecaseWithParams<Type, Params> {
  const FutureUsecaseWithParams();

  /// Executes the use case with the provided parameters.
  ResultFuture<Type> call(Params params);
}

abstract class FutureUsecaseWithoutParams<Type> {
  const FutureUsecaseWithoutParams();

  /// Executes the use case without requiring any parameters.
  ResultFuture<Type> call();
}


abstract class StreamUsecaseWithoutParams<Type> {
  const StreamUsecaseWithoutParams();

  ResultStream<Type> call();
}


/// These abstract classes provide a structured way to define and implement use
/// cases in your application, following the Clean Architecture pattern.
/// Use cases encapsulate the business logic and domain-specific operations of
/// your application, and by defining these abstract classes, you establish a
/// clear contract for use case implementations throughout your codebase.
///
/// This approach enhances code maintainability and testability, as concrete use
/// cases can be created by extending these abstract classes and providing
/// specific implementations for the `call` method, tailored to your application's
/// requirements.
///
/// ## Example:
/// ```dart
/// class GetLiveUpdates extends StreamUsecaseWithParams<List<Update>, Params> {
///   final UpdateRepository repository;
///
///   GetLiveUpdates(this.repository);
///
///   @override
///   ResultStream<List<Update>> call(Params params) {
///     return repository.getLiveUpdates(params);
///   }
/// ```
abstract class StreamUsecaseWithParams<Type, Params> {
  const StreamUsecaseWithParams();

  /// Executes the use case with the provided parameters.
  ///
  /// Returns a [ResultStream] containing the stream of results from the use case.
  ResultStream<Type> call(Params params);
}
