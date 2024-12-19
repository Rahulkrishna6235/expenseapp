import 'package:expenseapp/sql_database/helper.dart';
import 'package:expenseapp/sql_database/modal.dart';
import 'package:expenseapp/views/login_screen/login.dart';
import 'package:expenseapp/views/register/registerpage.dart';
import 'package:expenseapp/views/splash_logo.dart';
import 'package:flutter/material.dart';

import 'package:expenseapp/Bloc/Login/Ledger%20master/ledger_bloc.dart';
import 'package:expenseapp/Bloc/Login/NameMaster/Name_bolc.dart';
import 'package:expenseapp/Bloc/Login/Report%20master/Report_bloc.dart';
import 'package:expenseapp/Bloc/Login/Type%20master/Type_bloc.dart';
import 'package:expenseapp/drift/db.dart';
import 'package:expenseapp/views/BottomBar/bottombarNAvigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper dbHelper = DatabaseHelper();

  // Create a new company
  Company newCompany = Company(
    companyId: 1,
    companyName: "Polo",
    address: "Perinthalmanna",
    mobile: "964582277",
    userName: "keytech",
    password: "123",
  );

  await dbHelper.insertCompany(newCompany);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LedgerBloc()),
        BlocProvider(create: (context) => TypeBloc()),
        BlocProvider(create: (context) => NameBloc()),
        BlocProvider(create: (context) => ReportBloc()),
      ],
      child: MaterialApp(
        title: 'Expense App',
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        home: SplashLogo(),
        // routes: {
        //   '/register': (context) => Registerpage(),
        //   '/bottomNavigation': (context) => BottomNavigation(),
        // },
      ),
    );
  }
}
