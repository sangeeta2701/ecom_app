import 'package:ecom_app/utils/color.dart';
import 'package:ecom_app/utils/sizdBox.dart';
import 'package:ecom_app/widgets/categortButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/snekers.dart';
import '../services/hrlper.dart';
import '../utils/constants.dart';
import '../widgets/latestShoes.dart';

class ProductByCart extends StatefulWidget {
  const ProductByCart({super.key});

  @override
  State<ProductByCart> createState() => _ProductByCartState();
}

class _ProductByCartState extends State<ProductByCart>
    with TickerProviderStateMixin {
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

  List<String> brand = [
    "assets/images/adidas.png",
    "assets/images/gucci.png",
    "assets/images/jordan.png",
    "assets/images/nike.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: wColor,
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              filter();
                            },
                            child: Icon(
                              FontAwesomeIcons.sliders,
                              color: wColor,
                            ),
                          ),
                        ],
                      ),
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
                top: MediaQuery.of(context).size.height * 0.175,
                left: 16,
                right: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: TabBarView(
                controller: _tabController,
                children: [
                  LatestShoes(male: _male),
                  LatestShoes(male: _female),
                  LatestShoes(male: _kids)
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Future<dynamic> filter() {
    double _value = 100;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white54,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.84,
            decoration: BoxDecoration(
                color: wColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: Column(children: [
              height12,
              Container(
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: bColor.withOpacity(0.3),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  children: [
                    height16,
                    Text(
                      "Filter",
                      style: appStyle(40, bColor, FontWeight.bold),
                    ),
                    height16,
                    Text(
                      "Gender",
                      style: appStyle(20, bColor, FontWeight.bold),
                    ),
                    height12,
                    Row(
                      children: [
                        CategoryButton(buttonClr: bColor, lable: "Men"),
                        CategoryButton(buttonClr: gColor, lable: "Women"),
                        CategoryButton(buttonClr: gColor, lable: "Kids"),
                      ],
                    ),
                    height16,
                    Text(
                      "Category",
                      style: appStyle(20, bColor, FontWeight.bold),
                    ),
                    height12,
                    Row(
                      children: [
                        CategoryButton(buttonClr: bColor, lable: "Shoes"),
                        CategoryButton(buttonClr: gColor, lable: "Apparrels"),
                        CategoryButton(buttonClr: gColor, lable: "Accessories"),
                      ],
                    ),
                    height16,
                    Text(
                      "Price",
                      style: appStyle(20, bColor, FontWeight.bold),
                    ),
                    height12,
                    Slider(
                        value: _value,
                        activeColor: bColor,
                        inactiveColor: gColor,
                        thumbColor: bColor,
                        max: 500,
                        divisions: 50,
                        label: _value.toString(),
                        secondaryTrackValue: 200,
                        onChanged: (double value) {}),
                    height16,
                    Text(
                      "Brand",
                      style: appStyle(20, bColor, FontWeight.bold),
                    ),
                    height12,
                    Container(
                      padding: EdgeInsets.all(8),
                      height: 80,
                      child: ListView.builder(
                          itemCount: brand.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(8),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: gColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Image.asset(
                                  brand[index],
                                  height: 60,
                                  width: 80,
                                  color: bColor,
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              )
            ]),
          );
        });
  }
}
