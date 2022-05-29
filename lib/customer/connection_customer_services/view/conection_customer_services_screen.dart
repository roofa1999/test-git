import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:roofa/Customer/connection_customer_services/controller/conection_customer_services_controller.dart';
import 'package:roofa/Firebase/chatting.dart';
import 'package:roofa/Firebase/firebase.dart';
import 'package:roofa/const/const_color.dart';
import 'package:roofa/const/picker.dart';

class ConectionCustomerServicesScreen extends StatefulWidget {
  const ConectionCustomerServicesScreen({Key? key}) : super(key: key);

  @override
  State<ConectionCustomerServicesScreen> createState() =>
      _ConectionCustomerServicesScreenState();
}

class _ConectionCustomerServicesScreenState
    extends State<ConectionCustomerServicesScreen> {
  final _key = GlobalKey<FormState>();
  final controller = Get.put(ConectionCustomerServiecsController());

  @override
  Widget build(BuildContext context) {
    Chatting.TYPE_USER = FirebaseController.typeUser; //"المستفيد";
    Chatting.EMAIL = FirebaseController.email;
    if (Chatting.TYPE_USER == "المستفيد") {
      Chatting.TYPE_USER2="خدمة العملاء";
      Chatting.CUSTOMER_EMAIL = FirebaseController.email;
      Chatting.CUSTOMER_NAME = FirebaseController.name;
    } else {
      Chatting.CUSTOMER_EMAIL = "ahmad1@st.uqu.edu.sa";
      Chatting.SERVICE_EMAIL = FirebaseController.email;
      Chatting.SERVICE_NAME = FirebaseController.name;
      if(Chatting.TYPE_USER == "خدمة العملاء") Chatting.TYPE_USER2="المستفيد";
      else if(Chatting.TYPE_USER == "مدير القسم") Chatting.TYPE_USER2="الإدارة العليا";
      else if(Chatting.TYPE_USER == "الإدارة العليا") Chatting.TYPE_USER2="مدير القسم";
      else Chatting.TYPE_USER2="";
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: Text("التواصل مع "+"${Chatting.TYPE_USER2}"),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Get.back();
              },
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.home,
                    size: 30.r,
                  ))
            ],
          ),
          body: FutureBuilder(
              future: Chatting.getIdMessages(),
              builder: (context, snapShot) {
                if (!snapShot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.r),
                            width: Get.width,
                            height: 90.h,
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                  color: colorShadowSearch.withOpacity(.23),
                                  blurRadius: 10,
                                  offset: Offset(0, 9))
                            ]),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            'images/user-circle.svg'),
                                        SizedBox(
                                          width: 12.w,
                                        ),
                                        Text(
                                          'خالد بن عفيف',
                                          style: TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                      ],
                                    )),
                                Expanded(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.call,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {},
                                  ),
                                )
                              ],
                            ),
                          ),
                          //Obx(
                          //      ()=>
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('messages')
                                  .doc("${Chatting.ID_CHAT}")
                                  .collection('chat')
                                  .snapshots(),
                              builder: (context, snapShot) {
                                if (snapShot.hasData) {
                                  var messages = snapShot.data!.docs;
                                  List<MSG> msg = [];
                                  DateTime? oldMessage = DateTime.now();
                                  List<Map<String, dynamic>> newDay = [
                                    {
                                      "index": 0,
                                      "date": DateTime.now(),
                                    }
                                  ];
                                  for (var message in messages) {
                                    print(message['text']);
                                    final text_messages = message['text'];
                                    final sender_messages =
                                        message['sender_email'];
                                    final sender_type = message['sender_type'];
                                    final id_messages = message.id;
                                    Timestamp date_messages =
                                        message['date_message'];
                                    if (sender_messages != "") {
                                      msg.add(MSG(
                                          message: text_messages,
                                          sender_email: sender_messages,
                                          sender_type: sender_type,
                                          date_message: date_messages.toDate(),
                                          id: id_messages));
                                      if (oldMessage == null ||
                                          oldMessage.isAtSameMomentAs(
                                              date_messages.toDate())) {
                                        print("${oldMessage}" + "trur");
                                      }
                                      oldMessage = date_messages.toDate();
                                    }
                                  }
                                  msg.sort((a, b) => a.date_message!
                                      .compareTo(b.date_message!));
                                  return Expanded(
                                    child: ListView.builder(
                                      itemCount: msg.length,
                                      //controller.listMessages.length,
                                      itemBuilder: (ctx, index) {
                                        return Directionality(
                                          textDirection: (
                                              msg[index]
                                                      .sender_type
                                                  == /*"المتسفيد"*/
                                                  Chatting
                                                      .TYPE_USER) //index.isEven
                                              ? TextDirection.rtl
                                              : TextDirection.ltr,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.r),
                                                    color: (msg[index]
                                                                .sender_type != /*"المتسفيد"*/
                                                            Chatting
                                                                .TYPE_USER) //index.isOdd
                                                        ? Color(0xffb3efe1)
                                                        : Color(0xffF3F3F3)),
                                                padding: EdgeInsets.only(
                                                    left: 8.r,
                                                    right: 8.r,
                                                    top: 6.r,
                                                    bottom: 6.r),
                                                margin: EdgeInsets.only(
                                                    left: (msg[index]
                                                                .sender_type != /*"المتسفيد"*/
                                                            Chatting
                                                                .TYPE_USER) /*index.isEven*/
                                                        ? 0.w
                                                        : 0,
                                                    right: (msg[index]
                                                                .sender_type == /*"المتسفيد"*/
                                                            Chatting
                                                                .TYPE_USER) /*!index.isEven*/
                                                        ? 0.w
                                                        : 0,
                                                    top: 8.r,
                                                    bottom: 8.r),
                                                //child: Text('${msg[index].message}'),
                                                child: Column(
                                                  children: [
                                                    Text("    " +
                                                        '${msg[index].message}'),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      '${
                                                          intl.DateFormat()
                                                              .add_jm().
                                                          format(msg[index].date_message!)}',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontSize: 8.0,
                                                          color: Colors.black),
                                                    )
                                                  ],
                                                ),
                                                // child: Text('${msg[index].message}'),
                                                //child: Text('${controller.listMessages[index]}'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      padding: EdgeInsets.all(34.r),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                          // ),
                          Padding(
                            padding: EdgeInsets.all(20.r),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50.r),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            colorShadowSearch.withOpacity(.56),
                                        blurRadius: 10,
                                        offset: Offset(0, 4))
                                  ]),
                              key: _key,
                              child: TextFormField(
                                controller: controller.textEditingController,
                                onChanged: (val) {
                                  if (!val.isEmpty) {
                                    controller.message.value = val;
                                  } else {}
                                },
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 5.h),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.r),
                                    ),
                                    enabledBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.attach_file_rounded),
                                      onPressed: () {
                                        Picker.pickerFile();
                                      },
                                    ),
                                    prefixIcon: IconButton(
                                      icon: Icon(Icons.send_outlined),
                                      onPressed: () {
                                        /*controller.listMessages.add(controller.message.value);
                                        controller.textEditingController.clear();
                                        controller.message.value = '';*/
                                        //*                  if(_key.currentState!.validate()){
                                        if (controller.textEditingController !=
                                            "") {
                                          Chatting.TEXT_MESSAGE = controller
                                              .textEditingController.text;
                                          if (Chatting.TEXT_MESSAGE!
                                              .trim()
                                              .isEmpty) {
                                            controller.textEditingController
                                                .clear();
                                          } else {
                                            Chatting.sendMessage();
                                            controller.textEditingController
                                                .clear();
                                          }
                                        }
                                      },
                                    ),
                                    hintText: 'اكتب هنا',
                                    hintStyle: TextStyle(color: Colors.grey
                                    )),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  );
                }
              })),
    );
  }
}
