import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager/ui/utils/asset_paths.dart';

import '../widgets/screen_background.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moveToNextScreen();
  }
  Future<void> _moveToNextScreen() async{
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(child: Center(
        child: SvgPicture.asset(AssetPaths.logoSvg,height: 40,),
      ),
    )
    );
  }
}
