import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../_utils/ui_components/buttons.dart';
import '../../../_utils/ui_components/widget_extensions.dart';
import '../../home/models/todo_dto.dart';
import '../controller/todo_bloc.dart';

class AddEditTodo extends StatelessWidget {
  const AddEditTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final result = Get.arguments;
    result.toString().logIt;
    return BlocProvider(
      create: (context) => TodoBloc()..add(EditingTodo(result)),
      child: const AddEditTodoUI(),
    );
  }
}

class AddEditTodoUI extends StatelessWidget {
  const AddEditTodoUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: BlocSelector<TodoBloc, TodoState, TodoDTO>(
          selector: (state) => state.currentTodo,
          builder: (context, state) {
            return Text(state.id.isEmpty ? "Add Todo" : "Edit Todo");
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<TodoBloc, TodoState>(
          listener: (context, state) {
            if (state.result.isSome()) {
              Get.back<TodoDTO>(result: state.currentTodo);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(height: 4.h),
                TextFormField(
                  controller: state.titleController,
                  minLines: 1,
                  maxLines: 3,
                  decoration: outlineBorderDecoration.copyWith(
                    hintText: "eg: Tomorrow's Tasks List",
                    label: const Text("Title"),
                  ),
                  onChanged: (value) =>
                      context.read<TodoBloc>().add(ChangeTitle(value)),
                ),
                SizedBox(height: 5.h),
                Expanded(
                  child: TextFormField(
                    controller: state.descController,
                    minLines: 10,
                    maxLines: 20,
                    decoration: outlineBorderDecoration.copyWith(
                      hintText: "eg:\n\n*Standup Call\n*Code Review",
                      label: const Text("Description"),
                    ),
                    onChanged: (value) =>
                        context.read<TodoBloc>().add(ChangeDescription(value)),
                  ),
                ),
                SizedBox(height: 2.h),
                PrimaryButton(
                  isDisabled: state.disabled,
                  isProgressing: state.isProgressing,
                  btnText: "Save",
                  onPressed: () {
                    context.read<TodoBloc>().add(SaveTodo());
                  },
                ),
                SizedBox(height: 5.h),
              ],
            );
          },
        ),
      ),
    );
  }
}
