import 'package:ecom_app/utils/color.dart';
import 'package:ecom_app/widgets/stagger_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/snekers.dart';
import '../services/hrlper.dart';
import '../utils/constants.dart';
import '../widgets/product_card.dart';

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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.fromLTRB(6, 12, 16, 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: wColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        FontAwesomeIcons.sliders,
                        color: wColor,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          TabBar(
            padding: EdgeInsets.only(top: 100),
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
                  FutureBuilder<List<Snekers>>(
                      future: _male,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text("Error ${snapshot.error}");
                        } else {
                          final male = snapshot.data;
                          return StaggeredGridView.countBuilder(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 16,
                              scrollDirection: Axis.vertical,
                              staggeredTileBuilder: (index) =>
                                  StaggeredTile.extent(
                                      (index % 2 == 0) ? 1 : 1,
                                      (index % 4 == 1 || index % 4 == 3)
                                          ? MediaQuery.of(context).size.height *
                                              0.35
                                          : MediaQuery.of(context).size.height *
                                              0.3),
                              itemCount: male!.length,
                              itemBuilder: (context, index) {
                                final shoe = snapshot.data![index];
                                return StaggerTile(
                                    imageUrl: shoe.imageUrl[1],
                                    name: shoe.name,
                                    price: "\$${shoe.price}");
                              });
                        }
                      }),
                  Container(
                    height: 500,
                    width: 300,
                    color: Colors.amber,
                  ),
                  Container(
                    height: 500,
                    width: 300,
                    color: Colors.amber,
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
