// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

class TodoState {
  final TodoDTO currentTodo;
  final TodoDTO updatingTodo;
  final TextEditingController titleController;
  final TextEditingController descController;
  final bool isProgressing;
  final bool disabled;
  final Option<Either<Failure, Unit>> result;

  TodoState(
    this.currentTodo,
    this.updatingTodo,
    this.titleController,
    this.descController,
    this.isProgressing,
    this.disabled,
    this.result,
  );

  TodoState.initial()
      : currentTodo = TodoDTO.fromMap({}),
        updatingTodo = TodoDTO.fromMap({}),
        titleController = TextEditingController(),
        descController = TextEditingController(),
        isProgressing = false,
        disabled = false,
        result = none();

  TodoState copyWith({
    TodoDTO? currentTodo,
    TodoDTO? updatingTodo,
    TextEditingController? titleController,
    TextEditingController? descController,
    bool? isProgressing,
    bool? disabled,
    Option<Either<Failure, Unit>>? result,
  }) {
    return TodoState(
      currentTodo ?? this.currentTodo,
      updatingTodo ?? this.updatingTodo,
      titleController ?? this.titleController,
      descController ?? this.descController,
      isProgressing ?? this.isProgressing,
      disabled ?? this.disabled,
      result ?? this.result,
    );
  }
}
