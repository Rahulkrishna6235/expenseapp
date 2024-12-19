import 'dart:async';

import 'package:expenseapp/Bloc/Login/Authentication/Auth_event.dart';
import 'package:expenseapp/Fonts/fonts.dart';
import 'package:expenseapp/utility_colors/colors.dart';
import 'package:expenseapp/views/BottomBar/bottombarNAvigation.dart';
import 'package:expenseapp/views/login_screen/login.dart';
import 'package:flutter/material.dart';

class otpVerify extends StatefulWidget {
  const otpVerify({super.key});

  @override
  State<otpVerify> createState() => _otpVerifyState();
}

bool invalidotp = false;
late Timer counttimer;
final TextEditingController _tex1 = TextEditingController();
final TextEditingController _tex2 = TextEditingController();
final TextEditingController _tex3 = TextEditingController();
final TextEditingController _tex4 = TextEditingController();

class _otpVerifyState extends State<otpVerify> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    _tex1.dispose();
    _tex2.dispose();
    _tex3.dispose();
    _tex4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color(0xFFF8D9F4),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 25),
                width: 300,
                height: 350,
                child: Image.asset(
                  "assets/images/otpp-removebg-preview (1).png",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Text(
                    "OTP Verification",
                    style: getFonts(22, Colors.black),
                  ),
                  Text(
                    "we will send tou a one time password on",
                    style: getFonts(15, ColorControllers().hintTextColor),
                  ),
                  Text(
                    "Your Mobile Number",
                    style: getFonts(15, ColorControllers().hintTextColor),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _otpfield(context, _tex1, _focusNode1, _focusNode2),
                      _otpfield(context, _tex2, _focusNode2, _focusNode3),
                      _otpfield(context, _tex3, _focusNode3, _focusNode4),
                      _otpfield(context, _tex4, _focusNode4, null)
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(invalidotp ? 'Invalid otp' : ""),
                  const SizedBox(
                    height: 70,
                  ),
                  Container(
                    width: 290,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFFF6EAF6),
                    ),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              ColorControllers().ElevatedButtoncolor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                        onPressed: () {
                          final otp =
                              _tex1.text + _tex2.text + _tex3.text + _tex4.text;
                          if (otp == "2000") {
                            setState(() {
                              invalidotp = false;
                            });
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => loginScreen()));
                          } else {
                            setState(() {
                              invalidotp = true;
                            });
                          }
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              fontSize: 20,
                              color: ColorControllers().textcolor),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _otpfield(BuildContext context, TextEditingController controller,
      FocusNode focusNode, FocusNode? nextFocusNode) {
    return Container(
      height: 60,
      width: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorControllers().textfieldcolor,
          boxShadow: const [
            BoxShadow(
                spreadRadius: 2,
                blurRadius: 3,
                color: Colors.black45,
                offset: Offset(0, 3))
          ]),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        decoration: InputDecoration(border: InputBorder.none),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (value.length == 1) {
            nextFocusNode?.requestFocus();
          }
        },
      ),
    );
  }
}
