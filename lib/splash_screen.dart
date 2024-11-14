import 'package:flutter/material.dart';

import 'route/route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

late AnimationController _controller;
  late Animation<Offset> _animation1;
late AnimationController _controller2;
  late Animation<Offset> _animation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
     _animation1 = Tween<Offset>(
      begin: Offset(-1.0, -1.0),  
      end: Offset(-0.1, 0.0),     
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceIn,  
    ));

    _controller2 = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

   
     _animation2 = Tween<Offset>(
      begin: Offset(1.0, 1.0),  
      end: Offset(0.0, 0.0),     
    ).animate(CurvedAnimation(
      parent: _controller2,
      curve: Curves.bounceIn,  
    ));
    _controller.forward();
    _controller2.forward();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.userListScreen);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  } 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 180,
              left: 0,
              child: SlideTransition(
                position: _animation1,
                child: Icon(Icons.person_2_outlined,size: 400,fill: 1.0,)
              ),
            ),
            Positioned(
              bottom: 220,
              right: 0,
              child: SlideTransition(
                position: _animation2,
                child: Icon(Icons.info_outline_rounded,size: 130,fill: 1.0,),
              ),
            )
          ],
        ),
      )
    );
  }
}