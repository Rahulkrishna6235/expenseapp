import 'package:expenseapp/Fonts/fonts.dart';
import 'package:expenseapp/utility_colors/colors.dart';
import 'package:expenseapp/views/Otp_verification/mob_no_verification.dart';
import 'package:expenseapp/views/widgets/clipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD3649F),
      // Color(0xFF9E0216),
      // Color(0xFFBD5404),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 400,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                        color: Color.fromARGB(255, 209, 125, 170)
                        //color: Color.fromARGB(255, 189, 95, 23)
                        // color: Color.fromARGB(255, 168, 28, 47),
                        //color: Color.fromARGB(255, 160, 21, 165),
                        ),
                  ),
                  Positioned(
                      child: Container(
                    width: double.infinity,
                    height: 300,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(80),
                          bottomRight: Radius.circular(80),
                        ),
                        color: Color.fromARGB(255, 228, 150, 192)
                        //color: Color.fromARGB(255, 201, 127, 70)

                        //color: Color.fromARGB(255, 175, 58, 74),

                        //color: Color.fromARGB(255, 210, 100, 214),
                        ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Manage Business Expenses\n    Anywhere In Real Time",
                          style: adjust(25, Colors.black),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "     Boost your team productivity by automating\n your your expence management Process our easy \n to use tool transforms outdated expence report\nfilling for your employees in to just a single clickes",
                          style: getFonts(13, ColorControllers().hintTextColor),
                        )
                      ],
                    ),
                  )),
                  Positioned(
                      left: 50,
                      right: 50,
                      bottom: 30,
                      child: Container(
                        width: 110,
                        height: 110,
                        child: Image.asset("assets/images/chartexpense.png"),
                      ))
                ],
              ),
              image(),
              button()
            ],
          ),
        ),
      ),
    );
  }

  Widget image() {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 70),
      width: 500,
      height: 265,
      child: Image.asset(
        "assets/images/splash33-removebg-preview.png",
        fit: BoxFit.fill,
      ),
    );
  }

  Widget button() {
    return Container(
      width: 320,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 180, 75, 131),

            //backgroundColor: Color.fromARGB(255, 99, 5, 18),

            //backgroundColor: Color.fromARGB(255, 86, 2, 88),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => otpmobile()));
          },
          child: Text(
            "Lets Get Started",
            style: TextStyle(fontSize: 20, color: ColorControllers().textcolor),
          )),
    );
  }
}
