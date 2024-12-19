import 'package:expenseapp/Fonts/fonts.dart';
import 'package:expenseapp/drift/db.dart';
import 'package:expenseapp/sql_database/helper.dart';
import 'package:expenseapp/sql_database/modal.dart';
import 'package:expenseapp/utility_colors/colors.dart';
import 'package:expenseapp/views/BottomBar/bottombarNAvigation.dart';
import 'package:expenseapp/views/register/registerpage.dart';
import 'package:expenseapp/views/widgets/clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class loginScreen extends StatefulWidget {
  
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {

  ValueNotifier<bool> isObscure = ValueNotifier(true);
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passController = TextEditingController();
    final DatabaseHelper dbHelper = DatabaseHelper();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorControllers().maincolor,
      body: body(),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Stack(
              children: [
                Opacity(
                  opacity: 0.7,
                  child: ClipPath(
                    clipper: MyCustomClipper(),
                    child: Container(
                      width: double.infinity,
                      height: 400,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Color(0xFFC333B5),
                            Color(0xFFCF75D2),
                            Color(0xFFF3E4F5),
                          ])),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Positioned(
                      child: Container(
                        width: 300,
                        height: 175,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(70),
                          ),
                          color: Color(0xFFCF75D2),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        width: 200,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(40),
                          ),
                          color: Color(0xFFC272BA),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                    top: 120,
                    left: 80,
                    child: Text(
                      "LOGIN",
                      style: getFonts(35, ColorControllers().textcolor),
                    )),
                Positioned(
                  top: 180,
                  left: 85,
                  child: Image.asset(
                      "assets/images/loggin44-removebg-preview.png"),
                )
              ],
            ),
            Container(
              width: 290,
              height: 58,
              decoration: BoxDecoration(
                color: Color(0xFFF6EAF6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _usernameController,
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
                  hintStyle: const TextStyle(color: Color(0xFF948C93)),
                  hintText: "Username",
                ),
                autofocus: true,
              ),
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
              child: ValueListenableBuilder(
                  valueListenable: isObscure,
                  builder: (context, value, child) {
                    return TextField(
                      controller: _passController,
                      obscureText: value,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: Color(0xFFF6EAF6),
                        suffixIcon: IconButton(
                          onPressed: () {
                            isObscure.value = !isObscure.value;
                          },
                          icon: value
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
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
                        hintStyle: const TextStyle(color: Color(0xFF948C93)),
                        hintText: "Password",
                      ),
                      autofocus: true,
                    );
                  }),
            ),
            SizedBox(
              height: 30,
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
                    backgroundColor: ColorControllers().ElevatedButtoncolor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: _login,
                        
                 
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 20, color: ColorControllers().textcolor),
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not Yet Registered? ",
                  style: adjust(15, Colors.black),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Registerpage()));
                  },
                  child: Text(
                    "Register Now",
                    style: adjust(16, Color(0xFFC333B5)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

 void _login() async {
    String username = _usernameController.text.trim();
    String password = _passController.text.trim();

    bool isAuthenticated = await authenticateUser(username, password);

    if (isAuthenticated) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => BottomNavigation()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  Future<bool> authenticateUser(String username, String password) async {
    List<Company> companies = await dbHelper.getCompanies();
    for (Company company in companies) {
      if (company.userName.trim() == username && company.password.trim() == password) {
        return true;
      }
    }
    return false;
  }

}
