import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String title;
  final String imagePath;
  final bool obscureText;
  var validate;
  var onchange;
  CustomTextField({
    Key? key,
    this.textEditingController,
    required this.title,
    required this.imagePath,
    this.obscureText = false,
    this.validate,
    this.onchange
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          imagePath,
          width: 40,
          height: 40,
        ),
        SizedBox(width: 5),
        Expanded(
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validate,
            onChanged: onchange,
            controller: textEditingController,
            keyboardType: TextInputType.emailAddress,
            obscureText: obscureText,
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: title,
              hintStyle: TextStyle(
                color: Color(0xff707070),
                fontSize: 14,
              ),
            ),
          ),
        ),
        SizedBox(width: 30),
      ],
    );
  }
}
