part of 'home_bloc.dart';

abstract class HomeEvent {}

class FetchTodos extends HomeEvent {}

class DeleteTodo extends HomeEvent {
  final String id;

  DeleteTodo(this.id);
}
