import 'package:expenseapp/Fonts/fonts.dart';
import 'package:expenseapp/utility_colors/colors.dart';
import 'package:expenseapp/views/Otp_verification/otp_verify.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class otpmobile extends StatefulWidget {
  const otpmobile({super.key});

  @override
  State<otpmobile> createState() => _otpmobileState();
}

class _otpmobileState extends State<otpmobile> {
  bool invalidmobile = false;
  final TextEditingController _mobilotp = TextEditingController();
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
                    "Verify",
                    style: getFonts(22, Colors.black),
                  ),
                  Text(
                    "Your Mobile Number",
                    style: getFonts(22, Colors.black),
                  ),
                  Text(
                    "Enter your phone number to send",
                    style: getFonts(15, ColorControllers().hintTextColor),
                  ),
                  Text(
                    "One Time Password",
                    style: getFonts(15, ColorControllers().hintTextColor),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 290,
                    height: 58,
                    decoration: BoxDecoration(
                      color: Color(0xFFF6EAF6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _mobilotp,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: Color(0xFFF6EAF6),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Color(0xFFC272BA)),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Color(0xFFC272BA))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Color(0xFFC272BA))),
                        hintStyle: const TextStyle(color: Color(0xFF362935)),
                        hintText: "Enter Mobile Number",
                        
                      ),
                      autofocus: true,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 290,
                    height: 58,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFFF6EAF6),
                    ),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              ColorControllers().ElevatedButtoncolor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () {
                          final mobile = _mobilotp;
                          if (mobile == "964582277") {
                            setState(() {
                              invalidmobile = false;
                            });
                          } else {
                            invalidmobile = true;
                            Fluttertoast.showToast(
                                msg: "invalid Mobile Number");
                          }
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => otpVerify()));
                        },
                        child: Text(
                          "Send OTP",
                          style: TextStyle(
                              fontSize: 20,
                              color: ColorControllers().textcolor),
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Do Not Send OTP ? "),
                      Text(
                        "Resend OTP",
                        style: TextStyle(color: Color(0xFFC333B5)),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
