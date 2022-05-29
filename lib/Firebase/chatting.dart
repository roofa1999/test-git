
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Chatting {
  static String name="";
  static String userName="";
  static String? EMAIL;
  static String? NAME;
  static String? ID_CHAT;
  static String? ID_MESSAGE;
  static String? SERVICE_EMAIL;
  static String? CUSTOMER_EMAIL;
  static String? SERVICE_NAME;
  static String? CUSTOMER_NAME;
  static String? TEXT_MESSAGE;
  static String? TYPE_USER;
  static String? TYPE_USER2;
  static DateTime? TEXT_DATE;
  static var listHellper;
  
  static Future<bool> getIdMessages() async {
    try {
      if(TYPE_USER=="خدمة العملاء"||TYPE_USER=="المستفيد"){
        await FirebaseFirestore.instance
            .collection('messages')
        //.where("SERVICE_email", isEqualTo: "SERVICE@gmail.com")
        //.where("SERVICE_email", isEqualTo: "${SERVICE_EMAIL}")
        //.where("CUSTOMER_email", isEqualTo: "CUSTOMER@gmail.com")
            .where("customer_email", isEqualTo: "${CUSTOMER_EMAIL}")
            .get()
            .then((value) {
          if (value.docs.isNotEmpty) {
            print("id : " + value.docs[0].id);
            ID_CHAT = value.docs[0].id;
            return true;
          } else {
            ID_CHAT ="null";
            addChat();
            return false;
          }
          // print('Heelllo');
        });
      }else{
        await FirebaseFirestore.instance
            .collection('messages')
            .where("type1", isEqualTo:"مدير القسم")
            .get()
            .then((value) {
          if (value.docs.isNotEmpty) {
            print("id : " + value.docs[0].id);
            ID_CHAT = value.docs[0].id;
            return true;
          } else {
            ID_CHAT ="null";
            addChat();
            return false;
          }
          // print('Heelllo');
        });
      }

    } on FirebaseException catch (e) {
      print(e.message);
  }
  return false;
}

  static Future<void> sendMessage() async {
    try {
      if(ID_CHAT=="null") {
        await addChat();
      }else{

        await FirebaseFirestore.instance
            .collection('messages')
        //  .doc("2Ph0SdvtmQzhQ5SA8kGs")
            .doc("${ID_CHAT}")
            .collection('chat',)
            .add({
          "date_message": DateTime.now(),
          // "sender_email": "sender@gmail.com",
          "sender_email": "${EMAIL}",
          "sender_type": "${TYPE_USER}",
          // "text": "text_message",
          "text": "${TEXT_MESSAGE}",
        }).then((value) => {print("done send message")});
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> addChat() async {
    try {
      if(TYPE_USER=="خدمة العملاء"||TYPE_USER=="المستفيد"){
        await FirebaseFirestore.instance.collection('messages').add({
          // "SERVICE_email": "SERVICE3@gmail.com",
          //"SERVICE_email": "${SERVICE_EMAIL}",
          // "CUSTOMER_email": "CUSTOMER3@gmail.com",
          "customer_email": "${CUSTOMER_EMAIL}",
          "type1":"المستفيد",
          "type2":"خدمة العملاء",
        }).then((value) => value.collection("chat").add({
          "date_message": DateTime.now(),
          "sender_email": "",
          "sender_type": "",
          "text": "create",
        }).then((value) => {
          print("Done Add Chat!"),
          getIdMessages(),
        }));
      }else{
        await FirebaseFirestore.instance.collection('messages').add({
          // "SERVICE_email": "SERVICE3@gmail.com",
          //"SERVICE_email": "${SERVICE_EMAIL}",
          // "CUSTOMER_email": "CUSTOMER3@gmail.com",
          "customer_email": "${CUSTOMER_EMAIL}",
          "type1":"مدير القسم",
          "type2":"الإدارة العليا",
        }).then((value) => value.collection("chat").add({
          "date_message": DateTime.now(),
          "sender_email": "",
          "sender_type": "",
          "text": "create",
        }).then((value) => {
          print("Done Add Chat!"),
          getIdMessages(),
        }));
      }

    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  static Future<bool> deleteMessage() async {
    bool isDeleted = false;
    try {
      await FirebaseFirestore.instance
          .collection('messages')
          .doc('${ID_CHAT}')
          .collection('chat')
          .doc('${ID_MESSAGE}')
          .delete()
          .then((value) {
        isDeleted = true;
        print("done delete chat");
      });
    } on FirebaseException catch (e) {
      print(e.message);
    }
    return isDeleted;
  }

  static  getMessages() async {
  try {
      final snapshot = await FirebaseFirestore.instance
          .collection('messages')
          .doc("${ID_CHAT}")
          .collection('chat').snapshots();
      if(snapshot!=null){
        print("length messages : " + "${snapshot.length}");
  }
      return snapshot;
    /*.get()
          .then((value) => {
                print("length messages : " + "${value.docs.length}"),
              });*/
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }
  
  static String formatTimestamp(Timestamp timestamp) {
    var format =  new DateFormat('yMMMMd'); // <- use skeleton here
    //return format.format(timestamp.toDate());
    return DateFormat.yMMMMd()
        .add_jms()
        .format(timestamp.toDate());
  }
  





  /*static Future<bool> getAdditives1()async{
    try{
      if(name==""){
        await FirebaseFirestore.instance
            .collection("additives")
           //.where('SERVICE_email',isEqualTo: "SERVICE@gmail.com")
            .where('${MyUser.TYPEUSER}_email',isEqualTo:"${EMAIL}")
            .get().then((snapshot) {
          if(snapshot.docs.isNotEmpty){
            print("done emails additives :" );
            for(int i=0;i<snapshot.docs.length;i++){
              //print(snapshot.docs[i]["${TYPE_USER2}"]);
              print(snapshot.docs[i]["CUSTOMER_email"]);
            }
            listHellper=snapshot.docs;
          }else{
            print("NOT FOUND PATIENS");
          }
          return true;
        });
      }
      else{
        await FirebaseFirestore.instance
            .collection("additives")
        //.where('SERVICE_email',isEqualTo: "SERVICE@gmail.com")
            .where('${MyUser.TYPEUSER}_email',isEqualTo:"${EMAIL}")
            .get().then((snapshot) {
          if(snapshot.docs.isNotEmpty){
            print("done emails additives :" );
          }else{
            print("NOT FOUND PATIENS");
          }
          var list=[];
          //list.clear();
          snapshot.docs.forEach((element) {
            element['CUSTOMER_email'].toLowerCase().contains(name)?list.add(element):"";
          });
          //print("length : "+"${list.length}");
          listHellper=list;
          for(int i=0;i<list.length;i++){
            //print(snapshot.docs[i]["${TYPE_USER2}"]);
            print(list[i]["CUSTOMER_email"]);
          }
          //print("length : "+"${listHellper.length}");
          return true;
        });
      }



    }on FirebaseException catch(e){
      print(e.message);
    }
    return false;
  }*/

  static Future<String?> getNameEmail({email,typeUser}) async {
    try{
      final snapshot =  await FirebaseFirestore.instance
          .collection("${typeUser}")
          .where("email",isEqualTo: "${email}")
          .get();
      if(snapshot.docs.isNotEmpty){
        // print("length addvities : ${snapshot}");
      //*  print("done fetch name : "+snapshot.docs[0]['displayName']);
        return snapshot.docs[0]['name'];
      }else{
        print("failed fetch name");
        return "";
      }
    }on FirebaseException catch(e){
      print(e.message);
    }
  }
}

class MSG{
  final DateTime? date_message;
  final String? message;
  final String? sender_email;
  final String? sender_type;
  final String? id;
  MSG({this.message,this.date_message,this.sender_email,this.sender_type,this.id});
}

class Additives{
}

