import 'package:dartz/dartz.dart';
import 'package:dartz_test/dartz_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/_utils/entities/api_response.dart';
import 'package:todo/modules/home/models/todo_dto.dart';
import 'package:todo/modules/home/repo/home_repository.dart';

import 'home_repository_test.mocks.dart';

// import 'home_repository_test.mocks.dart';

// class HomeRepositoryTest extends Mock implements HomeRepository {}

class HomeRepositoryImplTest extends Mock implements HomeRepositoryImpl {}

@GenerateMocks([HomeRepositoryImplTest])
void main() {
  late MockHomeRepositoryImplTest repo;
  setUp(() {
    repo = MockHomeRepositoryImplTest();
  });
  group("Test: Fetch Todos", () {
    test(
      "Success",
      () async {
        Either<Failure, List<TodoDTO>> response = const Right(<TodoDTO>[]);

        when(repo.fetchTodos()).thenAnswer((_) async => response);

        final result = await repo.fetchTodos();

        expect(result, isRight);
        expect(result, response);
      },
    );

    test(
      "Failure",
      () async {
        final Either<Failure, List<TodoDTO>> response =
            Left(Failure(code: 400, response: "Some error occurred"));

        when(repo.fetchTodos()).thenAnswer((_) async => response);

        final result = await repo.fetchTodos();

        expect(result, isLeft);
        expect(result, response);
      },
    );
  });
}
