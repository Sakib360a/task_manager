import 'package:flutter/material.dart';

import '../widgets/task_card.dart';
import '../widgets/task_count_by_status_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.separated( itemCount: 10,itemBuilder: (context,index){
                  return TaskCard(color: Color(0xff43b867), status: 'Completed',);
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
