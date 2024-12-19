 import 'dart:io';

import 'package:expenseapp/Modals/reportmaster/report_modal.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart' as path;
import 'package:pdf/widgets.dart' as pw;

Future<void> GenerateAndSharePDF() async {
  final pdf = pw.Document();
List<Ledgermodall> filteredData = [];
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Financial Report',
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 20),
           
            pw.Text(
              'Filter Data',
              style: pw.TextStyle(
                fontSize: 18,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
             pw.SizedBox(height: 5),
            pw.Table.fromTextArray(
              border: pw.TableBorder.all(),
              headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
              headerHeight: 30,
              cellHeight: 30,
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerLeft,
                2: pw.Alignment.centerLeft,
                3: pw.Alignment.centerLeft,
                4: pw.Alignment.centerLeft,
                5: pw.Alignment.centerLeft,
                6: pw.Alignment.centerLeft,
              },
              headers: <String>['SI NO', 'DATE', 'NAME', 'LEDGER TYPE', 'DESCRIPTION', 'CREDIT', 'DEBIT'],
              data: List.generate(filteredData.length, (index) {
                final e = filteredData[index];
                return [
                  (index + 1).toString(),  // SiNo
                  DateFormat('yyyy-MM-dd').format(e.date),
                  e.names.name.toString(),
                  e.ledgerType.expenseType.toString(),
                  e.description,
                  e.credit.toString(),
                  e.debit.toString(),
                ];
              }),
            ),
          ],
        );
      },
    ),
  );

  final tempDir = await getTemporaryDirectory();
  final tempPath = tempDir.path;
  final tempFile = File('$tempPath/report.pdf');
  await tempFile.writeAsBytes(await pdf.save());

  await Share.shareXFiles([XFile('$tempPath/report.pdf')], text: 'Financial Report');


  
}
