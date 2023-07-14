import 'package:flutter/material.dart';

import '../utils/color.dart';
import '../utils/constants.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    super.key,
    required this.lable,
    this.ontap
  });

  final void Function()? ontap;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
              color: bColor, borderRadius: BorderRadius.circular(16)),
          height: 50,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Center(
            child: Text(
              lable,
              style: appStyle(16, wColor, FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
