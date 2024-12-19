import 'dart:io';

import 'package:expenseapp/utility_colors/colors.dart';
import 'package:expenseapp/views/splashPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashLogo extends StatefulWidget {
  const SplashLogo({super.key});

  @override
  State<SplashLogo> createState() => _SplashLogoState();
}

class _SplashLogoState extends State<SplashLogo> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => splashscreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorControllers().maincolor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 200,
                height: 200,
                child: Image.asset("assets/icons/LOGO 2.png")),
            const SizedBox(
              height: 30,
            ),
            if (Platform.isAndroid)
              const CupertinoActivityIndicator(
                radius: 20,
              )
            else
              const CircularProgressIndicator(
                color: Colors.white,
              )
          ],
        ),
      ),
    );
  }
}
