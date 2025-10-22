import 'package:flutter/material.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';

class TMAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TMAppBar({super.key, this.fromUpdateProfile});
  final bool? fromUpdateProfile;

  @override
  State<TMAppBar> createState() => _TMAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TMAppBarState extends State<TMAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xff21bf73),
      iconTheme: const IconThemeData(color: Colors.white),
      title: GestureDetector(
        onTap: () {
          if (widget.fromUpdateProfile ?? false) {
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UpdateProfileScreen()),
          );
        },
        child: Row(
          children: [
            const CircleAvatar(
              child: Image(image: AssetImage('assets/images/profile_placeholder.png')),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthController.userModel?.fullName ?? '',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                ),
                Text(
                  AuthController.userModel?.email ?? '',
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
        //IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        IconButton(onPressed: _signOut, icon: const Icon(Icons.logout)),
        const SizedBox(width: 10),
      ],
    );
  }

  Future<void> _signOut() async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: const Text('Logout'),
              content: const Text('Are you sure you want to logout?'),
              actions: [
                Column(
                  children: [
                    FilledButton(
                        style: FilledButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () async {
                          await AuthController.clearUserData();
                          Navigator.pushNamedAndRemoveUntil(
                              context, LoginScreen.name, (predicate) => false);
                        },
                        child: const Text('Yes')),
                        const SizedBox(height: 16,),
                    FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('No')),
                  ],
                )
              ],
            ));
  }
}
