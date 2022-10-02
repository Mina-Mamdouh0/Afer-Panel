import 'package:flutter/material.dart';
import '../Compoands/widget.dart';
import '../res/photo_manger.dart';
import 'auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 1;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        opacity = 1.8;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: AnimatedScale(
          scale: opacity,
          curve: Curves.easeInBack,
          duration: const Duration(seconds: 2),
          onEnd: (){
            navigator(context: context,page: const Login(),returnPage: false);
          },
          child: Center(
              child: Image.asset(
                PhotoManger.aferLogo,
                height: 600,
                width: 600,
              )
          ),
        ),
      ),

    );
  }
}
