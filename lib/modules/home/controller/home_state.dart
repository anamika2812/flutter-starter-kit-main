part of 'home_bloc.dart';

class HomeState {
  final List<TodoDTO> todos;
  final bool isFetching;
  final bool isDeleting;
  final String deletingId;
  final Option<Either<Failure, Unit>>? result;

  HomeState(
    this.todos,
    this.isFetching,
    this.isDeleting,
    this.deletingId,
    this.result,
  );

  HomeState.initial()
      : todos = [],
        isFetching = false,
        isDeleting = false,
        deletingId = "",
        result = none();

  HomeState copyWith({
    List<TodoDTO>? todos,
    bool? isFetching,
    bool? isDeleting,
    String? deletingId,
    Option<Either<Failure, Unit>>? result,
  }) {
    return HomeState(
      todos ?? this.todos,
      isFetching ?? this.isFetching,
      isDeleting ?? this.isDeleting,
      deletingId ?? this.deletingId,
      result ?? this.result,
    );
  }
}
