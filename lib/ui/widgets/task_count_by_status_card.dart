import 'package:flutter/material.dart';

class TaskCountByStatusCard extends StatelessWidget {
  const TaskCountByStatusCard({
    super.key,
    required this.status,
    required this.count,
  });
  final String status;
  final int count;
  @override
  Widget build(BuildContext context) {
    //This code is temporarily commented out
     return Card(
       margin: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
       elevation: 0,
       color: Colors.white,
       child: Padding(
         padding: EdgeInsets.symmetric(horizontal: 34, vertical: 8),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text(count.toString(), style: Theme.of(context).textTheme.titleLarge),
             SizedBox(height: 4,),
             Text(
                status,
              style: Theme.of(
                 context,
               ).textTheme.bodySmall?.copyWith(color: Colors.grey),
             ),
           ],
         ),
       ),
     );
    // return Container(
    //   //alignment: Alignment.center,
    //   height: 100,
    //   width: 90,
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(16)
    //   ),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Text('08',style: Theme.of(context).textTheme.titleLarge,),
    //       SizedBox(height: 4,),
    //       Text('In Progress',style: Theme.of(context).textTheme.bodySmall,)
    //     ],
    //   ),
    // );
  }
}
