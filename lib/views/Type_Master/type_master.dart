
import 'dart:developer';

import 'package:expenseapp/Bloc/Login/NameMaster/Name_event.dart';
import 'package:expenseapp/Bloc/Login/Type%20master/Type_bloc.dart';
import 'package:expenseapp/Bloc/Login/Type%20master/Type_event.dart';
import 'package:expenseapp/Bloc/Login/Type%20master/Type_state.dart';
import 'package:expenseapp/Fonts/fonts.dart';
import 'package:expenseapp/Modals/typemaster/type_modal.dart';
import 'package:expenseapp/globel_variables.dart';
import 'package:expenseapp/utility_colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TypeMaster extends StatefulWidget {
  const TypeMaster({
    super.key,
  });

  @override
  State<TypeMaster> createState() => _TypeMasterState();
}

class _TypeMasterState extends State<TypeMaster> {
  final TextEditingController _typecontroller = TextEditingController();

  @override
  void initState() {
    context.read<TypeBloc>().add(TypeLoad());
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
          "Ledger Type",
          style: adjust(20, Colors.black),
        ),
        toolbarHeight: 90,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
      ),
      body: BlocBuilder<TypeBloc, TypeState>(
        builder: (context, state) {
          if (state is TypeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TypeLoaded) {
            return _body(
              state.types,
            );
          }
          if (state is TypeError) {
            return const Center(
              child: Text("somthing went wrong"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );

          // Pass the current state to display the list
        },
        //   if (state is CreateTypeLoading) {
        //     return Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   } else if (state is CreateTypeLoaded) {
        //     return _Body(state.addtype);
        //   } else if (state is TypeError) {
        //     return Center(child: Text("error"));
        //   }
        //   return Center(child: CircularProgressIndicator());
        // },
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       Center(
      //         child: Padding(
      //           padding: const EdgeInsets.only(top: 20),
      //           child: Container(
      //             width: 330,
      //             height: 55,
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(20),
      //               color: ColorControllers().searchbarcolor,
      //               boxShadow: [
      //                 BoxShadow(
      //                     blurRadius: 2,
      //                     spreadRadius: 2,
      //                     color: Colors.black12,
      //                     offset: Offset(0, 2))
      //               ],
      //             ),
      //             child: TextField(
      //               decoration: InputDecoration(
      //                   border: InputBorder.none,
      //                   hintText: "Search",
      //                   prefixIcon: Icon(Icons.search)),
      //             ),
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
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

  ///\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\textfield
  Widget textfield({
    required String hint,
    required TextEditingController controller,
  }) {
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

  //\\\\\\\\\\body\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  Widget _body(List<Typemodal> userss) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        
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
                      context.read<TypeBloc>().add(SearchType(key: val));
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
            userss.isEmpty
                ? const Center(
                    child: Text("no data found"),
                  )
                : ListView.separated(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                     padding: EdgeInsets.symmetric(
                horizontal: 25,
              ),
                    itemCount: userss.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemBuilder: (context, index) {
                      var current = userss[index];
                      return Stack(
                        children: [
                          Container(
                           // margin: EdgeInsets.only(left: 15),
                            padding: EdgeInsets.only(left: 20, top: 10),
                            width: 370,
                            height: 60,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Type",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )),
                                Expanded(
                                    flex: 5,
                                    child: Text(":   ${current.expenseType}")),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 20,
                            child: InkWell(
                              onTap: () {
                                addPopup(
                                    isUpdate: true,
                                    companyId: current.companyId,
                                    index: index,
                                    
                                    type: current);
                              },
                              child: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 4,
                            right: 20,
                            child: InkWell(
                              onTap: () {
                                context.read<TypeBloc>().add(TypeDelete(
                                    id: current.expenseTypeId.toString()));
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

            // child: ListView.separated(
            //     physics: ScrollPhysics(),
            //     shrinkWrap: true,
            //     padding: EdgeInsets.symmetric(),
            //     itemCount: 4,
            //     separatorBuilder: (context, index) {
            //       return SizedBox(
            //         height: 15,
            //       );
            //     },
            //     itemBuilder: (context, index) {
            //       return Stack(
            //         children: [
            //           Container(
            //             margin: EdgeInsets.only(left: 25),
            //             padding: EdgeInsets.only(left: 20, top: 10),
            //             width: 320,
            //             height: 60,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(15),
            //                 color: Colors.white,
            //                 boxShadow: [
            //                   BoxShadow(
            //                       blurRadius: 4,
            //                       spreadRadius: 2,
            //                       color: Colors.grey.shade400,
            //                       offset: Offset(0, 2))
            //                 ]),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Expanded(
            //                     flex: 1,
            //                     child: Text(
            //                       "Type",
            //                       style: TextStyle(
            //                         fontSize: 16,
            //                         fontWeight: FontWeight.w500,
            //                       ),
            //                     )),
            //                 Expanded(flex: 5, child: Text(": ")),
            //               ],
            //             ),
            //           ),
            //           Positioned(
            //             top: 4,
            //             right: 30,
            //             child: Icon(
            //               Icons.edit,
            //               color: Colors.blue,
            //             ),
            //           ),
            //           Positioned(
            //             bottom: 4,
            //             right: 30,
            //             child: Icon(
            //               Icons.delete,
            //               color: Colors.red.shade900,
            //             ),
            //           ),
            //         ],
            //       );
            //     }),
          ],
        ),
      ),
    );
  }

  /// \\\\\\\\\\\\\\\\\\\\popup\\\\\\\\\\\\\\\\\\\\
  addPopup(
      {required bool isUpdate,
      int? index,
      Typemodal? type,
      // int expId = 1,
      int companyId = 1}) {
    TextEditingController typecrtl = isUpdate
        ? TextEditingController(text: type != null ? type.expenseType : "")
        : TextEditingController();
    TypeBloc bloc = TypeBloc();
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
                  textfield(hint: "Enter Type", controller: typecrtl),
                  SizedBox(
                    height: 20,
                  ),
                  BlocConsumer<TypeBloc, TypeState>(
                    bloc: bloc,
                    listener: (context, state) {
                      log(state.toString(),name:"state");
                      if (state is CreateTypeSuccess ) {
                        typelist.value.add(state.type);
                        Navigator.pop(context);
                        context.read<TypeBloc>().add(TypeLoad());
                      } else if (state is CreateTypeExist) {
                        Fluttertoast.cancel();
                        Fluttertoast.showToast(msg: "exist");
                      } else if (state is CreateTypeError) {
                        Fluttertoast.showToast(msg: "Failed to Create");
                      }else if(state is TypeUpadteSuccess){
                        log("@sssss");
                         Navigator.pop(context);
                        context.read<TypeBloc>().add(TypeLoad());
                      }
                      
                      // if (state is CreateTypeSuccess) {
                      //   typelist.value.add(state.type);
                      //   Navigator.of(context).pop();
                      //   context
                      //       .read<TypeBloc>()
                      //       .add(Typeload1(users: typelist.value));
                      // } else if (state is CreateTypeError) {
                      //   Fluttertoast.cancel();
                      //   Fluttertoast.showToast(msg: "Failed to create");
                      // } else if (state is CreateTypeExist) {
                      //   Fluttertoast.cancel();
                      //   Fluttertoast.showToast(msg: "exist");
                      // } else if (state is TypeUpdateError) {
                      //   Fluttertoast.cancel();
                      //   Fluttertoast.showToast(msg: "failed update");
                      // } else if (state is TypeUpdateExist) {
                      //   Fluttertoast.cancel();
                      //   Fluttertoast.showToast(msg: "exist");
                      // } else if (state is TypeUpadteSuccess) {
                      //   Fluttertoast.cancel();
                      //   Fluttertoast.showToast(msg: "success");
                      //   typelist.value[index] = state.userupdate;
                      //   Navigator.of(context).pop();

                      //   context
                      //       .read<TypeBloc>()
                      //       .add(Typeload1(users: typelist.value));
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
                            onPressed: state is CreateTypeLoading ||
                                    state is TypeUpdateLoading
                                ? null
                                : () {
                                    String validation = "";
                                    if (typecrtl.text.trim().isEmpty) {
                                      validation = "enter type";
                                    } else {
                                      if (isUpdate) {
                                        Typemodal tusers = Typemodal(
                                            expenseTypeId: type!.expenseTypeId,
                                            companyId: companyId,
                                            expenseType: typecrtl.text.trim(),
                                            error: error);
                                        bloc.add(TypeUpdate(
                                            id: index!, updateuser: tusers));
                                      } else {
                                        Typemodal tusers = Typemodal(
                                            expenseTypeId: 0,
                                            companyId: companyId,
                                            expenseType: typecrtl.text.trim(),
                                            error: error);
                                        bloc.add(TypeCreate(data: tusers));
                                      }
                                    }
                                    if (validation != "") {
                                      Fluttertoast.cancel();
                                      Fluttertoast.showToast(msg: validation);
                                    }
                                  },
                            child: state is CreateTypeLoading ||
                                    state is TypeUpdateLoading
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
}
