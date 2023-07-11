import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_app/controllers/product_provider.dart';
import 'package:ecom_app/services/hrlper.dart';
import 'package:ecom_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/snekers.dart';

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
                                  onTap: () {}, child: Icon(Icons.close)),
                              GestureDetector(
                                  onTap: () {}, child: Icon(Icons.more_vert))
                            ],
                          ),
                        ),
                        pinned: true,
                        snap: false,
                        floating: true,
                        backgroundColor: Colors.transparent,
                        expandedHeight: MediaQuery.of(context).size.height,
                        flexibleSpace: Flexible(
                            child: Stack(
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
                                              0.9,
                                          right: 20,
                                          child: Icon(
                                            Icons.favorite_outline,
                                          ),
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
                            )
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
