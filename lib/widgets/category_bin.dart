import 'package:ecom_app/utils/constants.dart';
import 'package:flutter/material.dart';

class CategoryBin extends StatelessWidget {
  const CategoryBin({super.key,this.onpress,required this.buttonColor,required this.lable});
  final void Function()? onpress;
  final Color buttonColor;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onpress,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.255,
        decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: buttonColor,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.all(Radius.circular(9))),
        child: Text(
          lable,
          style: appStyle(20, buttonColor, FontWeight.w600),
        ),
      ),
    );
  }
}
