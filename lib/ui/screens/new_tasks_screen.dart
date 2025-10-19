import 'package:flutter/material.dart';
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
  bool _getTaskStatusCountInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllTaskStatusCount();
  }
  void _onTapFloatingAddButton() {
    Navigator.pushNamed(context, AddNewTask.name).then((value) {
      _getAllTaskStatusCount();
    });
  }

  Future<void> _getAllTaskStatusCount() async {
    _getTaskStatusCountInProgress = true;
    setState(() {});
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.taskStatusCountUrl,
    );
    if(response.isSuccess){
      List<TaskStatusCountModel> list = [];
      for(Map<String, dynamic> jsonData in response.responseData['data']){
        list.add(TaskStatusCountModel.fromJson(jsonData));
      }
      _taskStatusCountList = list;
    }
    else{
      showSnackBarMessage(context, response.errorMessage!);
    }
    _getTaskStatusCountInProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 8),
            SizedBox(
              height: 100,
              child: Visibility(
                visible: _getTaskStatusCountInProgress==false,
                replacement: CenterCircularProgressIndicator(),
                child: ListView.separated(
                  itemCount: _taskStatusCountList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return TaskCountByStatusCard(status: _taskStatusCountList[index].status, count:  _taskStatusCountList[index].count);
                  },
                  separatorBuilder: (context, int index) {
                    return SizedBox(width: 10);
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return TaskCard(color: Color(0xff46bae4), status: 'New');
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 0);
                },
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
