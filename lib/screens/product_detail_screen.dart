import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_app/controllers/product_provider.dart';
import 'package:ecom_app/screens/favourite_screen.dart';
import 'package:ecom_app/services/hrlper.dart';
import 'package:ecom_app/utils/color.dart';
import 'package:ecom_app/utils/constants.dart';
import 'package:ecom_app/utils/sizdBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../models/fcontants.dart';
import '../models/snekers.dart';
import '../widgets/checkoutButton.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen(
      {super.key, required this.id, required this.category});

  final String id;
  final String category;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController pageController = PageController();
  final _cartBox = Hive.box("cart_box");
  final _favBox = Hive.box("_favBox");

  Future<void> _createFav(Map<String, dynamic> addFav) async {
    await _favBox.add(addFav);
    getFavorites();
  }

  getFavorites() {
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {"key": key, "id": item["id"]};
    }).toList();
    favor = favData.toList();
    ids = favor.map((item) => item["id"]).toList();
    setState(() {});
  }

  late Future<Snekers> _sneaker;

  void getShoes() {
    if (widget.category == "Men's Running") {
      _sneaker = Helper().getMaleSnekerById(widget.id);
    } else if (widget.category == "Women's Running") {
      _sneaker = Helper().getFemaleSnekerById(widget.id);
    } else {
      _sneaker = Helper().getKidsSnekerById(widget.id);
    }
  }

  Future<void> _createCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }

  @override
  void initState() {
    getShoes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Snekers>(
          future: _sneaker,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error ${snapshot.error}");
            } else {
              final sneaker = snapshot.data;
              return Consumer<ProductNotifier>(
                builder: (context, productNotifier, child) {
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        leadingWidth: 0,
                        title: Padding(
                          padding: EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    productNotifier.shoesSize.clear();
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: bColor,
                                  )),
                              GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.more_horiz,
                                    color: bColor,
                                  ))
                            ],
                          ),
                        ),
                        pinned: true,
                        snap: false,
                        floating: true,
                        backgroundColor: Colors.transparent,
                        expandedHeight: MediaQuery.of(context).size.height,
                        flexibleSpace: FlexibleSpaceBar(
                            background: Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width,
                              child: PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: sneaker!.imageUrl.length,
                                  controller: pageController,
                                  onPageChanged: (page) {
                                    productNotifier.activePage = page;
                                  },
                                  itemBuilder: (context, int index) {
                                    return Stack(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.39,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: gColor.withOpacity(0.3),
                                          child: CachedNetworkImage(
                                            imageUrl: sneaker.imageUrl[index],
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Positioned(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.09,
                                          right: 20,
                                          child: Consumer<FavoritesNotifier>(
                                              builder: (context,
                                                  favoritesNotifier, child) {
                                            return GestureDetector(
                                              onTap: () {
                                                if (ids.contains(widget.id)) {
                                                  Navigator.push(
                                                      context, MaterialPageRoute(builder: (context)=>FavouriteScreen()));
                                                } else {}
                                              },
                                              child: ids.contains(sneaker.id)
                                                  ? Icon(Icons.favorite)
                                                  : Icon(Icons
                                                      .favorite_border_outlined),
                                            );
                                          }),
                                          // child: Icon(
                                          //   Icons.favorite_outline,
                                          //   color: gColor,
                                          // ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          left: 0,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List.generate(
                                              sneaker.imageUrl.length,
                                              (index) => Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 4),
                                                child: CircleAvatar(
                                                  radius: 5,
                                                  backgroundColor:
                                                      productNotifier
                                                                  .activepage !=
                                                              index
                                                          ? gColor
                                                          : bColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                            Positioned(
                                bottom: 30,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.630,
                                    width: MediaQuery.of(context).size.width,
                                    color: wColor,
                                    child: Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            sneaker.name,
                                            style: appStyle(
                                                26, bColor, FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                sneaker.category,
                                                style: appStyle(18, gColor,
                                                    FontWeight.w500),
                                              ),
                                              width20,
                                              RatingBar.builder(
                                                itemCount: 5,
                                                itemSize: 22,
                                                itemPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 1),
                                                initialRating: 4,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemBuilder: (context, _) {
                                                  return Icon(
                                                    Icons.star,
                                                    size: 18,
                                                    color: bColor,
                                                  );
                                                },
                                                onRatingUpdate: (rating) {},
                                              )
                                            ],
                                          ),
                                          height12,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "\$${sneaker.price}",
                                                style: appStyle(26, bColor,
                                                    FontWeight.w600),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Colors",
                                                    style: appStyle(18, bColor,
                                                        FontWeight.w500),
                                                  ),
                                                  width4,
                                                  CircleAvatar(
                                                    radius: 7,
                                                    backgroundColor: bColor,
                                                  ),
                                                  width4,
                                                  CircleAvatar(
                                                    radius: 7,
                                                    backgroundColor: Colors.red,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          height12,
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Select Sizes",
                                                    style: appStyle(20, bColor,
                                                        FontWeight.w600),
                                                  ),
                                                  width20,
                                                  Text(
                                                    "View size guide",
                                                    style: appStyle(20, gColor,
                                                        FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                              height12,
                                              SizedBox(
                                                height: 40,
                                                child: ListView.builder(
                                                    itemCount: productNotifier
                                                        .shoesSize.length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    padding: EdgeInsets.zero,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final sizes =
                                                          productNotifier
                                                              .shoesSize[index];
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8),
                                                        child: ChoiceChip(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          60),
                                                              side: BorderSide(
                                                                  color: bColor,
                                                                  width: 1)),
                                                          disabledColor: wColor,
                                                          selectedColor: bColor,
                                                          label: Text(
                                                            sizes['size'],
                                                            style: appStyle(
                                                                18,
                                                                sizes["isSelected"]
                                                                    ? wColor
                                                                    : bColor,
                                                                FontWeight
                                                                    .w500),
                                                          ),
                                                          selected: sizes[
                                                              'isSelected'],
                                                          onSelected:
                                                              (newState) {
                                                            // productNotifier
                                                            //     .toggleCheck(
                                                            //         index);
                                                            if (productNotifier
                                                                .sizes
                                                                .contains(sizes[
                                                                    "size"])) {
                                                              productNotifier
                                                                  .sizes
                                                                  .remove(sizes[
                                                                      "size"]);
                                                            } else {
                                                              productNotifier
                                                                  .sizes
                                                                  .add(sizes[
                                                                      "size"]);
                                                            }
                                                            print(
                                                                productNotifier
                                                                    .sizes);
                                                            productNotifier
                                                                .toggleCheck(
                                                                    index);
                                                          },
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ],
                                          ),
                                          height12,
                                          Divider(
                                            indent: 10,
                                            endIndent: 10,
                                            color: bColor,
                                          ),
                                          height12,
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: Text(
                                              sneaker.title,
                                              style: appStyle(
                                                  20, bColor, FontWeight.w700),
                                            ),
                                          ),
                                          height8,
                                          Text(
                                            sneaker.description,
                                            style: appStyle(
                                                14, gColor, FontWeight.normal),
                                            textAlign: TextAlign.justify,
                                            maxLines: 4,
                                          ),
                                          height8,
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: CheckoutButton(
                                                lable: "Add To Cart",
                                                ontap: () async {
                                                  _createCart({
                                                    "id": sneaker.id,
                                                    "name": sneaker.name,
                                                    "category":
                                                        sneaker.category,
                                                    "sizes":
                                                        productNotifier.sizes,
                                                    "imageUrl":
                                                        sneaker.imageUrl[0],
                                                    "price": sneaker.price,
                                                    "qty": 1
                                                  });
                                                  productNotifier.sizes.clear();
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        )),
                      ),
                    ],
                  );
                },
              );
            }
          }),
    );
  }
}
