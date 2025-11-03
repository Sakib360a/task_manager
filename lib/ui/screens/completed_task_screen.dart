import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/models/task_status_count_model.dart';
import 'package:task_manager/data/services/api_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

import '../widgets/task_card.dart';
import '../widgets/task_count_by_status_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});
  static const String name = '/completed-task';

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  List<TaskModel> _completedTaskList = [];
  bool _getCompletedTasksInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];

  @override
  void initState() {
    super.initState();
    _getCompletedTasks();
    _getAllTaskStatusCount();
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

  Future<void> _getCompletedTasks() async {
    _getCompletedTasksInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.completedTaskUrl,
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _completedTaskList = list;
    } else {
      if (mounted) {
        showSnackBarMessage(context, response.errorMessage!);
      }
    }
    _getCompletedTasksInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _deleteTask(String id) async {
    final ApiResponse response = await ApiCaller.getRequest(
      url: '${Urls.deleteTaskUrl}/$id',
    );
    if (response.isSuccess) {
      await Future.wait([_getCompletedTasks(), _getAllTaskStatusCount()]);
    } else {
      if (mounted) {
        showSnackBarMessage(context, response.errorMessage!);
      }
    }
  }

  Future<void> _updateTaskStatus(String id, String status) async {
    final ApiResponse response = await ApiCaller.getRequest(
      url: '${Urls.updateTaskUrl}/$id/$status',
    );
    if (response.isSuccess) {
      await Future.wait([_getCompletedTasks(), _getAllTaskStatusCount()]);
    } else {
      if (mounted) {
        showSnackBarMessage(context, response.errorMessage!);
      }
    }
  }

  void _showStatusUpdateBottomSheet(TaskModel task) {
    String? selectedStatus = task.status;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Update Status'),
                  const SizedBox(height: 16),
                  RadioListTile(
                    title: const Text('In Progress'),
                    value: 'InProgress',
                    groupValue: selectedStatus,
                    onChanged: (value) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                  RadioListTile(
                    title: const Text('Cancelled'),
                    value: 'Cancelled',
                    groupValue: selectedStatus,
                    onChanged: (value) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (selectedStatus != null && selectedStatus != task.status) {
                        await _updateTaskStatus(task.sId!, selectedStatus!);
                      }
                      if (mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Update'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
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
                  children: _taskStatusCountList.where((e) => e.status == 'Completed').map((e) {
                    return TaskCountByStatusCard(
                      status: 'Completed',
                      count: e.count,
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
                child: Visibility(
              visible: _getCompletedTasksInProgress == false,
              replacement: const CenterCircularProgressIndicator(),
              child: RefreshIndicator(
                onRefresh: () async {
                  await Future.wait([_getCompletedTasks(), _getAllTaskStatusCount()]);
                },
                child: Visibility(
                  visible: _completedTaskList.isNotEmpty,
                  replacement: const Center(
                    child: Text('No completed tasks'),
                  ),
                  child: ListView.separated(
                    itemCount: _completedTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        title: _completedTaskList[index].title ?? '',
                        description: _completedTaskList[index].description ?? '',
                        color: const Color(0xff43b867),
                        status: 'Completed',
                        date: _completedTaskList[index].createdDate ?? '',
                        onDelete: () async {
                          await _deleteTask(_completedTaskList[index].sId!);
                        },
                        onStatusEdit: () {
                          _showStatusUpdateBottomSheet(_completedTaskList[index]);
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 0,
                      );
                    },
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
