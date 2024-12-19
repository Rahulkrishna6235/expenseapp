import 'package:flutter/material.dart';

class SelectDate {
  // /\/\/\/\/\/\\\/\//\ select date
  Future<DateTime?> selectDate(BuildContext context, DateTime selectedDate,
      TextEditingController? dateCtrl) async {
    // DateTime? selectedDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      // context.read<QuotationController>().updateSelectedDate(picked);
      if (dateCtrl != null) {
        dateCtrl.text = "${picked.day}-${picked.month}-${picked.year}";
      }
      return picked;
    } else {
      return selectedDate;
    }
  }
}