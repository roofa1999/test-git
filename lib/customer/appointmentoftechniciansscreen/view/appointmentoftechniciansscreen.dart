import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:get/get.dart';
import 'package:roofa/const/const_color.dart';

class AppointmentOfTechniciansScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: Text('تعيين الفنيين', style: TextStyle(

            ),),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(
                  'images/arrow-up.svg',
                ),
              ),
            ),
            actions: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        'images/notifications.svg',
                        width: 23,
                        height: 23,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 2,
                    top: 2,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text('4',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),),
                    ),
                  )
                ],
              ),
            ],
          ),
          body: Column(
            children: [
             Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                     children: [
                       Expanded(
                         flex: 4,
                         child: Container(
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(50.0),
                               boxShadow: [
                                 BoxShadow(
                                     color: Color(0xffA2A2A2).withOpacity(.16),
                                     offset: Offset(0, 9),
                                     blurRadius: 10
                                 )
                               ]
                           ),
                           child: TextFormField(
                             decoration: InputDecoration(
                                 fillColor: Colors.white,
                                 filled: true,
                                 border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(50.0)
                                 ),
                                 focusedBorder: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(50.0),
                                     borderSide: BorderSide(
                                         color: Colors.transparent,
                                         width: 0
                                     )
                                 ),
                                 disabledBorder: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(50.0),
                                     borderSide: BorderSide(
                                         color: Colors.transparent,
                                         width: 0
                                     )
                                 ),
                                 enabledBorder: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(50.0),
                                     borderSide: BorderSide(
                                         color: Colors.transparent,
                                         width: 0
                                     )
                                 ),
                                 prefixIcon: IconButton(
                                   icon: Icon(Icons.search),
                                   onPressed: () {},
                                 ),
                                 hintText: 'البحث برقم البلاغ',
                                 contentPadding: EdgeInsets.all(0)
                             ),
                           ),
                         ),
                       ),
                       Expanded(
                           child: GestureDetector(
                             onTap: () {},
                             child: SvgPicture.asset(
                                 'images/date-range.svg'
                             ),
                           )
                       )
                     ],
                   ),
                 ),
                 SizedBox(height: 34,),
                 Container(
                   width: double.infinity,
                   height: 133,
                   decoration: BoxDecoration(
                       color: Colors.white,
                       boxShadow: [
                         BoxShadow(
                             color: Color(0xffA2A2A2).withOpacity(.16),
                             offset: Offset(0,5),
                             blurRadius: 10
                         )
                       ]
                   ),
                   child: Column(
                     children: [
                       GestureDetector(
                         onTap: (){},
                         child: Container(
                           padding: EdgeInsets.symmetric(
                               horizontal: 30,
                               vertical: 12
                           ),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text('فرز على حسب الجهة',style: TextStyle(
                                   fontWeight: FontWeight.bold,
                                   fontSize: 17,
                                   color: mainColor
                               ),),
                               SvgPicture.asset('images/arrow-down.svg')
                             ],
                           ),
                         ),
                       ),
                       Divider(),
                       GestureDetector(
                         onTap: (){},
                         child: Container(
                           padding: EdgeInsets.symmetric(
                               horizontal: 30,
                               vertical: 12
                           ),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text('فرز على حسب المقر',style: TextStyle(
                                   fontWeight: FontWeight.bold,
                                   fontSize: 17,
                                   color: mainColor
                               ),),
                               SvgPicture.asset('images/arrow-down.svg')
                             ],
                           ),
                         ),
                       ),

                     ],
                   ),
                 )
               ],
             ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (ctx,index){
                    return Text('');
                  },
                ),
              )
            ],
          )
      ),
    );
  }
}


