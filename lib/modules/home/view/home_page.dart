import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../../_utils/constants/routes.dart';
import '../controller/home_bloc.dart';
import 'widgets/todo_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(FetchTodos()),
      child: const HomePageUI(),
    );
  }
}

class HomePageUI extends StatelessWidget with NetworkLoggy {
  const HomePageUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todos")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          loggy.debug('This is log with custom log level in  logger:');
          final result = await Get.toNamed(RouteNames.addEditTodoPage);

          if (result != null) {
            context.read<HomeBloc>().add(FetchTodos());
          }
        },
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.isFetching) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.todos.isEmpty) {
              return const Center(
                child: Text("No todos added yet."),
              );
            } else {
              return ListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (context, index) {
                  return TodoCard(
                    todoDTO: state.todos[index],
                    isProgressing: state.isDeleting,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
