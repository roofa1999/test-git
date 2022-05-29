import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:get/get.dart';
import 'package:roofa/const/const_color.dart';
import 'package:roofa/const/picker.dart';
import 'package:roofa/widgets/custom_dialog.dart';
import 'package:roofa/widgets/material_text.dart';

import 'Firebase/firebase.dart';
import 'technical/home_screen/view/home_screen.dart';
final controller = Get.put(SelectTypeConectionScreenController());
class SelectTypeConectionScreen extends StatelessWidget {
  const SelectTypeConectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Center(
            child: Container(
              margin: EdgeInsets.all(15.r),
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 15.h
              ),
              width: Get.width,
              height: Get.width/2,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(15.r)
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListTile(
                      onTap: (){
                        Get.offNamed('/conection_customer_services_screen');
                      },
                      trailing: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                      title: Text('التواصل مع خدمة العملاء',style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp
                      ),),
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  Expanded(child: ListTile(
                    onTap: (){
                      Get.to(TypeProblemSreen());
                    },
                    trailing: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                    title: Text('اقتراح  / شكوى',style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp
                    ),),
                  )),
                ],
              ),
            ),
          ),
        ));
  }
}
class TypeProblemSreen extends StatefulWidget {
  const TypeProblemSreen({Key? key}) : super(key: key);

  @override
  State<TypeProblemSreen> createState() => _TypeProblemSreenState();
}

class _TypeProblemSreenState extends State<TypeProblemSreen> {
  String problemType = 'اقتراح';
  var index = 0;
  Color buttonActive = mainColor;
  Color textButtonActive = Colors.white;
  void onClickButton(val){
    index = val;
    setState(() {

    });
    print(index);
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("اقتراحات وشكاوي"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: (){
              Get.back();
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.off(()=>HomeScreenT());
                },
                icon: Icon(
                  Icons.home,
                  size: 30.r,
                ))
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(
                vertical: Get.width * 0.1
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.all(5.r),
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      width: 235.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50.r),
                          boxShadow: [
                            BoxShadow(
                                color: colorShadowSearch.withOpacity(.23),
                                blurRadius: 10,
                                offset: Offset(0, 4))
                          ]),
                      child: Row(
                        children: [
                          Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  onClickButton(0);
                                  problemType = 'اقتراح';
                                  controller.type= 'Suggestion';
                                  controller.problemType = 'اقتراح';
                                },
                                child: AnimatedContainer(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: index == 0
                                          ? mainColor
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(50.r)),
                                  child: Text(
                                    'اقتراح',
                                    style: TextStyle(
                                      color: index == 0
                                          ? textButtonActive
                                          : mainColor,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 800),
                                ),
                              )),
                          Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  onClickButton(1);
                                  problemType = 'شكوى';
                                  controller.type= 'complaint';
                                  controller.problemType = 'شكوى';
                                },
                                child: AnimatedContainer(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: index == 1
                                          ? mainColor
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(50.r)),
                                  child: Text(
                                    'شكوى',
                                    style: TextStyle(
                                      color: index == 1
                                          ? textButtonActive
                                          : mainColor,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 800),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        Container(
        padding: EdgeInsets.all(15.r),
        width: Get.width,
        height: Get.height / 1.5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(
              15.r),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                    color: Color(
                        0xffF3F3F3),
                    borderRadius: BorderRadius
                        .only(
                        bottomRight: Radius
                            .circular(
                            15.r),
                        bottomLeft: Radius
                            .circular(
                            15.r)),
                    boxShadow: [
                      BoxShadow(
                          color: colorShadowSearch
                              .withOpacity(
                              .65),
                          blurRadius:
                          10,
                          offset:
                          Offset(0,
                              4)),
                    ]),
                child: Column(
                  children: [
                    Expanded(
                        child: Card(
                          shadowColor: Colors
                              .transparent,
                          margin: EdgeInsets
                              .zero,
                          elevation: 0.0,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceAround,
                            children: [
                              IconButton(
                                  onPressed:
                                      () {
                                        setState(() {
                                          controller.description.clear();
                                          print(controller.description);
                                        });
                                      },
                                  icon: Icon(
                                      Icons
                                          .delete_forever_outlined)),
                              IconButton(
                                  onPressed:
                                      () {
                                    Picker.pickerFile();
                                      },
                                  icon: Icon(
                                      Icons
                                          .attach_file_outlined)),
                              IconButton(
                                  onPressed:
                                      () async {
                                      await Picker.showChoiceDialog(context);
                                      print("image"+Picker.image!.path);
                                    /*  await Picker.showChoiceDialog(context);
                                      print("image"+Picker.image!.path);
                                      String fileName =(Picker.image!.path);
                                      File imageFile=File(Picker.image!.path);
                                      await FirebaseStorage.instance.ref().child('uploads/$fileName').putFile(imageFile).then((p0) => print(p0.storage),);
                                      print("done");*/
                                      },
                                  icon: Icon(
                                      Icons
                                          .camera_alt_outlined)),
                            ],
                          ),
                        )),
                    Expanded(
                      flex: 4,
                      child: Card(
                        shadowColor: Colors
                            .transparent,
                        elevation: 0.0,
                        color: Colors
                            .transparent,
                        child: Padding(
                          padding:
                          EdgeInsets
                              .all(10
                              .r),
                          child:
                          Form(
                            key: controller.keyForm,
                            child: TextFormField(
                              validator: (val){
                                return val!.trim().isEmpty
                                    ?"الرجاء كتابة اقتراح أو شكوى.."
                                    :null;
                              },
                             controller: controller.description,
                              maxLines: 3,
                              textDirection:
                              TextDirection
                                  .rtl,
                              decoration:
                              InputDecoration(
                                border: InputBorder
                                    .none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.h,),
            Expanded(
              child:
              GestureDetector(
                onTap: () async{
                  if(

                  await controller.send()
                  &&
                  controller.keyForm.currentState!.validate()
                  ){
                    Get.back();
                    showCustomDialog(
                        text: 'تم إرسال ال$problemType'
                    );
                    Timer(Duration(
                        seconds: 1),
                            (){
                          Get.back();
                        });
                  }else {
                    showCustomDialog(
                        text: 'فشل إرسال ال$problemType'
                    );
                    Timer(Duration(
                        seconds: 1),
                            (){
                          Get.back();
                        });
                  }

                },
                child:
                Container(
                  alignment:
                  Alignment
                      .center,
                  width: 206.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                      color:
                      mainColor,
                      borderRadius:
                      BorderRadius
                          .circular(
                          50.r)),
                  child:
                  MaterialText(
                    text:
                    'ارسال',
                    fontWeight:
                    FontWeight
                        .bold,
                    fontSize:
                    15.sp,
                    color: Colors
                        .white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
          ],
        ),

      ),
    );
  }
}

class ProblemList {
  String? name;
  int? index;
  ProblemList({this.name, this.index});
}
class SelectTypeConectionScreenController extends GetxController{
  String? type="Suggestion";
  final  description = TextEditingController();
  String? problemType="اقتراح";
  String? image="";
  String? file="";
  bool check=false;
  final keyForm = GlobalKey<FormState>();
  Future<bool> send() async {
    if(FirebaseController.email.isNotEmpty||description.text.trim().isNotEmpty){
      try{
        String generateRandomString= FirebaseController.generateRandomString2(4,3);
        await FirebaseFirestore.instance.collection(type!).add({
          'email':FirebaseController.email,
          'الاسم':FirebaseController.name,
          'نوع المشكلة':problemType,
          'القسم':FirebaseController.typeUser,
          'الوصف':description.text,
          'رقم البلاغ': generateRandomString,
          "notification":false,
          'Time':DateTime.now(),
        }).then((value) =>
        {
          print("confirm : [ email : "+FirebaseController.email+","+
              'الاسم : '+FirebaseController.name+","+
              'نوع المشكلة : '+problemType!+","+
              'الوصف : '+description.text+","+
              'رقم البلاغ : '+generateRandomString+","+
              'Time :'+"${DateTime.now()}"+" ]"),
        });
        check=true;
        return true;
      }catch(e){
        print(e);
        check=false;
        return false;
      }
    }else{
      print("فشل الارسال");
      check=false;
      return false;
    }

  }
}


