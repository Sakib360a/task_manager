import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/models/task_status_count_model.dart';
import 'package:task_manager/data/services/api_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

import '../widgets/task_card.dart';
import '../widgets/task_count_by_status_card.dart';
import 'add_new_task_screen.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});
  static const String name = '/new-task';

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  bool _getNewTasksInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];
  List<TaskModel> _newTaskList = [];

  @override
  void initState() {
    super.initState();
    _getAllTaskStatusCount();
    _getNewTasks();
  }

  void _onTapFloatingAddButton() {
    Navigator.pushNamed(context, AddNewTask.name).then((value) {
      _getAllTaskStatusCount();
      _getNewTasks();
    });
  }

  Future<void> _getAllTaskStatusCount() async {
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.taskStatusCountUrl,
    );
    if (response.isSuccess) {
      List<TaskStatusCountModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskStatusCountModel.fromJson(jsonData));
      }
      _taskStatusCountList = list;
      if (mounted) {
        setState(() {});
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, response.errorMessage!);
      }
    }
  }

  Future<void> _getNewTasks() async {
    _getNewTasksInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.newTasksUrl,
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _newTaskList = list;
    } else {
      if (mounted) {
        showSnackBarMessage(context, response.errorMessage!);
      }
    }
    _getNewTasksInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _deleteTask(String id) async {
    final ApiResponse response = await ApiCaller.getRequest(
      url: '${Urls.deleteTaskUrl}/$id',
    );
    if (response.isSuccess) {
      await Future.wait([_getNewTasks(), _getAllTaskStatusCount()]);
    } else {
      if (mounted) {
        showSnackBarMessage(context, response.errorMessage!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _taskStatusCountList.where((e) => e.status == 'New').map((e) {
                    return TaskCountByStatusCard(
                      status: 'New',
                      count: e.count,
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Visibility(
                visible: _getNewTasksInProgress == false,
                replacement: const CenterCircularProgressIndicator(),
                child: RefreshIndicator(
                  onRefresh: () async {
                    await Future.wait([_getNewTasks(), _getAllTaskStatusCount()]);
                  },
                  child: Visibility(
                    visible: _newTaskList.isNotEmpty,
                    replacement: const Center(
                      child: Text('No new tasks'),
                    ),
                    child: ListView.separated(
                      itemCount: _newTaskList.length,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          title: _newTaskList[index].title ?? '',
                          description: _newTaskList[index].description ?? '',
                          color: Color(0xff46bae4),
                          status: 'New',
                          date: _newTaskList[index].createdDate ?? '',
                          onDelete: () async {
                            await _deleteTask(_newTaskList[index].sId!);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 0);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Colors.transparent,
        onPressed: _onTapFloatingAddButton,
        child: Image.asset('assets/icons/plus.png', scale: 12),
      ),
    );
  }
}
