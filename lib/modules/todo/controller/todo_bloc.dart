import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../_utils/entities/api_response.dart';
import '../../home/models/todo_dto.dart';
import '../repo/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState.initial()) {
    on<EditingTodo>((event, emit) {
      if (event.value != null) {
        emit(state.copyWith(
          disabled: true,
          currentTodo: event.value,
          updatingTodo: event.value,
          titleController: TextEditingController(text: event.value?.title),
          descController: TextEditingController(text: event.value?.description),
        ));
      }
    });

    on<ChangeTitle>((event, emit) {
      emit(state.copyWith(
        disabled: event.value == state.updatingTodo.title &&
            state.updatingTodo.description == state.currentTodo.description,
        currentTodo: state.currentTodo.copyWith(title: event.value),
      ));
    });

    on<ChangeDescription>((event, emit) {
      emit(state.copyWith(
        disabled: event.value == state.updatingTodo.description &&
            state.updatingTodo.title == state.currentTodo.title,
        currentTodo: state.currentTodo.copyWith(description: event.value),
      ));
    });

    on<SaveTodo>((event, emit) async {
      if (!state.isProgressing) {
        emit(state.copyWith(isProgressing: true));
        APIResponse<TodoDTO> result;

        if (state.currentTodo.id.isEmpty) {
          result = await TodoRepositotyImpl().addTodo(state.currentTodo);
        } else {
          result = await TodoRepositotyImpl().updateTodo(state.currentTodo);
        }

        final updatedState = result.fold(
          (l) => state.copyWith(
            isProgressing: false,
            result: optionOf(left(l)),
          ),
          (r) => state.copyWith(
            isProgressing: false,
            result: optionOf(right(unit)),
          ),
        );

        emit(updatedState);
      }
    });
  }
}
