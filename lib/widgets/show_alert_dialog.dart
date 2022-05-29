import 'package:flutter/material.dart';

class ShowAlertDialog extends StatelessWidget {
  final String title;
  ShowAlertDialog({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Column(
        children: [
          Image.asset("images/task_complete.png"),
          SizedBox(height: 15),
          Text(
            title,
            style: TextStyle(
              fontSize: 23,
              color: Color(0xFF707070),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
