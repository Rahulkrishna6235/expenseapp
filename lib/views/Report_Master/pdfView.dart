import 'dart:io';
import 'package:expenseapp/utility_colors/colors.dart';
import 'package:expenseapp/views/Report_Master/pdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:share_plus/share_plus.dart';

class PDFViewerScreen extends StatelessWidget {
  final String path;

  PDFViewerScreen({required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: PDFView(
        filePath: path,
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.share,
            size: 30,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: ColorControllers().floatButton,
          onPressed: ()async {
           await Share.shareXFiles([XFile(path)], text: 'Financial Report');
          }),
    );
  }
}
