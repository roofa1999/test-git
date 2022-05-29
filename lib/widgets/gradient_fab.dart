import 'package:flutter/material.dart';

class GradientFloatingActionButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final IconData icon;

  const GradientFloatingActionButton({Key? key, required this.onPressed, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      elevation: 0,
      onPressed: onPressed,
      child: Container(
        width: 60,
        height: 60,
        child: Icon(
          icon,
          size: 20,
        ),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff28A2CF), Color(0xff55E96A)])),
      ),
    );
  }
}
