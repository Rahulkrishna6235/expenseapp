import 'package:expenseapp/Fonts/fonts.dart';
import 'package:expenseapp/utility_colors/colors.dart';
import 'package:expenseapp/views/Ledger_Master/ledger_master.dart';
import 'package:expenseapp/views/Name_master/name_master.dart';
import 'package:expenseapp/views/Report_Master/report_master.dart';
import 'package:expenseapp/views/Type_Master/type_master.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Homepage extends StatefulWidget {
  final String username;
  const Homepage({super.key,required this.username});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorControllers().maincolor,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                height: 300,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 270,
                      decoration: BoxDecoration(
                          color: ColorControllers().ElevatedButtoncolor,
                          //color: Color(0xFFD3649F),
                          // gradient: const LinearGradient(
                          //     begin: Alignment.topCenter,
                          //     end: Alignment.bottomCenter,
                          //     colors: [
                          //       Color.fromARGB(255, 180, 45, 117),
                          //       Color.fromARGB(255, 211, 67, 144),
                          //       Color.fromARGB(255, 206, 89, 151),
                          //       Color.fromARGB(255, 212, 134, 176),
                          //     ]),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Image.asset(
                        "assets/images/homeimage.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                        right: 20,
                        top: 20,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.logout,
                            size: 30,
                            color: Colors.white,
                          ),
                        )),
                    Positioned(
                        left: 172,
                        bottom: 0,
                        child: Container(
                            padding: EdgeInsets.all(4),
                            width: 80,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: ColorControllers().maincolor,
                            ),
                            child: Image.asset("assets/icons/LOGO 2.png")))
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 300,
                height: 155,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 184, 70, 172),
                          Color.fromARGB(255, 196, 101, 186),
                          Color.fromARGB(255, 196, 101, 186),
                          Color.fromARGB(255, 221, 116, 172),

                          // Color(0xFFF287E8),
                          // Color(0xFFE4B5E0),
                        ])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //   width: 250,
                    //   height: 125,
                    //   child: Image.asset(
                    //     "assets/images/welcom33-removebg-preview.png",
                    //     fit: BoxFit.fill,
                    //   ),
                    // ),
                    Text(
                      " !𝐖𝐄𝐋𝐂𝐎𝐌𝐄!",
                      style: TextStyle(fontSize: 40),
                    ),

                    Text(
                      "${widget.username}",
                      style: TextStyle(fontSize: 25),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NameMaster()));
                      },
                      child: MasterNameHome("Name\n  List")),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TypeMaster()));
                      },
                      child: MasterNameHome("Ledger \n  Type")),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LedgerMaster()));
                      },
                      child: MasterNameHome("Ledger")),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ReportMaster()));
                      },
                      child: MasterNameHome("Report")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget MasterNameHome(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      child: Container(
        width: 140,
        height: 110,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                  color: Colors.black26)
            ],
            //color: Color.fromARGB(255, 196, 72, 126)
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 184, 70, 172),
                  Color.fromARGB(255, 196, 114, 187),
                  Color.fromARGB(255, 184, 70, 172),
                ])),
        child: Center(
          child: Text(
            text,
            style: getFonts(17, Colors.white),
          ),
        ),
      ),
    );
  }
}
