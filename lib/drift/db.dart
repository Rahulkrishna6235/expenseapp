import 'package:drift/drift.dart';
import 'package:expenseapp/Drift/drift.dart';

class DB{
  final Database database = Database();
   Future<void> _insertInitialData() async {
    final companyData = CompanyDataCompanion(
      companyName: Value("Polo"),
      address: Value("Perinthalmanna"),
      mobile: Value("964582277"),
      userName: Value("keytech"),
      password: Value("123"),
      error: Value(""),
    );

    await database.addCompanyData(companyData);
  }
  
}


 
