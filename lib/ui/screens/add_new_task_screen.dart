import 'package:flutter/material.dart';
import 'package:task_manager/data/services/api_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});
  static const String name = '/add-new-task';

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController titleTEController = TextEditingController();
  final TextEditingController descriptionTEController = TextEditingController();
  bool _addNewTaskProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Text(
                    'Add New Task',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: titleTEController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      hint: Text(
                        'Title',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                    validator: (String? value) {
                      if (value!.trim().isEmpty) {
                        return 'Title is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: descriptionTEController,
                    textInputAction: TextInputAction.done,
                    minLines: 5,
                    maxLines: 10,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      hint: Text(
                        'Description',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                    validator: (String? value) {
                      if (value!.trim().isEmpty) {
                        return 'Description is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  Visibility(
                    visible: _addNewTaskProgress == false,
                    replacement: CenterCircularProgressIndicator(),
                    child: FilledButton(
                      onPressed: _onTapAddButton,
                      child: Icon(Icons.navigate_next),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapAddButton() {
    if (_formKey.currentState!.validate()) {
      _addNewTask();
    }
  }

  Future<void> _addNewTask() async {
    setState(() {
      _addNewTaskProgress = true;
    });
    Map<String, dynamic> requestBody = {
      "title": titleTEController.text.trim(),
      "description": descriptionTEController.text.trim(),
      "status": "New",
    };
    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.createTask,
      body: requestBody,
    );

    if (response.isSuccess) {
      _clearTextFields();
      showSnackBarMessage(context, 'Task added successfully');
      Navigator.of(context).pop();
    } else {
      showSnackBarMessage(context, response.errorMessage!);

    }
    setState(() {
      _addNewTaskProgress = false;
    });
  }

  void _clearTextFields() {
    titleTEController.clear();
    descriptionTEController.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleTEController.dispose();
    descriptionTEController.dispose();
    super.dispose();
  }
}
