import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:expenseapp/globel_variables.dart';
import 'package:expenseapp/utility_colors/colors.dart';
import 'package:expenseapp/views/Home/homepage.dart';
import 'package:expenseapp/views/Ledger_Master/ledger_master.dart';
import 'package:expenseapp/views/Name_master/name_master.dart';
import 'package:expenseapp/views/Otp_verification/mob_no_verification.dart';
import 'package:expenseapp/views/Otp_verification/otp_verify.dart';
import 'package:expenseapp/views/Report_Master/report_master.dart';
import 'package:expenseapp/views/Type_Master/type_master.dart';
import 'package:expenseapp/views/login_screen/login.dart';
import 'package:expenseapp/views/register/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _HomepageState();
}

class _HomepageState extends State<BottomNavigation> {
  PageController _pageController = PageController();
  int pageindex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    final _selectedindex;
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          Container(
              width: 40,
              height: 40,
              child: Image.asset(
                "assets/images/btn1-removebg-preview.png",
                fit: BoxFit.fill,
              )),
          Container(
              width: 40,
              height: 40,
              child: Image.asset(
                "assets/images/btn2-removebg-preview.png",
                fit: BoxFit.cover,
              )),
          Container(
              width: 40,
              height: 40,
              child: Image.asset(
                "assets/images/btn33-removebg-preview.png",
                fit: BoxFit.fill,
              )),
          Container(
              width: 40,
              height: 40,
              child: Image.asset(
                "assets/images/btn4-removebg-preview.png",
                fit: BoxFit.fill,
              )),
          Container(
              width: 40,
              height: 40,
              child: Image.asset(
                "assets/images/btn5-removebg-preview.png",
                fit: BoxFit.fill,
              )),
        ],
        onTap: (selectedindex) {
          setState(() {
            _pageController.jumpToPage(selectedindex);
          });
        },
        height: 70,
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: ColorControllers().maincolor,
        color: ColorControllers().ElevatedButtoncolor,
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          Homepage(username: username,),
          const NameMaster(),
          const TypeMaster(),
          const LedgerMaster(),
          const ReportMaster()
        ],
        onPageChanged: (int index) {
          setState(() {
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}
