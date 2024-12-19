// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:pdf/widgets.dart';

// class User {
//   final String name;
//   final int age;

//   const User({required this.name, required this.age});
// }

// class PdfApi {
//   static Future<File> generateTable() async {
//     final pdf = Document();

//     final headers = ['Name', 'Age'];

//     final users = [
//       User(name: 'James', age: 19),
//       User(name: 'Sarah', age: 21),
//       User(name: 'Emma', age: 28),
//     ];
//     final data = users.map((user) => [user.name, user.age]).toList();

//     pdf.addPage(Page(
//       build: (context) => Table.fromTextArray(
//         headers: headers,
//         data: data,
//       ),
//     ));

//    // return saveDocument(name: 'my_example.pdf', pdf: pdf);
//   }
// }

