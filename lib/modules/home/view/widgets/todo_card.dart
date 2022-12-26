import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../_utils/constants/routes.dart';
import '../../../../_utils/ui_components/bottom_sheets/todo_detail.dart';
import '../../controller/home_bloc.dart';
import '../../models/todo_dto.dart';

class TodoCard extends StatelessWidget {
  final TodoDTO todoDTO;
  final bool isProgressing;
  const TodoCard({Key? key, required this.todoDTO, this.isProgressing = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, String>(
      selector: (state) => state.deletingId,
      builder: (context, state) {
        return Slidable(
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) async {
                  final result = await Get.toNamed(
                    RouteNames.addEditTodoPage,
                    arguments: todoDTO,
                  );

                  if (result != null) {
                    context.read<HomeBloc>().add(FetchTodos());
                  }
                },
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) {
                  context.read<HomeBloc>().add(DeleteTodo(todoDTO.id));
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              Get.bottomSheet(
                TodoDetail(todoDTO: todoDTO),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: Colors.white,
                isScrollControlled: true,
              );
            },
            child: Card(
              elevation: 3.0,
              shadowColor: Colors.red[200],
              child: Container(
                padding: EdgeInsets.all(2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            todoDTO.title,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                        if (isProgressing && state == todoDTO.id)
                          const CircularProgressIndicator(),
                      ],
                    ),
                    SizedBox(height: 1.2.h),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 30.0),
                      child: Text(
                        todoDTO.description,
                        overflow: TextOverflow.fade,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
