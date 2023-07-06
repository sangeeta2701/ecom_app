import 'package:ecom_app/models/snekers.dart';
import 'package:ecom_app/services/hrlper.dart';
import 'package:ecom_app/utils/color.dart';
import 'package:ecom_app/utils/constants.dart';
import 'package:flutter/material.dart';
import '../widgets/homeWidget.dart';

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
                      HomeWidget(male: _male),
                      HomeWidget(male: _female),
                      HomeWidget(male: _kids),
                      
                      
                      
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

