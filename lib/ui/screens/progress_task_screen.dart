import 'package:flutter/material.dart';

import '../widgets/task_card.dart';
import '../widgets/task_count_by_status_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});
  static const String name= '/progress-task';

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.separated( itemCount: 10,itemBuilder: (context,index){
                  return TaskCard(color: Color(0xffba1298), status: 'In Progress',);
                }, separatorBuilder: (context,index){
                  return SizedBox(height: 0,);
                },)
            ),
          ],
        ),
      ),
    );
  }
}
