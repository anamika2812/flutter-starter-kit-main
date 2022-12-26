import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../_utils/entities/api_response.dart';
import '../../../_utils/ui_components/widget_extensions.dart';
import '../../home/models/todo_dto.dart';

abstract class ITodoRepository {
  Future<APIResponse<TodoDTO>> addTodo(TodoDTO todoDTO);
  Future<APIResponse<TodoDTO>> updateTodo(TodoDTO todoDTO);
}

class TodoRepositotyImpl implements ITodoRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<APIResponse<TodoDTO>> addTodo(TodoDTO todoDTO) async {
    try {
      todoDTO = todoDTO.copyWith(timestamp: Timestamp.now());

      final docRef = await firestore.collection("todos").add(todoDTO.toMap());

      todoDTO = todoDTO.copyWith(id: docRef.id);
      return right(todoDTO);
    } on FirebaseException catch (e) {
      "firebase ex:\nmsg: ${e.message}\nplugin:".logIt;
      return left(Failure(code: 400, response: e.message ?? ""));
    } catch (e) {
      "msg: ${e.toString()}\nplugin:".logIt;
      return left(Failure(code: 400, response: e.toString()));
    }
  }

  @override
  Future<APIResponse<TodoDTO>> updateTodo(TodoDTO todoDTO) async {
    try {
      todoDTO = todoDTO.copyWith(timestamp: Timestamp.now());

      await firestore.collection("todos").doc(todoDTO.id).set(todoDTO.toMap());

      return right(todoDTO);
    } on FirebaseException catch (e) {
      "firebase ex:\nmsg: ${e.message}\nplugin:".logIt;
      return left(Failure(code: 400, response: e.message ?? ""));
    } catch (e) {
      "msg: ${e.toString()}\nplugin:".logIt;
      return left(Failure(code: 400, response: e.toString()));
    }
  }
}
