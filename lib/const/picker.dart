import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roofa/const/const_color.dart';

class Picker{
  static PickedFile? image=null;
  static FilePickerResult? file_result = null;


static void pickerFile()async{
  file_result = await FilePicker.platform.pickFiles();
  if (file_result != null) {
    File file = File("${file_result!.files.single.path}");
  } else {
    // User canceled the picker
  }
}
  static void openCamera(BuildContext context)  async{
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera ,
    );
      image = pickedFile!;
    Navigator.pop(context);
  }

  static void openGallery(BuildContext context) async{
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery ,
    );

      image = pickedFile!;

    Navigator.pop(context);
  }
  ///
  static Future<void> showChoiceDialog(BuildContext context) {
    return showDialog(context: context,builder: (BuildContext context){

      return AlertDialog(
        title: Text("Choose option",style: TextStyle(
            color: mainColor),),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Divider(height: 1,color: mainColor,),
              ListTile(
                onTap: (){
                  openGallery(context);
                },
                title: Text("Gallery"),
                leading: Icon(Icons.account_box,
                  color: mainColor,),
              ),

              Divider(height: 1,color: mainColor,),
              ListTile(
                onTap: (){
                  openCamera(context);
                },
                title: Text("Camera"),
                leading: Icon(Icons.camera,
                  color: mainColor,),
              ),
            ],
          ),
        ),);
    });
  }

}