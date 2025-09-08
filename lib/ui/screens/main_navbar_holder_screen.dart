import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/progress_task_screen.dart';
class MainNavbarHolderScreen extends StatefulWidget {
  const MainNavbarHolderScreen({super.key});

  @override
  State<MainNavbarHolderScreen> createState() => _MainNavbarHolderScreenState();
}

class _MainNavbarHolderScreenState extends State<MainNavbarHolderScreen> {
  int _selectedIndex=0;
  final List<Widget> _screens= [
    ProgressTaskScreen(),
    ProgressTaskScreen(),
    ProgressTaskScreen(),
    ProgressTaskScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff21bf73),
        title: Row(
          spacing: 10,
          children: [
            CircleAvatar(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Full Name',style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,color: Colors.white)),
                Text('email@gmail.com',style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white)),
              ],
            )
          ],
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none_outlined)),
          IconButton(onPressed: (){}, icon: Icon(Icons.search)),
          IconButton(onPressed: (){}, icon: Image.asset('assets/icons/logout_icon.png',scale: 18,)),
          SizedBox(width: 5,),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar:NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index){
            setState(() {
              _selectedIndex=index;
            });
          },
          destinations: [
        NavigationDestination(icon: Image.asset('assets/icons/new_tasks.png',scale: 16,),label: 'New Task'),
        NavigationDestination(icon: Image.asset('assets/icons/completed_task.png',scale: 16,),label: 'Completed'),
        NavigationDestination(icon: Image.asset('assets/icons/cancelled_task.png',scale: 16,),label: 'Cancelled'),
        NavigationDestination(icon: Image.asset('assets/icons/in_progress_task.png',scale: 16,),label: 'In Progress'),
      ])
    );
  }
}
