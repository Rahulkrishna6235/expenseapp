import 'dart:ffi';

import 'package:expenseapp/Bloc/Login/NameMaster/Name_bolc.dart';
import 'package:expenseapp/Bloc/Login/NameMaster/Name_event.dart';
import 'package:expenseapp/Bloc/Login/NameMaster/Name_state.dart';
import 'package:expenseapp/Bloc/Login/Type%20master/Type_bloc.dart';
import 'package:expenseapp/Fonts/fonts.dart';
import 'package:expenseapp/Modals/namemaster/name_modal.dart';
import 'package:expenseapp/globel_variables.dart';
import 'package:expenseapp/utility_colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NameMaster extends StatefulWidget {
  const NameMaster({super.key});

  @override
  State<NameMaster> createState() => _NameMasterState();
}

class _NameMasterState extends State<NameMaster> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _mobilecontroller = TextEditingController();
  final TextEditingController _placecontroller = TextEditingController();
   

  @override
  void initState() {
    context.read<NameBloc>().add(NameLoad1());
    super.initState();
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
            icon: Icon(Icons.arrow_back)),
        title: Text(
          "Name List",
          style: adjust(20, Colors.black),
        ),
        toolbarHeight: 90,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
      ),
      body: BlocBuilder<NameBloc, NameMasterState>(
        builder: (context, state) {
          if (state is NameLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is NameLoaded) {
            return _body(state.names);
          }
          if (state is NameError) {
            return const Center(
              child: Text("somthing wrong"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        // listener: (context, state) {
        //   if (state is CreateNameSuccess) {
        //     ScaffoldMessenger.of(context)
        //         .showSnackBar(SnackBar(content: Text("success")));
        //   } else if (state is CreateNameerror) {
        //     ScaffoldMessenger.of(context)
        //         .showSnackBar(SnackBar(content: Text("failed")));
        //   }

        // },
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
            addPopup(isUpdate: false);
          }),
    );
  }



 Widget _body(List<Namemodal> nameuser){
  return SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding:  EdgeInsets.only(top: 8),
                        child: Container(
                          width: 370,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ColorControllers().searchbarcolor,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                  color: Colors.black12,
                                  offset: Offset(0, 2))
                            ],
                          ),
                          child: TextField(
                             onChanged: (val) {
                      context.read<NameBloc>().add(SearchCusName(keyword: val));
                    },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search",
                                prefixIcon: Icon(Icons.search)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    nameuser.isEmpty
                        ? Center(
                            child: Text("empty data"),
                          )
                        : ListView.separated(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: 25,
              ),
              itemCount: nameuser.length,
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10,
                );
              },
              itemBuilder: (context, index) {
                var current = nameuser[index];
                return Stack(
                  children: [
                    Container(
                    ///margin: EdgeInsets.only(left: 15),

                      padding: EdgeInsets.only(left: 20, top: 10),
                      width: 370,
                      height: 80,
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
                              _listcontents("Name"),
                              Expanded(
                                  flex: 6, child: Text(":   ${current.name} ")),
                            ],
                          ),
                          Row(
                            children: [
                              _listcontents("Mob. No"),
                              Expanded(
                                  flex: 6, child: Text(":   ${current.mobile} ")),
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     _listcontents("Place"),
                          //     Expanded(
                          //         flex: 5, child: Text(": ${current.name}")),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          addPopup(
                              index: index,
                              nametype: current,
                               isUpdate: true,
                              companyId: current.companyId
                              );
                        },
                        child: Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          context
                              .read<NameBloc>()
                              .add(DeleteName(idd: current.nameId.toString()));
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
                    // BlocBuilder<NameBloc,NameMasterState>(
                    //   builder: (context, state) {
                    //     if (state is CreateNameLoading) {
                    //       return const Center(
                    //         child: CircularProgressIndicator(),
                    //       );
                    //     } else if (state is CreateNameerror) {
                    //       return Center(
                    //         child: Text(state.errror),
                    //       );
                    //     } else if (state is CreateNameLoaded) {
                    //       return _NamedataList();
                    //     }
                    //     return const SizedBox();
                    //   },
                    // ),
                  ],
                ),
              ),
            );
 }

  ///\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\textfield
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

  /// \\\\\\\\\\\\\\\\\\\\popup\\\\\\\\\\\\\\\\\\\\
  addPopup({
    required bool isUpdate,
    int? index,
    Namemodal? nametype,
    // String mobile = '',
    // String name = '',
    // String place = '',
    //int nameId= 1,
    int companyId=1
  }) {
    TextEditingController namecrtl =
        isUpdate ? TextEditingController(text: nametype != null ? nametype.name: '') : TextEditingController();
    TextEditingController mobilecrtl =
        isUpdate ? TextEditingController(text: nametype != null ? nametype.mobile: '') : TextEditingController();
    // TextEditingController placecrtl =
    //     isUpdate ? TextEditingController(text: name) : TextEditingController();
         NameBloc bloc = NameBloc();

    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
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
                  textfield("Enter Name", namecrtl),
                  SizedBox(
                    height: 15,
                  ),
                  textfield("Enter Mobile", mobilecrtl),
                  SizedBox(
                    height: 15,
                  ),
                  // textfield("Enter Place", placecrtl),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  BlocConsumer<NameBloc, NameMasterState>(
                    bloc: bloc,
                    listener: (context, state) {
                      if (state is CreateNameSuccess) {
                        namelist.value.add(state.username);
                        Navigator.of(context).pop();
                        context
                            .read<NameBloc>()
                            .add(NameLoad1());
                      } 
                      else if (state is CreateNameExist) {
                        Fluttertoast.cancel();
                        Fluttertoast.showToast(msg: "exist");
                      } else if (state is CreateNameerror) {
                        Fluttertoast.showToast(msg: "Failed");
                      } else if(state is NameUpdateSucess){
                         Navigator.of(context).pop();
                        context
                            .read<NameBloc>()
                            .add(NameLoad1());
                      }
                      // } else if (state is NameUpdateError) {
                      //   Fluttertoast.cancel();
                      //   Fluttertoast.showToast(msg: "failed update");
                      // } else if (state is NameUpdateExist) {
                      //   Fluttertoast.cancel();
                      //   Fluttertoast.showToast(msg: "exist");
                      // } else if (state is NameUpdateSucess) {
                      //   Fluttertoast.cancel();
                      //   Fluttertoast.showToast(msg: "success");
                      //   namelist.value[index] = state.nameUpdate;
                      //   Navigator.of(context).pop();

                      //   context
                      //       .read<NameBloc>()
                      //       .add(NameCusLoad(nameusers: namelist.value));
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
                            onPressed: state is CreateNameLoading ||
                                    state is NameUpdateLoading
                                ? null
                                : () {
                                    String validation = "";
                                    if (namecrtl.text.trim().isEmpty) {
                                      validation = "enter name";
                                    } else if (mobilecrtl.text.trim().isEmpty) {
                                      validation = "enter mobile number";
                                    }
                                    //  else if (placecrtl.text.trim().isEmpty) {
                                    //   validation = "enter place";
                                    // }
                                     else{
                                      if (isUpdate) {
                                      Namemodal namemodal = Namemodal(
                                          nameId: nametype!.nameId,
                                          companyId: companyId,
                                          name: namecrtl.text.trim(),
                                          mobile: mobilecrtl.text.trim(),
                                          error: error);
                                      bloc.add(UpdateName(index: index!, updatename: namemodal));
                                    } else {
                                      Namemodal namemodal = Namemodal(
                                          nameId: 0,
                                          companyId: companyId,
                                          name: namecrtl.text.trim(),
                                          mobile: mobilecrtl.text.trim(),
                                          error: error);
                                      bloc.add(CreateName(createname: namemodal));
                                    }
                                    } 
                                    
                                    if(validation != ""){
                                     
                                      Fluttertoast.cancel();
                                      Fluttertoast.showToast(msg: validation);
                                    
                                    }
                                  }
                                  ,
                            child:
                            state is CreateNameLoading || state is NameUpdateLoading?
                            const CupertinoActivityIndicator(color: Colors.black,)
                             : Text(
                              isUpdate ? "Update" : "Submit",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
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
