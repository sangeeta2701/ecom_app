import 'package:ecom_app/utils/constants.dart';
import 'package:flutter/material.dart';


class CategoryButton extends StatelessWidget {
  const CategoryButton({super.key,this.onpress,required this.buttonClr,required this.lable});
  final void Function()? onpress;
  final Color buttonClr;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onpress,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width*0.255,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: buttonClr,
            style: BorderStyle.solid
          ),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Center(child: Text(lable,style: appStyle(18, buttonClr, FontWeight.w600),)),
      ),
    );
  }
}