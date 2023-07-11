import 'package:ecom_app/screens/product_by_cart.dart';
import 'package:ecom_app/screens/product_detail_screen.dart';
import 'package:ecom_app/widgets/product_card.dart';
import 'package:flutter/material.dart';

import '../models/snekers.dart';
import '../utils/color.dart';
import '../utils/constants.dart';
import 'new_shoes.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required Future<List<Snekers>> male,
    required this.tabIndex,
  }) : _male = male;

  final Future<List<Snekers>> _male;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.415,
          child: FutureBuilder<List<Snekers>>(
              future: _male,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                } else {
                  final male = snapshot.data;
                  return ListView.builder(
                      itemCount: male!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final shoe = snapshot.data![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailScreen(id: shoe.id, category: shoe.category)));
                          },
                          child: ProductCard(
                              price: "\$${shoe.price}",
                              category: shoe.category,
                              id: shoe.id,
                              image: shoe.imageUrl[0],
                              name: shoe.title),
                        );
                      });
                }
              }),
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(12, 20, 12, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest Shoes",
                    style: appStyle(24, bColor, FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductByCart(
                            tabIndex: tabIndex,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          "Show All",
                          style: appStyle(22, bColor, FontWeight.w600),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.13,
            child: FutureBuilder<List<Snekers>>(
                future: _male,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error ${snapshot.error}");
                  } else {
                    final male = snapshot.data;
                    return ListView.builder(
                        itemCount: male!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final shoe = snapshot.data![index];
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: NewShoes(imageUrl: shoe.imageUrl[0]),
                          );
                        });
                  }
                })
            // child: ListView.builder(
            //     itemCount: 6,
            //     scrollDirection: Axis.horizontal,
            //     itemBuilder: (context, index) {
            //       return Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: NewShoes(),
            //       );
            //     }),
            )
      ],
    );
  }
}
