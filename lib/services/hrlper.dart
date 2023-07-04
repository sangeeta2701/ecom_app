import 'package:flutter/services.dart' as the_bundle;
import '../models/snekers.dart';

class Helper {
  //male
  Future<List<Snekers>> getMaleSneker() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");

    final maleList = snekersFromJson(data);
    return maleList;
  }

//female
  Future<List<Snekers>> getFemaleSneker() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");

    final femaleList = snekersFromJson(data);
    return femaleList;
  }

//kids
  Future<List<Snekers>> getKidsSneker() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");

    final kidsList = snekersFromJson(data);
    return kidsList;
  }

  //Single male
  Future<Snekers> getMaleSnekerById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");

    final maleList = snekersFromJson(data);
    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }

  //Single female
  Future<Snekers> getFemaleSnekerById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");

    final femaleList = snekersFromJson(data);
    final sneaker = femaleList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }


  //Single kid
  Future<Snekers> getKidsSnekerById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");

    final kidList = snekersFromJson(data);
    final sneaker = kidList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }
}
