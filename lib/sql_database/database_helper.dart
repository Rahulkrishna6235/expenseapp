import 'package:expenseapp/sql_database/helper.dart';
import 'package:expenseapp/sql_database/modal.dart';
import 'package:flutter/material.dart';

import 'database_helper.dart';

void main() async {
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

  // Retrieve and print all companies
  List<Company> companies = await dbHelper.getCompanies();
  for (Company company in companies) {
    print(company.companyName);
  }
}
