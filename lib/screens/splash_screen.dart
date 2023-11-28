import 'package:flutter/material.dart';
import 'package:myapp/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
    @override
    void initState(){
      super.initState();
      Future.delayed(Duration(seconds: 2),(){
        Navigator.pushReplacementNamed(context, '/onboardScreen');
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.redAccent,
        child: Center(
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/logo.jpg'),
                fit: BoxFit.cover,
              ),
              // borderRadius: BorderRadius.circular(999)
            ),
          ),
        ),
      ),
    );
  }
}
