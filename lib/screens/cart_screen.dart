import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_app/utils/color.dart';
import 'package:ecom_app/utils/constants.dart';
import 'package:ecom_app/utils/sizdBox.dart';
import 'package:ecom_app/widgets/checkoutButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final _cartBox = Hive.box("cart_box");

  @override
  Widget build(BuildContext context) {
    List<dynamic> cart = [];
    final cartData = _cartBox.keys.map((key) {
      final item = _cartBox.get(key);
      return {
        "key": key,
        "id": item["id"],
        "category": item["category"],
        "name": item["name"],
        "imageUrl": item["imageUrl"],
        "price": item["price"],
        "qty": item["qty"],
        "sizes": item["sizes"]
      };
    }).toList();
    cart = cartData.reversed.toList();
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: bColor,
                        )),
                  ),
                  Text(
                    "My Cart",
                    style: appStyle(30, bColor, FontWeight.bold),
                  ),
                  height12,
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.70,
                    child: ListView.builder(
                        itemCount: cart.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final data = cart[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                              child: Slidable(
                                key: ValueKey(0),
                                endActionPane: ActionPane(
                                  motion: ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: doNothing,
                                      flex: 1,
                                      backgroundColor: Color(0xff000000),
                                      foregroundColor: wColor,
                                      icon: Icons.delete,
                                      label: "Delete",
                                    )
                                  ],
                                ),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.11,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: wColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: gColor.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 0.3,
                                          offset: Offset(0, 1),
                                        ),
                                      ]),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: CachedNetworkImage(
                                                imageUrl: data["imageUrl"],
                                                width: 70,
                                                height: 70,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12, left: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data["name"],
                                                    style: appStyle(
                                                        16, bColor, FontWeight.bold),
                                                  ),
                                                  height4,
                                                  Text(
                                                    data["category"],
                                                    style: appStyle(
                                                        14, gColor, FontWeight.w500),
                                                  ),
                                                   Row(
                                                     children: [
                                                       Text(
                                                        data["price"],
                                                        style: appStyle(
                                                            16, bColor, FontWeight.w600),
                                                  ),
                                                  width12,
                                                   Text(
                                                        "Size: ${data["sizes"]}",
                                                        style: appStyle(
                                                            16, gColor, FontWeight.w500),
                                                  ),
                                                     ],
                                                   ),
                                                ],
                                              ),
                                            ),
                                            
                                          ]),
                                          Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: wColor,
                                                      borderRadius: BorderRadius.circular(16),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        InkWell(
                                                          onTap: (){
                                                            //decrement
                                                          },
                                                          child: Icon(Icons.indeterminate_check_box,size: 20,color: gColor,),
            
                                                        ),
                                                        Text(data["qty"].toString(),style: appStyle(
                                                        12, bColor, FontWeight.bold),),
                                    InkWell(
                                                          onTap: (){
                                                            //increment
                                                          },
                                                          child: Icon(Icons.add_box,size: 20,color: bColor,),
            
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 4),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CheckoutButton(lable: "Proceed to Checkout"),
            ),),
          ],
        ),
      ),
    );
  }
  void doNothing(BuildContext context) {}
}
