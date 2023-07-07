import 'package:ecom_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/constants.dart';

class ProductByCart extends StatefulWidget {
  const ProductByCart({super.key});

  @override
  State<ProductByCart> createState() => _ProductByCartState();
}

class _ProductByCartState extends State<ProductByCart> with TickerProviderStateMixin{
  late final TabController _tabController =
      TabController(length: 3, vsync: this);
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
                        onTap: () {
                        },
                        child: Icon(FontAwesomeIcons.sliders,color: wColor,),
                      ),

                    ],),
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
                          padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.2,
                          left: 16,
                          right: 12),
                          child: TabBarView(
                            controller: _tabController,
                            children: [
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
                            Container(
                              height: 500,
                              width: 300,
                              color: Colors.amber,
                            ),
                          ],),
                        ),
        ]),
      ),
    );
  }
}
