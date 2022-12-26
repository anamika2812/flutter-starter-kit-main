import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../_utils/entities/api_response.dart';
import '../../../_utils/ui_components/widget_extensions.dart';
import '../models/todo_dto.dart';

abstract class HomeRepository {
  Future<APIResponse<List<TodoDTO>>> fetchTodos();
  Future<APIResponse<Unit>> deleteTodo(String id);
}

class HomeRepositoryImpl implements HomeRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<APIResponse<List<TodoDTO>>> fetchTodos() async {
    try {
      List<TodoDTO> todos = [];
      final query = await firestore
          .collection("todos")
          .orderBy('timestamp', descending: true)
          .get();

      for (final doc in query.docs) {
        todos.add(TodoDTO.fromMap(doc.data()).copyWith(id: doc.id));
      }

      return right(todos);
    } on FirebaseException catch (e) {
      "firebase ex:\nmsg: ${e.message}\nplugin:".logIt;
      return left(Failure(code: 400, response: e.message ?? ""));
    } catch (e) {
      "msg: ${e.toString()}\nplugin:".logIt;
      return left(Failure(code: 400, response: e.toString()));
    }
  }

  @override
  Future<APIResponse<Unit>> deleteTodo(String id) async {
    try {
      await firestore.collection("todos").doc(id).delete();

      return right(unit);
    } on FirebaseException catch (e) {
      "firebase ex:\nmsg: ${e.message}\nplugin:".logIt;
      return left(Failure(code: 400, response: e.message ?? ""));
    } catch (e) {
      "msg: ${e.toString()}\nplugin:".logIt;
      return left(Failure(code: 400, response: e.toString()));
    }
  }
}
