import 'package:flutter/material.dart';

import '../utils/color.dart';
import '../utils/constants.dart';


class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Padding(padding: EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: bColor,
          borderRadius: BorderRadius.circular(16)
        ),
        height: 50,
        width: MediaQuery.of(context).size.width*0.9,
        child: Center(
          child: Text("Add To Bag",style: appStyle(16, wColor,
                                                        FontWeight.bold),),
        ),
      ),),
    );
  }
}
