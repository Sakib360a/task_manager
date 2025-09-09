import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/cancelled_task_screen.dart';
import 'package:task_manager/ui/screens/completed_task_screen.dart';
import 'package:task_manager/ui/screens/progress_task_screen.dart';
import '../widgets/tm_app_bar.dart';
import 'new_tasks_screen.dart';

class MainNavbarHolderScreen extends StatefulWidget {
  const MainNavbarHolderScreen({super.key});

  @override
  State<MainNavbarHolderScreen> createState() => _MainNavbarHolderScreenState();
}

class _MainNavbarHolderScreenState extends State<MainNavbarHolderScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    NewTasksScreen(),
    ProgressTaskScreen(),
    CompletedTaskScreen(),
    CancelledTaskScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          _selectedIndex = index;
          setState(() {});
        },
        destinations: [
          NavigationDestination(
            icon: Image.asset('assets/icons/new_tasks.png', scale: 17),
            label: 'New Task',
          ),
          NavigationDestination(
            icon: Image.asset('assets/icons/in_progress_task.png', scale: 17),
            label: 'In Progress',
          ),
          NavigationDestination(
            icon: Image.asset('assets/icons/completed_task.png', scale: 17),
            label: 'Completed',
          ),
          NavigationDestination(
            icon: Image.asset('assets/icons/cancelled_task.png', scale: 17),
            label: 'Cancelled',
          ),
        ],
      ),
    );
  }
}
