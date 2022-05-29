import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          //To top image
          Positioned(
            top: 0,
            left: 0,
            child: SvgPicture.asset(
              'images/header.svg'
            )
          ),
          //to fotter image
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(
                'images/footer.svg'
            )
          ),
          child,
        ],
      ),
    );
  }
}
