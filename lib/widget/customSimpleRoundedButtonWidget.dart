import 'package:flutter/material.dart';

class CustomSimpleRoundedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final double height;
  final double width;
  final Color buttoncolor;
  final Color buttontextcolor;
  final BorderRadius borderRadius;
  static Widget? child;
  const CustomSimpleRoundedButton({
    Key? key,
    required this.buttonText,
    required this.onTap,
    required this.height,
    required this.width,
    required this.buttoncolor,
    required this.buttontextcolor,
    required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttoncolor,
          borderRadius: borderRadius,
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
                color: buttontextcolor,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final Icon icon;
  const CustomIconButton({Key? key, required this.onTap, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap, child: icon);
  }
}
