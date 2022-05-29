import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
//import 'package:roofa/customer/Firebase/firebase.dart';
import 'package:roofa/insert_phone_number/view/inser_phone_number_screen.dart';
import 'package:roofa/preview_screen/view/preview_screen.dart';
import 'package:roofa/setting/view/setting_screen.dart';
import 'package:roofa/sign_in/view/sign_in_screen.dart';
import 'package:roofa/widgets/custom_dialog.dart';

import '../../department_manager/home_page/view/home_page.dart';
import '../userprofile_controller/userprofile_controller.dart';

class UserProfileScreen extends StatelessWidget {
  final controller = Get.put(UserProfileController());
  UserProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("الملف الشخصي"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.off(()=>HomeScreenDM());
              },
              icon: Icon(
                Icons.home,
                size: 30,
              ),
            ),
          ],
        ),
        body:FutureBuilder(
          future: controller.fetchDataProfile(),
          builder: (context,snapShot){
            if(!snapShot.hasData){
              return Center(child: CircularProgressIndicator());
            }else{
              return  Column(
                children: [
                  Container(
                    width: Get.width,
                    height: 133,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 9),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                            'images/user-circle.svg'
                        ),
                        Text(
                          // "أحمد الغامدي",
                          controller.name,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF447A78),
                          ),
                        ),
                        Text(
                          controller.typeUser,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF447A78),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Column(
                          children: [
                            _buildItem(
                              title: controller.email, //"s438003060@st.uqu.edu.sa",
                              rightIconImage: "images/email.svg",
                              fontColor: Color(0xFF447A78),
                              onTap: (){
                                showCustomDialog(text: 'مرحبا بكم في تطبيقنا');
                              },
                            ),
                            SizedBox(height: 20),
                            _buildItem(
                              title: controller.typeUser,//"خدمة عملاء",
                              rightIconImage: "images/sitemap.svg",
                              fontColor: Color(0xFF447A78),
                              onTap: (){
                                showCustomDialog(text: 'مرحبا بكم في تطبيقنا');
                              },
                            ),

                            SizedBox(height: 20),
                                                       GestureDetector(
                                                         onTap: (){
                                                           Get.off(()=> SignInScreen());

                                                         },
                                                         child: _buildItem(
                              title: "تسجيل الخروج",
                              rightIconImage: "images/log-out.svg",
                              iconColor: Colors.red,
                              fontColor: Colors.red,
                              onTap: (){
                                Get.off(()=> SignInScreen());
                              },
                            ),
                                                       ),
                           /* InkWell(onTap: (){
                              Get.to(SettingScreen());
                            },
                              child: Text('الإعدادات'),
                            )*/
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class _buildItem extends StatelessWidget {
  final String title;
  final String? leftIconImage;
  final String? rightIconImage;
  Color? iconColor = Color(0xFF95989A);
  Color? fontColor = Color(0xFF447A78);
  Function()? onTap;

  _buildItem({
    this.leftIconImage,
    required this.title,
    this.rightIconImage,
    this.iconColor,
    this.onTap,
    this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        rightIconImage == null
            ? SizedBox(width: 30)
            : InkWell(
            onTap: onTap,
            child: SvgPicture.asset(rightIconImage!)
        ),
        SizedBox(width: 20),
        Expanded(
          child: Text(
            this.title,
            style: TextStyle(
              color: fontColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 20),
        leftIconImage == null
            ? SizedBox(width: 20)
            : InkWell(
            onTap: onTap,
            child:SvgPicture.asset(
                leftIconImage!
            )
        ),
      ],
    );
  }
}
