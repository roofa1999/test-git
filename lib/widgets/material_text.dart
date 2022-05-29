import 'package:flutter/material.dart';

class MaterialText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;

  const MaterialText({Key? key, this.text, this.fontSize, this.fontWeight, this.color, this.textAlign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Text(text!,
        textAlign: textAlign,
        style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color
      ),),
    );
  }
}
