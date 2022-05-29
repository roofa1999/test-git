import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roofa/const/const_color.dart';
import 'package:roofa/department_manager/supervise_reports/controller/supervise_repot_controller.dart';
import 'package:roofa/temp/temp.dart';
import '/customer_services/new_report/view/new_report_screen.dart';
import 'package:roofa/department_manager/achievement_of_technicians/view/achievement_of_technicians_screen.dart';
import 'package:roofa/department_manager/home_page/view/home_page.dart';
import 'package:roofa/department_manager/report/view/report_screen.dart';
import 'package:roofa/department_manager/show_reports/view/show_reports_screen.dart';
import 'package:roofa/department_manager/supervise_reports/view/tracking_repot_screen.dart';
import 'package:roofa/higher_management/complaints_and_suggestions/controller/complaintsandsuggestions_controller.dart';
import 'package:roofa/higher_management/complaints_and_suggestions/view/complaintsandsuggestions_screen.dart';
import 'package:roofa/higher_management/homepage/view/home_screen.dart';
import 'package:roofa/higher_management/how_can_show_replay/view/how_can_show_replay.dart';
import 'package:roofa/higher_management/report_late_hm/view/report_late_screen.dart';
import 'package:roofa/higher_management/statistic_ticket/view/statistic_screen.dart';
import 'package:roofa/insert_phone_number/view/inser_phone_number_screen.dart';
import 'package:roofa/language/view/language_screen.dart';
import 'package:roofa/login/controller/login_controller.dart';
import 'package:roofa/new_user_signup/view/new_user_screen.dart';
import 'package:roofa/pin_code/view/pin_code_screen.dart';
import 'package:roofa/preview_screen/view/preview_screen.dart';
import 'package:roofa/rating/view/rating_screen.dart';
import 'package:roofa/recovery_password/view/recovery_password_screen.dart';
import 'package:roofa/select_type_conection.dart';
import 'package:roofa/setting/view/setting_screen.dart';
import '/technical/home_screen/view/home_screen.dart';
import '/technical/superviser_reports/view/superviser_screen.dart';
import 'package:roofa/user_profile/view/user_profile_screen.dart';

import 'Customer/connection_customer_services/view/conection_customer_services_screen.dart';

import 'Customer/send_report/view/send_report_screen.dart';
import 'Customer/supervise_reports/view/superviser_report_screen.dart';
import 'const/pattel.dart';
import 'customer/details_ticket/view/details_ticket.dart';
import 'customer_services/details_ticket/view/details_ticket_screen.dart';
import 'customer_services/home_page/view/home_page.dart';
import 'customer_services/reports_screen/view/reports_screen.dart';
import 'customer_services/supervise_report/view/supervise_report_screen.dart';
import 'department_manager/chosen_techinical_for_ticket/view/chosen_technical_for_ticket.dart';
import 'department_manager/chosen_technical/view/chosen_technical_screen.dart';
import 'department_manager/report_log/view/report_log_screen.dart';
import 'department_manager/show_ticket_reports/view/show_ticket_repot_screen.dart';
import 'login/view/login_screen.dart';
import '/technical/achievement/view/achivementScreen.dart';
import '/technical/show_tasks/view/show_tasks_screen.dart';
import '/technical/ticket_details/view/ticket_details_screen.dart';
import 'sign_in/view/sign_in_screen.dart';
import 'technical/reports/view/reports_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp() ;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //من أجل تناسق الشاشات في جميع القياسات (موبايل - ويب - ايففون - ديسكتوب ....الخ)
      //responsive
        designSize: const Size(360,640),
        //
        //10.w  // w = width screen
        //10.h  // h = hegith screen
        //10.sp  //
        //10.r  //radius
        //قياسات شاشة الموبايل
        builder: ()=>
        //إدارة التطبيق statemanagment
        //getX
            GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'SOON',
              theme: ThemeData(
                //to convert HexColor To Material Color
                primarySwatch: Palette.kToDark,
                appBarTheme: AppBarTheme(
                  color: mainColor,
                  toolbarTextStyle: TextStyle(
                    color: Colors.white
                  )
                )
              ),
              //Colors for all App
              home: SignInScreen(),
              //Start Screen Show
              getPages: [
                //routs  all Screens in my app
                GetPage(name: '/', page: ()=> PreviewScreen()),
                GetPage(name: '/login_screen', page: ()=>LoginScreen()),
                GetPage(name: '/signup_screen', page: ()=>SignInScreen()),
               // GetPage(name: '/pincode_screen', page: ()=> PinCodeScreen()),
                GetPage(name: '/user_profile_screen', page: ()=> UserProfileScreen()),
                GetPage(name: '/recovery_password_screen', page: ()=> RecoveryPasswordScreen()),
                GetPage(name: '/superviser_report_screen', page: ()=> SuperviserReportsScreen()),
                GetPage(name: '/details_ticket_screen', page: ()=> DetailsTicketScreen()),
                GetPage(name: '/conection_customer_services_screen', page: ()=> ConectionCustomerServicesScreen()),
                GetPage(name: '/select_type_conection_screen', page: ()=> SelectTypeConectionScreen()),
                GetPage(name: '/send_report_screen', page: ()=> SendReportScreen()),
               // GetPage(name: '/details_problem_screen', page: ()=> DetalisProblemScreen()),
                GetPage(name: '/rating_screen', page: ()=> RatingScreen()),
                GetPage(name: '/reports_log_screen', page: ()=> ReportsLogPage()),
                GetPage(name: '/HM_report_late', page: ()=> ReportLateHMScreen()),
                GetPage(name: '/HM_details_ticket', page: ()=> ReportLateHMScreen()),
                GetPage(name: '/HM_statistic_screen', page: ()=> StatisticScreen()),
                GetPage(name: '/HM_complaints_and_suggestions_screen', page: ()=> ComplaintsAndSuggestionsScreen()),
                GetPage(name: '/DM_achievement_of_technicians_screen', page: ()=> AchievementOfTechniciansScreen()),
                GetPage(name: '/DM_show_reports', page: ()=> ShowReportsDMScreen()),
                GetPage(name: '/DM_report_screen', page: ()=> ReportDMScreen()),
                GetPage(name: '/DM_tracking_report_screen', page: ()=> TrackingRepotDMScreen()),
                GetPage(name: '/DM_show_ticket_report_screen', page: ()=> ShowTicketReportDMScreen()),
                GetPage(name: '/DM_report_log_screen', page: ()=> ReportLogDMScreen()),
                GetPage(name: '/DM_chosen_technical_Screen', page: ()=> ChosenTechnicalDMScreen()),
                GetPage(name: '/DM_chosen_technical_for_ticket_screen', page: ()=> ChosenTechnicalForTicketDMScreen()),
                GetPage(name: '/CS_home_screen', page: ()=> HomeScreenCS()),
                GetPage(name: '/CS_new_report', page: ()=> NewReportCSScreen()),
                GetPage(name: '/CS_details_ticket_screen', page: ()=> DetailsTicketCSScreen()),
                GetPage(name: '/CS_supervise_report_screen', page: ()=> SuperviseReportCSScreen()),
                GetPage(name: '/CS_report_log_screen', page: ()=> ReportsScreen()),
                GetPage(name: '/T_home_screen', page: ()=> HomeScreenT()),
                GetPage(name: '/T_show_tasks_screen', page: ()=> ShowTasksTScreen()),
                GetPage(name: '/T_details_ticket', page: ()=> DetailsTicketTScreen()),
                GetPage(name: '/T_reports_screen', page: ()=> ReportsTScreen()),
                GetPage(name: '/T_achivement_screen', page: ()=> AchivementTScreen()),
                GetPage(name: '/T_superviser_screen', page: ()=> SuperviserReportTScreen()),
              ],
            ));
  }
}
//NewUserSignUpScreen
//SignInScreen
//UserProfileScreen