import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_app/utils/color.dart';
import 'package:ecom_app/utils/constants.dart';
import 'package:flutter/material.dart';

class StaggerTile extends StatefulWidget {
  const StaggerTile({super.key, required this.imageUrl,required this.name,required this.price});
  final String imageUrl;
  final String name;
  final String price;

  @override
  State<StaggerTile> createState() => _StaggerTileState();
}

class _StaggerTileState extends State<StaggerTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: wColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              // height: 400,
              imageUrl: widget.imageUrl,
              fit: BoxFit.fill,
            ),
            SizedBox(
              // padding: EdgeInsets.only(top: 8),
              height: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: appStyleWithHt(18, bColor, FontWeight.w700,1.0),
                  ),
                  Text(
                    widget.price,
                    style: appStyle(18, bColor, FontWeight.w500),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
