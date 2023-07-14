import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_app/utils/color.dart';
import 'package:ecom_app/utils/constants.dart';
import 'package:ecom_app/utils/sizdBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Cart extends StatelessWidget {
  Cart({super.key});

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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Column(
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
                height20,
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
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
                                    color: gColor.withOpacity(0.1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: gColor.withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 0.3,
                                        offset: Offset(0, 1),
                                      ),
                                    ]),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
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
                                            )
                                          ],
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  void doNothing(BuildContext context) {}
}
