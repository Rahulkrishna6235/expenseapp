import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:expenseapp/Bloc/Login/Ledger%20master/ledger_bloc.dart';
import 'package:expenseapp/Bloc/Login/Ledger%20master/ledger_event.dart';
import 'package:expenseapp/Bloc/Login/Ledger%20master/ledger_state.dart';
import 'package:expenseapp/Fonts/fonts.dart';
import 'package:expenseapp/Modals/ledgermaster/ledger_modal.dart';
import 'package:expenseapp/Modals/namemaster/name_modal.dart';
import 'package:expenseapp/Modals/typemaster/type_modal.dart';
import 'package:expenseapp/globel_variables.dart';
import 'package:expenseapp/utility_colors/colors.dart';
import 'package:expenseapp/views/Ledger_Master/date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


class LedgerMaster extends StatefulWidget {
  const LedgerMaster({super.key});

  @override
  State<LedgerMaster> createState() => _LedgerMasterState();
}

class _LedgerMasterState extends State<LedgerMaster> {
  
  // final TextEditingController _namecontroller = TextEditingController();
  // final TextEditingController _datecontroller = TextEditingController();
  // final TextEditingController _typecontroller = TextEditingController();
  // final TextEditingController _adresscontroller = TextEditingController();
  // final TextEditingController _debitcontroller = TextEditingController();
  // final TextEditingController _creditcontroller = TextEditingController();
  final TextEditingController _searchcontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
    final TextEditingController _typecontroller = TextEditingController();

    String? _nmaeid;
    String? _typeid;
      List<Namemodal>users=[];
    Future<List<Namemodal>> getdata({int companyId = 1}) async {
  try {
    final response = await http.post(Uri.parse("http://keytech-003-site2.anytempurl.com/api/fund/getNamesByCompanyId?companyId=$companyId"));
    
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print(body);  
      if (body is List) {
        return body.map((e) {
          final map = e as Map<String, dynamic>;
          return Namemodal(
            nameId: map['nameId']??0,
            companyId: map['companyId'?? 0],
            name: map['name']??'',
            mobile: map['mobile']??'',
            error: map['error']??'',
          );
        }).toList();
      } else if (body is Map<String, dynamic> && body.containsKey('data')) {
        final dataList = body['data'] as List;
        return dataList.map((e) {
          final map = e as Map<String, dynamic>;
          return Namemodal(
            nameId: map['nameId']??0,
            companyId: map['companyId']??0,
            name: map['name']??'',
            mobile: map['mobile']??'',
            error: map['error']??'',
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

 Future<List<Typemodal>> getTypedata({int companyId = 1}) async {
  try {
    final response = await http.post(Uri.parse("http://keytech-003-site2.anytempurl.com/api/fund/getLedgerTypeByCompanyId?companyId=$companyId"));
    
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print(body);  
      if (body is List) {
        return body.map((e) {
          final map = e as Map<String, dynamic>;
          return Typemodal(expenseTypeId: map['expenseTypeId']??0, 
          companyId: map['companyId']??0, 
          expenseType:  map['expenseType']??'',
           error:  map['error']??'');
        }).toList();
      } else if (body is Map<String, dynamic> && body.containsKey('data')) {
        final dataList = body['data'] as List;
        return dataList.map((e) {
          final map = e as Map<String, dynamic>;
          return Typemodal(expenseTypeId: map['expenseTypeId']??0, 
          companyId: map['companyId']??0, 
          expenseType:  map['expenseType']??'',
           error:  map['error']??'');
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

      
@override
  void initState() {
    context.read<LedgerBloc>().add(LedgerLoad1());
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorControllers().maincolor,
      appBar: AppBar(
        backgroundColor: ColorControllers().appbarcolor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: Text(
          "Ledger ",
          style: adjust(20, Colors.black),
        ),
        toolbarHeight: 90,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
      ),
      body: BlocBuilder<LedgerBloc, LedgerState>(
        builder: (context, state) {
          if (state is LedgerLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
          if (state is LedgerLoaded) {
            return _body(state.users);
          }
          if (state is LedgerError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 30,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: ColorControllers().floatButton,
          onPressed: () {
            addPopup( isUpdate: false);
          }),
    );
  }

  Widget _drop(TextEditingController controller){
    return FutureBuilder<List<Namemodal>>(
  future: getdata(),
  builder: (context, snapshot) {
    
      return Container(
      width: 290,
      height: 58,
      decoration: BoxDecoration(
        color: Color(0xFFF6EAF6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
      width: 1,
      color: Color(0xFFC272BA),
    ),
      ),
      child:Padding(
        padding: const EdgeInsets.only(left: 10),
        child:  DropdownButton<String>(
          isExpanded: true,
          value: _nmaeid,
        hint: Text('Enter Name'),
        items: snapshot.data != null ?
        snapshot.data!.map((e) {
          return DropdownMenuItem<String>(
            
            value: e.name.toString(),
            child: Text(e.name.toString()),
          );
        }).toList() : [],
        onChanged: (String? value) {
            
              
          setState(() {
                _nmaeid =value; 
          });
           _namecontroller.text = value ?? '';
        },
      ),
      ),
    );
    
  },
);

  }

  Widget _dropType(TextEditingController controller){
    return FutureBuilder<List<Typemodal>>(
  future: getTypedata(),
  builder: (context, snapshot) {
    
      return     Container(
      width: 290,
      height: 58,
      decoration: BoxDecoration(
        color: Color(0xFFF6EAF6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
      width: 1,
      color: Color(0xFFC272BA),
    ),
      ),
      child:Padding(
        padding: const EdgeInsets.only(left: 10),
        child:  DropdownButton<String>(
          isExpanded: true,
          
          value: _typeid,
        hint: Text('Enter Type'),
        items: snapshot.data != null ?
        snapshot.data!.map((e) {
          return DropdownMenuItem<String>(
            value: e.expenseType.toString(),
            child: Text(e.expenseType.toString()),
          );
        }).toList() : [],
        onChanged: (String? value) {
             _typeid =value;
              _typecontroller.text = value??'';
          setState(() {
             
              
          });
        },
      ),
      ),
    );
    
  },
);

  }
  Widget _body(List<Ledgermodal>usersdb){
    return SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        width: 370,
                        height: 55,
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
                        child: TextField(
                          controller: _searchcontroller,
                          onChanged: (query) {
                            context
                                .read<LedgerBloc>()
                                .add(DBLedgerSearch(keyword: query));
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search",
                              prefixIcon: InkWell(
                                  onTap: () {
                                    _searchcontroller.text = "";
                                    context
                                        .read<LedgerBloc>()
                                        .add(DBLedgerSearch(keyword: ""));
                                  },
                                  child: Icon(Icons.search))),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  usersdb.isEmpty ?
                  Center(child: Text("empty data"))
                  :
                 ListView.separated(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  itemCount: usersdb.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemBuilder: (context, index) {
                    var current = usersdb[index];
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0,right: 2 ),
                          child: Container(
                            margin: EdgeInsets.only(left: 1),
                            padding: EdgeInsets.only(left: 20, top: 10),
                            width: 370,
                            height: 175,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                      color: Colors.grey.shade400,
                                      offset: Offset(0, 2))
                                ]),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    _listcontents("Date"),
                                    Expanded(flex: 5, child: Text(":   ${current.date?.day} - ${current.date?.month} - ${current.date?.year} ")),
                                  ],
                                ),
                                Row(
                                  children: [
                                    _listcontents("type"),
                                    Expanded(flex: 5, child: Text(":   ${current.ledgerType.expenseType} ")),
                                  ],
                                ),
                                Row(
                                  children: [
                                    _listcontents("Name"),
                                    Expanded(flex: 5, child: Text(":   ${current.names.name}")),
                                  ],
                                ),
                                Row(
                                  children: [
                                    _listcontents("Descri"),
                                    Expanded(flex: 5, child: Text(":   ${current.description}")),
                                  ],
                                ),
                                Row(
                                  children: [
                                    _listcontents("Debit"),
                                    Expanded(flex: 5, child: Text(":   ${current.debit}")),
                                  ],
                                ),
                                Row(
                                  children: [
                                    _listcontents("Credit"),
                                    Expanded(flex: 5, child: Text(":   ${current.credit}")),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 25,
                          right: 15,
                          child: InkWell(
                            onTap: () {
                              addPopup(
                                
                                  index: index,
                                  ledgertype: current,
                                  companyId: current.companyId,
                                  isUpdate: true
                                  );
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 25,
                          right: 15,
                          child: InkWell(
                            onTap: () {
                              context.read<LedgerBloc>().add(LedgerDelete(id: current.ledgerId.toString()));
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.red.shade900,
                            ),
                          ),
                        ),
                      ],
                    );
                  })
                ],
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
        color: ColorControllers().popuptfieldbtn,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller,
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

  addPopup({
    
    required bool isUpdate,

    int? index,
    Ledgermodal? ledgertype,
    
    DateTime? date,
    int companyId=1
    
    // String name = '',
    // String type = '',
    // String adress = '',
    // String credit = '',
    // String debit = '',
    // String description = '',
  }) {
    final TextEditingController dateCtrl = TextEditingController(
        text: date != null ? "${date.day}-${date.month}-${date.year}" : "");
    TextEditingController namecrtl =
        isUpdate ? TextEditingController(text:ledgertype != null ? ledgertype.typeId.toString() : '') : TextEditingController();
    TextEditingController typecrtl =
        isUpdate ? TextEditingController(text: ledgertype!= null ? ledgertype.nameId.toString():  '') : TextEditingController();
    TextEditingController namescrtl =
        isUpdate ? TextEditingController(text:ledgertype != null ? ledgertype.names.name.toString() : '') : TextEditingController();
    TextEditingController ledgertypecrtl =
        isUpdate ? TextEditingController(text: ledgertype!= null ? ledgertype.ledgerType.expenseType:  '') : TextEditingController();
    TextEditingController descricrtl =
        isUpdate ? TextEditingController(text: ledgertype!= null ? ledgertype.description :'') : TextEditingController();
    TextEditingController debitcrtl =
        isUpdate ? TextEditingController(text: ledgertype!= null ? ledgertype.debit.toString() :'') : TextEditingController();
    TextEditingController creditcrtl =
        isUpdate ? TextEditingController(text: ledgertype!= null ? ledgertype.credit.toString() :'') : TextEditingController();
    ValueNotifier<DateTime> pickedDate =
        ValueNotifier(date != null ? date : DateTime.now());
     LedgerBloc bloc= LedgerBloc();
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isUpdate ? "Edit Details" : "Enter Details",
                    style: getFonts(20, Colors.black),
                  ),
                  IconButton(onPressed: () {
                    Navigator.pop(context);
                  }, icon: Icon(Icons.close))
                ],
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  ValueListenableBuilder(valueListenable: pickedDate,
                   builder: (context,value,child){
                    return Container(
      width: 290,
      height: 58,
      decoration: BoxDecoration(
        color: ColorControllers().popuptfieldbtn,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
         onTap: () async {
                    pickedDate.value = (await SelectDate().selectDate(
                    context, pickedDate.value, dateCtrl))!;
                    dateCtrl.text = DateFormat.yMd().format(pickedDate.value);
                        },
        controller: dateCtrl,
        readOnly: true,
        decoration: InputDecoration(
          //isDense: true,
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
          hintText: "select Date",
        ),
        autofocus: true,
      ),
    );
                   }),
                 // textfield("Enter Date", dateCtrl),
                  const SizedBox(
                    height: 15,
                  ),
                 
                _drop(namescrtl),
                 const SizedBox(
                    height: 15,
                  ),
                 _dropType(ledgertypecrtl),
                  //textfield("Enter Name", namecrtl),
                 
                  const SizedBox(
                    height: 15,
                  ),
                  //textfield("Enter Type", typecrtl),
                
                  const SizedBox(
                    height: 15,
                  ),
                  textfield("Enter Address", descricrtl),
                  const SizedBox(
                    height: 15,
                  ),
                  textfield("Enter Debit", debitcrtl),
                  const SizedBox(
                    height: 15,
                  ),
                  textfield("Enter Credit", creditcrtl),
                  const SizedBox(
                    height: 15,
                  ),
                  BlocConsumer<LedgerBloc,LedgerState>(
                    bloc: bloc,
                    listener: (context, state) {
                      log(state.toString(),name:"state");
                      if (state is CreateLedgerSucess) {
                        ledgerlist.value.add(state.user);
                        Navigator.pop(context);
                        context
                            .read<LedgerBloc>()
                            .add(LedgerLoad1());
                      } 
                       
                      else if (state is CreateLedgerExist) {
                        Fluttertoast.cancel();
                        Fluttertoast.showToast(msg: "Already exist");
                      } else if (state is CreateLedgerError) {
                        Fluttertoast.showToast(msg: "Failed");
                      }else if(state is UpdateLedgerSuccess){
                        Navigator.pop(context);
                        context
                            .read<LedgerBloc>()
                            .add(LedgerLoad1());
                      }
                      // else if (state is UpdateLedgerError) {
                      //   Fluttertoast.cancel();
                      //   Fluttertoast.showToast(msg: "Failed");
                      // } else if (state is UpdateLedgerExist) {
                      //   Fluttertoast.cancel();
                      //   Fluttertoast.showToast(msg: "Already exist");
                      // } else if (state is UpdateLedgerSuccess) {
                      //   Fluttertoast.cancel();
                      //   Fluttertoast.showToast(msg: "update success");
                      //   ledgerlist.value[index] = state.user;
                      //   Navigator.of(context).pop();
                      //   context
                      //       .read<LedgerBloc>()
                      //       .add(LedgerLoade(users: ledgerlist.value));
                      // }
                    },
                    builder: (context, state) {
                      return Container(
                        width: 165,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: ColorControllers().floatButton,
                        ),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  ColorControllers().ElevatedButtoncolor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            onPressed: state is CreateLedgerloading ||
                                    state is UpdateLedgerLoading
                                ? null
                                : () {
                                    String validationerror = "";
                                    if (_namecontroller.text.trim().isEmpty) {
                                      validationerror = "Enter name";
                                    }else if(_typecontroller.text.trim().isEmpty){
                                      validationerror = 'Enter type';
                                    }
                                     else if (descricrtl.text.trim().isEmpty) {
                                      validationerror = "Enter adress";
                                    } else if (debitcrtl.text.trim().isEmpty) {
                                      validationerror = "Enter debit";
                                    } else if (creditcrtl.text.trim().isEmpty) {
                                      validationerror = "Enter credit";
                                    } else if (isUpdate) {
                                      Ledgermodal users = Ledgermodal(
                                          ledgerId: ledgertype!.ledgerId,
                                          companyId: companyId,
                                          date: pickedDate.value,
                                          nameId: int.parse(_namecontroller.text.trim()),
                                          typeId:int.parse(_typecontroller.text.trim()),
                                         names: LedgerNames( 
                                                nameId: namescrtl.text.trim() != '' ? int.parse(namescrtl.text.trim()) : 0,
                                                companyId: companyId, 
                                                name: namescrtl.text.trim(),
                                                 mobile: '', 
                                                 error: null, 
                                     ),
                                      ledgerType: LedgerType1(expenseTypeId: int.parse(typecrtl.text.trim()),
                                       companyId: companyId,
                                        expenseType: ledgertypecrtl.text.trim(), 
                                        error: error),
                                          description: descricrtl.text.trim(),
                                          credit: double.parse(creditcrtl.text.trim()),
                                          debit: double.parse(debitcrtl.text.trim()));
                                     bloc.add(LedgerUpadte(updateledger: users, index: index!));
                                    } else {
                                      Ledgermodal users = Ledgermodal(
                                          ledgerId: 0,
                                          companyId: companyId,
                                          date: pickedDate.value,
                                          nameId: int.parse(_namecontroller.text.trim()!= null ? _namecontroller.text.trim() : '0'),
                                          typeId:int.parse(_typecontroller.text.trim()),
                                          description: descricrtl.text.trim(),
                                          names: LedgerNames(
                                                nameId: namescrtl.text.trim() != '' ? int.parse(namescrtl.text.trim()) : 0,
                                                companyId: companyId, 
                                                name: namescrtl.text.trim(),
                                                 mobile: '', 
                                                 error: null, 
                                     ),
                                      ledgerType: LedgerType1(expenseTypeId: int.parse(typecrtl.text.trim()),
                                       companyId: companyId,
                                        expenseType: ledgertypecrtl.text.trim(), 
                                        error: error),
                                          credit: double.parse(creditcrtl.text.trim()),
                                          debit: double.parse(debitcrtl.text.trim()));
                                      
                                          bloc.add(LedgerCreate(createledger: users));
                                    }
                                    if (validationerror != "") {
                                      Fluttertoast.cancel();
                                      Fluttertoast.showToast(
                                          msg: validationerror);
                                    }
                                  },
                            child: state is CreateLedgerloading ||
                                    state is UpdateLedgerLoading
                                ? const CupertinoActivityIndicator(
                                    color: Colors.black,
                                  )
                                : Text(
                                    isUpdate ? "Update" : "Submit",
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  )),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _listcontents(String listtext) {
    return Expanded(
        flex: 2,
        child: Text(
          listtext,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ));
  }

  
    
}
