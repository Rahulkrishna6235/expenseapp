import 'package:expenseapp/Fonts/fonts.dart';
import 'package:expenseapp/sql_database/helper.dart';
import 'package:expenseapp/sql_database/modal.dart';
import 'package:expenseapp/utility_colors/colors.dart';
import 'package:expenseapp/views/login_screen/login.dart';
import 'package:expenseapp/views/widgets/clipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  ValueNotifier<bool> isObscure = ValueNotifier(true);

  final TextEditingController _usernamectrl = TextEditingController();
  final TextEditingController _emailctrl = TextEditingController();
  final TextEditingController _passwordctrl = TextEditingController();
  final TextEditingController _repasswoedctrl = TextEditingController();
    final DatabaseHelper _dbHelper = DatabaseHelper();


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
              Stack(children: [
                myclipper(),
                Positioned(
                    top: 120,
                    left: 80,
                    child: Text(
                      "REGISTER",
                      style: getFonts(25, ColorControllers().textcolor),
                    )),
                Positioned(
                  top: 180,
                  left: 85,
                  child: Image.asset(
                      "assets/images/register-removebg-preview.png"),
                )
              ]),
              textfield("Username", _usernamectrl),
              SizedBox(
                height: 10,
              ),
              textfield(" Email", _emailctrl),
              SizedBox(
                height: 10,
              ),
              _passwordField(_passwordctrl, "Password"),
              SizedBox(
                height: 10,
              ),
              _passwordField(_repasswoedctrl, "Re-Password"),
              SizedBox(
                height: 10,
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
                    onPressed: () async{
                      if (_passwordctrl.text == _repasswoedctrl.text) {
                        Company newCompany = Company(
                          companyId: 1, // You can generate or assign a proper companyId
                          companyName: _usernamectrl.text,
                          address: '', // You can add a field for address if needed
                          mobile: _emailctrl.text,
                          userName: _usernamectrl.text,
                          password: _passwordctrl.text,
                        );

                        await _dbHelper.insertCompany(newCompany);

                        // Navigate to login screen
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => loginScreen()));
                      } else {
                        // Show error message if passwords do not match
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Error"),
                            content: Text("Passwords do not match!"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                          fontSize: 20, color: ColorControllers().textcolor),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textfield(
    String hint,
    TextEditingController controller,
  ) {
    return Container(
      width: 290,
      height: 58,
      decoration: BoxDecoration(
        color: Color(0xFFF6EAF6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
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
          hintText: hint,
        ),
        autofocus: true,
      ),
    );
  }

  Widget _passwordField(TextEditingController controller, String hint) {
    return Container(
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
              controller: controller,
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
                hintText: hint,
              ),
              autofocus: true,
            );
          }),
    );
  }
}
