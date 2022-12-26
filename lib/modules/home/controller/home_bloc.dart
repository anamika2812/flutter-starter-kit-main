import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../models/todo_dto.dart';

import '../../../_utils/entities/api_response.dart';
import '../repo/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<FetchTodos>((event, emit) async {
      emit(state.copyWith(isFetching: true));

      final result = await HomeRepositoryImpl().fetchTodos();

      final updatedState = result.fold(
        (l) => state.copyWith(
          isFetching: false,
          result: optionOf(left(l)),
        ),
        (r) => state.copyWith(
          isFetching: false,
          todos: r,
          result: optionOf(right(unit)),
        ),
      );

      emit(updatedState);
    });

    on<DeleteTodo>((event, emit) async {
      if (event.id != state.deletingId) {
        emit(state.copyWith(isDeleting: true, deletingId: event.id));

        final result = await HomeRepositoryImpl().deleteTodo(state.deletingId);

        final updatedState = result.fold(
          (l) => state.copyWith(
            isDeleting: false,
            deletingId: "",
            result: optionOf(left(l)),
          ),
          (r) => state.copyWith(
            isDeleting: false,
            deletingId: "",
            todos: state.todos.where((el) => el.id != event.id).toList(),
            result: optionOf(right(unit)),
          ),
        );

        emit(updatedState);
      }
    });
  }
}
