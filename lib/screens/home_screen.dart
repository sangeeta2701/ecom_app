import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_app/models/snekers.dart';
import 'package:ecom_app/services/hrlper.dart';
import 'package:ecom_app/utils/color.dart';
import 'package:ecom_app/utils/constants.dart';
import 'package:ecom_app/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);
  late Future<List<Snekers>> _male;
  late Future<List<Snekers>> _female;
  late Future<List<Snekers>> _kids;

  void getMale() {
    _male = Helper().getMaleSneker();
  }

  void getFemale() {
    _female = Helper().getFemaleSneker();
  }

  void getKids() {
    _kids = Helper().getKidsSneker();
  }

  @override
  void initState() {
    getMale();
    getFemale();
    getKids();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 35, 0, 0),
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/top_image.png"),
                        fit: BoxFit.fill)),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Shoes",
                          style:
                              appStyleWithHt(42, wColor, FontWeight.bold, 1.2),
                        ),
                        Text(
                          "Collection",
                          style:
                              appStyleWithHt(42, wColor, FontWeight.bold, 1.2),
                        ),
                        TabBar(
                          padding: EdgeInsets.zero,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Colors.transparent,
                          controller: _tabController,
                          isScrollable: true,
                          labelStyle: appStyle(24, wColor, FontWeight.bold),
                          unselectedLabelColor: gColor.withOpacity(0.3),
                          tabs: [
                            Tab(
                              text: "Mens Shoes",
                            ),
                            Tab(
                              text: "Womens Shoes",
                            ),
                            Tab(
                              text: "kids Shoes",
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.250),
                child: Container(
                  padding: EdgeInsets.only(left: 12),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.415,
                            child: FutureBuilder<List<Snekers>>(
                                future: _male,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
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
                                          return ProductCard(
                                              price: "\$${shoe.price}",
                                              category: shoe.category,
                                              id: shoe.id,
                                              image:
                                                  shoe.imageUrl[0],
                                              name: shoe.title);
                                        });
                                  }
                                }),
                            
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(12, 20, 12, 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Latest Shoes",
                                      style:
                                          appStyle(24, bColor, FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Show All",
                                          style: appStyle(
                                              22, bColor, FontWeight.w600),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.13,
                            child: ListView.builder(
                                itemCount: 6,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: NewShoes(),
                                  );
                                }),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.405,
                            color: amberColor,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.405,
                            color: amberColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

