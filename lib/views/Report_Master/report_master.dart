
import 'dart:convert';
import 'dart:io';

import 'package:expenseapp/Fonts/fonts.dart';
import 'package:expenseapp/Modals/ledgermaster/ledger_modal.dart';
import 'package:expenseapp/Modals/reportmaster/report_modal.dart';
import 'package:expenseapp/utility_colors/colors.dart';
import 'package:expenseapp/views/Report_Master/pdfView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:share_plus/share_plus.dart';



class ReportMaster extends StatefulWidget {
  const ReportMaster({super.key});

  @override
  State<ReportMaster> createState() => _ReportMasterState();
}

class _ReportMasterState extends State<ReportMaster> {
  final TextEditingController _DateFromcontroller = TextEditingController();
  final TextEditingController _DateTocontroller = TextEditingController();

  final TextEditingController _NameReportcontroller = TextEditingController();
  final TextEditingController _TypeReportcontroller = TextEditingController();
ValueNotifier <DateTime?>_selecdate=ValueNotifier(DateTime.now());


  DateTime selectdate = DateTime.now();
    String? _nameId;
  String? _typeId;
  List<Ledgermodall> filteredData = [];
  List<Ledgermodall> allData = [];

  


Future<List<Ledgermodall>> getdatareport({int companyId = 1}) async {
  try {
    final response = await http.post(Uri.parse("http://keytech-003-site2.anytempurl.com/api/fund/getLedgerByCompanyId?companyId=$companyId"));
    
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print(body);  
      if (body is List) {
        return body.map((e) {
          final map = e as Map<String, dynamic>;
          return Ledgermodall(ledgerId: map['ledgerId']?? 0,
           companyId: map['companyId']?? 0, 
           date: DateTime.tryParse(map['date'] ?? '') ?? DateTime.now(),
             nameId:  map['nameId']?? 0,
            typeId:  map['typeId']?? 0,
             description:  map['description']?? '',
              credit:  map['credit']?? 0,
               debit:  map['debit']?? 0,
                names: Names.fromJson(map['names'] ?? {}),
            ledgerType: LedgerType.fromJson(map['ledgerType'] ?? {}),
               );
        }).toList();
      } else if (body is Map<String, dynamic> && body.containsKey('data')) {
        final dataList = body['data'] as List;
        return dataList.map((e) {
          final map = e as Map<String, dynamic>;
          return Ledgermodall(ledgerId: map['ledgerId']?? 0,
           companyId: map['companyId']?? 0, 
            date: DateTime.tryParse(map['date'] ?? '') ?? DateTime.now(),
            nameId:  map['nameId']?? 0,
            typeId:  map['typeId']?? 0,
             description:  map['description']?? '',
              credit:  map['credit']?? 0,
               debit:  map['debit']?? 0,
                names: Names.fromJson(map['names'] ?? {}),
            ledgerType: LedgerType.fromJson(map['ledgerType'] ?? {}),
               );
        }).toList();
      } else {
        throw Exception("Unexpected JSON format");
      }
    } else {
      throw Exception("Error fetching data: ${response.statusCode}");
    }
  } on SocketException {
    throw Exception('No Internet connection');
  }
}
  
void filterData(List<Ledgermodall> allData) {
  setState(() {
    filteredData = allData.where((expense) {
      bool nameMatch = _nameId == null || expense.names.name.toString() == _nameId;
      bool typeMatch = _typeId == null || expense.ledgerType.expenseType.toString() == _typeId;
      
      bool dateFromMatch = _DateFromcontroller.text.isEmpty ||
          expense.date!.isAfter(DateTime.parse(_DateFromcontroller.text));
      bool dateToMatch = _DateTocontroller.text.isEmpty ||
          expense.date!.isBefore(DateTime.parse(_DateTocontroller.text));
      
      return nameMatch && typeMatch && dateFromMatch && dateToMatch;
    }).toList();
  });
}

// void filterData(List<Ledgermodal> allData) {
//     setState(() {
//       filteredData = allData.where((expense) {
//         bool nameMatch = _nameId == null || expense.nameId.toString() == _nameId;
//         bool typeMatch = _typeId == null || expense.typeId.toString() == _typeId;
//         return nameMatch && typeMatch;
//       }).toList();
//     });
//   }

  Future<void> generateAndSharePDF(BuildContext context) async {
  final pdf = pw.Document();

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


  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PDFViewerScreen(path: tempFile.path),
    ),
  );
}


   @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final data = await getdatareport();
    setState(() {
      allData = data;
      filteredData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: ColorControllers().maincolor,
      appBar: AppBar(
        backgroundColor: ColorControllers().appbarcolor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text(
          "Report Master",
          style: adjust(20, Colors.black),
        ),
        toolbarHeight: 90,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FutureBuilder<List<Ledgermodall>>(
            future: getdatareport(),
            builder: (context, snapshot) {
              
                return Container(
                width: 190,
                height: 50,
                decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorControllers().searchbarcolor,
          boxShadow: const [
            BoxShadow(
                blurRadius: 2,
                spreadRadius: 2,
                color: Colors.black12,
                offset: Offset(0, 2))
          ],
                ),
                child: Padding(
          padding: const EdgeInsets.only(left: 5),
          child:Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                isDense: true,
                value: _nameId,
              hint: Text('Name'),
              items: snapshot.data != null ?
              snapshot.data!.map((e) {
                return DropdownMenuItem<String>(
                  
                  value: e.names.name.toString(),
                  child: Text(e.names.name.toString()),
                );
              }).toList() : [],
              onChanged: ( value) {
                
                //filterData(snapshot.data!);
                setState(() {
                  _nameId =value;
                  
                });
                filterData(allData);
              },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 1),
                      child: IconButton(
                      icon: Icon(Icons.clear,size: 20,),
                      onPressed: () {
                        setState(() {
                          _nameId = null;
                          _NameReportcontroller.clear();
                        });
                      },
                                      ),
                    ),
            ],
          ),
          ),
          
                );
              
            },
          ),
          
            FutureBuilder<List<Ledgermodall>>(
            future: getdatareport(),
            builder: (context, snapshot) {
               
                return Container(
                width: 188,
                height: 50,
                decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorControllers().searchbarcolor,
          boxShadow: const [
            BoxShadow(
                blurRadius: 2,
                spreadRadius: 2,
                color: Colors.black12,
                offset: Offset(0, 2))
          ],
                ),
                child: Padding(
          padding: const EdgeInsets.only(left: 5),
          child:Row(
            children: [
              DropdownButton<String>(
                value: _typeId,
              hint: Text('Type'),
              items: snapshot.data != null ?
              snapshot.data!.map((e) {
                return DropdownMenuItem<String>(
                  value: e.ledgerType.expenseType.toString(),
                  child: Text(e.ledgerType.expenseType.toString()),
                );
              }).toList() : [],
              onChanged: ( value) {
               
                //filterData(snapshot.data!);
                setState(() {
                   _typeId =value;
                  
                });
                filterData(allData);
              },
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: IconButton(
                      icon: Icon(Icons.clear,size: 20,),
                      onPressed: () {
                        setState(() {
                          _typeId = null;
                          _TypeReportcontroller.clear();
                        });
                      },
                    ),
              ),
            ],
          ),
          ),
                );
            
            },
          )
              
                    // filterReport("Select Name", _NameReportcontroller),
                    // filterReport("Select Type :", _TypeReportcontroller),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // DatefilterReport("Date From :", _DateFromcontroller),
                 GestureDetector(
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectdate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          setState(() {
                            _DateFromcontroller.text =
                                DateFormat('yyyy-MM-dd').format(picked);
                            filterData(allData);
                          });
                        }
                      },
                      child: Container(
                        width: 188,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorControllers().searchbarcolor,
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 2,
                                spreadRadius: 2,
                                color: Colors.black12,
                                offset: Offset(0, 2))
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 15),
                          child: ValueListenableBuilder<TextEditingValue>(
                            valueListenable: _DateFromcontroller,
                            builder: (context, value, child) {
                              return Text(
                                value.text.isEmpty
                                    ? 'From Date'
                                    : value.text,
                                style: adjust(16, Colors.black54),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectdate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          setState(() {
                            _DateTocontroller.text =
                                DateFormat('yyyy-MM-dd').format(picked);
                            filterData(allData);
                          });
                        }
                      },
                      child: Container(
                        width: 188,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorControllers().searchbarcolor,
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 2,
                                spreadRadius: 2,
                                color: Colors.black12,
                                offset: Offset(0, 2))
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 15),
                          child: ValueListenableBuilder<TextEditingValue>(
                            valueListenable: _DateTocontroller,
                            builder: (context, value, child) {
                              return Text(
                                value.text.isEmpty ? 'To Date' : value.text,
                                style: adjust(16, Colors.black54),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              filterbtn(),
              //  if (_nameId != null || _typeId != null)
              //         Center(child: filterbtn()),
             SizedBox(height: 40,),
              //buildDataTable(),
            ],
          ),
        ),
      ),
     
    );
  }
  

//  Widget buildDataTable() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: DataTable(
//         border: TableBorder.all(),
//         columns: const [
//           // DataColumn(label: Text('Ledger ID')),
//           // DataColumn(label: Text('Company ID')),
//                     DataColumn(label: Text('siNo')),

//           DataColumn(label: Text('Date')),
//           DataColumn(label: Text('Name ')),
//           DataColumn(label: Text('Ledger Type')),
//           DataColumn(label: Text('Description')),
//           DataColumn(label: Text('Credit')),
//           DataColumn(label: Text('Debit')),
//         ],
//         rows: List.generate(filteredData.length, (index) {
//         final e = filteredData[index];
//         return DataRow(cells: [
//           DataCell(Text((index + 1).toString())),  // SiNo
//           DataCell(Text(DateFormat('yyyy-MM-dd').format(e.date))),
//           DataCell(Text(e.names.name.toString())),
//           DataCell(Text(e.ledgerType.expenseType.toString())),
//           DataCell(Text(e.description)),
//           DataCell(Text(e.credit.toString())),
//           DataCell(Text(e.debit.toString())),
//         ]);
//       }),
//       ),
//     );
//   }

  // Widget table() {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: DataTable(
  //       columns: const [
  //         DataColumn(label: Text('Ledger ID')),
  //         DataColumn(label: Text('Company ID')),
  //         //DataColumn(label: Text('Date')),
       
  //       ],
  //       rows:[
  //          DataRow(cells: [
  //         DataCell(Text('')),
  //         DataCell(Text('jfh'))
  //       ]),
  //       ]
  //     ),
  //   );
  // }


  //\\\\\\\\\\\filter butn\\\\\\
  Widget filterbtn() {
    return Container(
      width: 210,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: ColorControllers().floatButton,
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorControllers().ElevatedButtoncolor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          onPressed: () async{
              //final allData = await getdatareport();
          //filterData(allData);
         // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PDFViewerScreen(path: tempFile.path)))
          generateAndSharePDF(context);
          },
          child: const Text(
            "Print PDF",
            style: TextStyle(fontSize: 20, color: Colors.white),
          )),
    );
  }

///\\\\\\\\\\\\\\\\\\date picker\\\\\\\\\\\\\\\\\\\\\\\\\
  
//   Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
//   DateTime? selectedDate = await showDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//     firstDate: DateTime(2000),
//     lastDate: DateTime(2100),
//   );
  
//   if (selectedDate != null) {
//     setState(() {
//       controller.text = DateFormat('yyyy-MM-dd').format(selectedDate);
//     });
//   }
// }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? _change = await showDatePicker(
        context: context,
        initialDate: selectdate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (_change != null) {
      setState(() {
        selectdate = _change;
        String formattedDate = DateFormat('yyyy-MM-dd').format(selectdate);
        _DateFromcontroller.text = formattedDate;
        _DateTocontroller.text = formattedDate;
      });
    }
  }

  List SiNo =[
    '1','2','3'
  ];
}