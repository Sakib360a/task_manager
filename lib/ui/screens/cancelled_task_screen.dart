import 'package:flutter/material.dart';

import '../widgets/task_card.dart';
import '../widgets/task_count_by_status_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});
  static const String name= '/cancelled-task';

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.separated( itemCount: 10,itemBuilder: (context,index){
                  return TaskCard(color: Color(0xffe24851), status: 'Cancelled',);
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
