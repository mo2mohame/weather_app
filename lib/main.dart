import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Animation controller for 2 seconds
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();  // Start the animation

    // Fade-in effect animation
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // Navigate to HomePage after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,  // Background color
      body: FadeTransition(
        opacity: _animation,  // Apply the fade-in animation
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Rounded logo container
              Container(
                width: 150,  // Adjust the size
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),  // Half of the size for full rounding
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png'),  // Your logo path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),  // Space between logo and app name
              Text(
                'WeatherPro',  // App name or tagline
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WeatherPro Home'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Text('Welcome to WeatherPro App!'),  // Placeholder home page
      ),
    );
  }
}
