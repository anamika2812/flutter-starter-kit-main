import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dartz_test/dartz_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/_utils/entities/api_response.dart';
import 'package:todo/modules/home/models/todo_dto.dart';
import 'package:todo/modules/todo/repo/todo_repository.dart';

import 'todo_repository_test.mocks.dart';

class TodoRepositoryImplTest extends Mock implements TodoRepositotyImpl {}

@GenerateMocks([TodoRepositoryImplTest])
void main() {
  late MockTodoRepositoryImplTest repo;
  setUp(() {
    repo = MockTodoRepositoryImplTest();
  });
  group("Test: Add Todo", () {
    test("Success", () async {
      final todoDTO = TodoDTO(
        id: "abcd123",
        title: "title",
        description: "description",
        timestamp: Timestamp.now(),
      );

      Either<Failure, TodoDTO> response = Right(todoDTO);

      when(repo.addTodo(todoDTO)).thenAnswer((_) async => response);

      final result = await repo.addTodo(todoDTO);

      expect(result, isRight);
      expect(result, response);
    });

    test("Failure", () async {
      final todoDTO = TodoDTO(
        id: "abcd123",
        title: "title",
        description: "description",
        timestamp: Timestamp.now(),
      );

      Either<Failure, TodoDTO> response =
          Left(Failure(code: 400, response: "Some error occurred"));

      when(repo.addTodo(todoDTO)).thenAnswer((_) async => response);

      final result = await repo.addTodo(todoDTO);

      expect(result, isLeft);
      expect(result, response);
    });
  });

  group("Test: Update Todo", () {
    test("Success", () async {
      TodoDTO todoDTO = TodoDTO(
        id: "abcd123",
        title: "title",
        description: "description",
        timestamp: Timestamp.now(),
      );

      todoDTO =
          todoDTO.copyWith(title: "new title", description: "new description");

      Either<Failure, TodoDTO> response = Right(todoDTO);

      when(repo.updateTodo(todoDTO)).thenAnswer((_) async => response);

      final result = await repo.updateTodo(todoDTO);

      expect(result, isRight);
      expect(result, response);
    });

    test("Failure", () async {
      final todoDTO = TodoDTO(
        id: "abcd123",
        title: "title",
        description: "description",
        timestamp: Timestamp.now(),
      );

      Either<Failure, TodoDTO> response =
          Left(Failure(code: 400, response: "Some error occurred"));

      when(repo.updateTodo(todoDTO)).thenAnswer((_) async => response);

      final result = await repo.updateTodo(todoDTO);

      expect(result, isLeft);
      expect(result, response);
    });
  });
}
