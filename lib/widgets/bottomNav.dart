import 'package:flutter/material.dart';

import '../utils/color.dart';

class bottomNavWidget extends StatelessWidget {
  const bottomNavWidget({
    Key? key,
    required this.ontap,
    required this.icon,
  }) : super(key: key);
  final void Function()? ontap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: SizedBox(
        height: 36,
        width: 36,
        child: Icon(
          icon,
          color: wColor,
        ),
      ),
    );
  }
}
