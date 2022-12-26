part of 'todo_bloc.dart';

abstract class TodoEvent {}

class EditingTodo extends TodoEvent {
  final TodoDTO? value;

  EditingTodo(this.value);
}

class ChangeTitle extends TodoEvent {
  final String value;

  ChangeTitle(this.value);
}

class ChangeDescription extends TodoEvent {
  final String value;

  ChangeDescription(this.value);
}

class SaveTodo extends TodoEvent {}
