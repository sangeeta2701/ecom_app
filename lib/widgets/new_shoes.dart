import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/color.dart';

class NewShoes extends StatelessWidget {
  const NewShoes({
    super.key,
    required this.imageUrl
  });
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: wColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
                color: wColor.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 0.8,
                offset: Offset(0, 1))
          ]),
      height: MediaQuery.of(context).size.height * 0.12,
      width: MediaQuery.of(context).size.width * 0.28,
      child: CachedNetworkImage(
          imageUrl:
              imageUrl),
    );
  }
}
