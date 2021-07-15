import 'package:flutter/material.dart';
import 'task_tile.dart';
import 'package:provider/provider.dart';
import 'package:dev_todo/models/task_Data.dart';

class TasksList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) =>
          ListView.builder(
            itemCount: taskData.taskLen,
            itemBuilder: (context,index) =>
                Dismissible(
                  key: Key(taskData.newTasks[index].name),
                  onDismissed: (direction){
                    taskData.deleteTask(taskData.newTasks[index]);
                  },
                  child: TaskTile(
                      isChecked: taskData.newTasks[index].isDone,
                      taskTitle: taskData.newTasks[index].name,
                      checkboxCallBack : (checkbox){
                        taskData.checkTask(taskData.newTasks[index]);
                      }
                  ),
                  background: Container(color: Color(0xFF7C83FD)),
                ),
          ),
    );
  }
}
