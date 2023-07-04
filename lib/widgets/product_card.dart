import 'package:ecom_app/utils/color.dart';
import 'package:ecom_app/utils/constants.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key,required this.price,required this.category,required this.id,required this.image,required this.name});
  final String price;
  final String category;
  final String id;
  final String name;
  final String image;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool selected = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 0, 20, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: wColor,
                spreadRadius: 1,
                blurRadius: 0.6,
                offset: Offset(1, 1))
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.23,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(widget.image))),
                  ),
                  Positioned(
                      right: 10,
                      top: 10,
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(Icons.favorite_outline),
                      ))
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: appStyleWithHt(30, bColor, FontWeight.bold, 1.2),
                    ),
                    Text(
                      widget.category,
                      style: appStyleWithHt(18, gColor, FontWeight.bold, 1.4),
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 8,right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.price,style: appStyle(26, bColor, FontWeight.w600),),
                  Row(children: [
                    Text("Colors",style: appStyle(18, gColor, FontWeight.w500),),
                    SizedBox(width: 5,),
                    ChoiceChip(label: Text(""), selected: selected,
                    visualDensity: VisualDensity.compact,
                    selectedColor: bColor,),
                  ],)
                ],
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
