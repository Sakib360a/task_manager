import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({super.key, this.fromUpdateProfile});
  final bool? fromUpdateProfile;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff21bf73),
      title: GestureDetector(
        onTap: () {
          if(fromUpdateProfile ?? false)
            {
              return;
            }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
          );
        },
        child: Row(
          spacing: 10,
          children: [
            CircleAvatar(
              child: Image.asset('assets/images/profile_placeholder.png'),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Full Name',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'email@gmail.com',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
        SizedBox(width: 5),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
