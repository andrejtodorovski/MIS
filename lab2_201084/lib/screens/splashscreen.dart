import 'package:flutter/material.dart';
import 'package:lab2_201084/screens/clothes_list_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const ClothesListScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green[50],
        child: Center(
          child: Text("Апликација за облека",
              style: TextStyle(
                  color: Colors.green[900],
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  fontFamily: "Roboto")),
        ));
  }
}
