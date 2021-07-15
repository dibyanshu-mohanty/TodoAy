import 'dart:collection';
import 'package:flutter/material.dart';
import 'task.dart';
class TaskData extends ChangeNotifier{
  List<Task> _tasks = [
  ];
  int get taskLen => _tasks.length;

  UnmodifiableListView<Task> get newTasks => UnmodifiableListView(_tasks);

  void addTask(Task newTask){
    _tasks.add(newTask);
    notifyListeners();
  }

  void checkTask(Task newTask){
    newTask.toggleDone();
    notifyListeners();
  }

  void deleteTask (Task task){
    _tasks.remove(task);
    notifyListeners();
  }
}