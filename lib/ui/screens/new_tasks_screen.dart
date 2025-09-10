import 'package:flutter/material.dart';

import '../widgets/task_card.dart';
import '../widgets/task_count_by_status_card.dart';
import 'add_new_task.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  void _onTapFloatingAddButton ()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewTask()));
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
              child: ListView.separated(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return TaskCountByStatusCard( status: 'In Progress', count: 5,);
                },
                separatorBuilder: (context, int index) {
                  return SizedBox(width: 10);
                },
              ),
            ),
            SizedBox(height: 16,),
            Expanded(
              child: ListView.separated( itemCount: 10,itemBuilder: (context,index){
                return TaskCard(color: Color(0xff46bae4), status: 'New',);
              }, separatorBuilder: (context,index){
                return SizedBox(height: 0,);
              },)
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


