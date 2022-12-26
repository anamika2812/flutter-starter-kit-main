import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../modules/home/models/todo_dto.dart';

class TodoDetail extends StatelessWidget {
  final TodoDTO todoDTO;
  const TodoDetail({super.key, required this.todoDTO});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints(minHeight: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            todoDTO.title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: 1.2.h),
          Flexible(
            child: SingleChildScrollView(
              child: Text(
                todoDTO.description,
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          )
        ],
      ),
    );
  }
}
