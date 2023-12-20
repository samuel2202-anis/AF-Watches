import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Presentation/Widgets/watch_banner.dart';
import '../models/watch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bussiness_logic/Watch/watches_cubit.dart';


class BannerWatchOffline extends StatefulWidget{
  const BannerWatchOffline({super.key});

  @override
  State<BannerWatchOffline> createState() => _BannerWatchOffline();
}
class _BannerWatchOffline extends State<BannerWatchOffline> {

  late List<Watch> allWatches;

  Watch bannerWatch = const Watch(
      description: 'Wait',
      image:
      'https://upload.wikimedia.org/wikipedia/commons/a/ad/YouTube_loading_symbol_3_%28transparent%29.gif?20140201131911',
      id: 12,
      price: 200,
      name: 'Waiting ...');
  @override
  void initState() {
    super.initState();
    allWatches = BlocProvider.of<WatchesCubit>(context).getallWatches();
    getFutureBannerWatch();
    Timer(const Duration(seconds: 5), () {
      checkUpdateBanner();
    });
  }

  checkUpdateBanner() {
    allWatches = BlocProvider.of<WatchesCubit>(context).getallWatches();
    allWatches.isNotEmpty ?
    allWatches.first.name != bannerWatch.name ||
        allWatches.first.image != bannerWatch.image
        ? setBannerWatch().then((value) =>setState(() { getFutureBannerWatch(); }))
        : null : null;
  }

  Future<void> setBannerWatch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('bannerName', allWatches.first.name);
    prefs.setString('bannerImage', allWatches.first.image);
    prefs.setString('bannerDesc', allWatches.first.description);
    prefs.setInt('bannerPrice', allWatches.first.price);
    prefs.setInt('bannerId', allWatches.first.id);
  }

  Future<Watch> getBannerWatch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.get('bannerName').toString();
    var image = prefs.get('bannerImage').toString();
    int? id = prefs.getInt('bannerId');
    int? price = prefs.getInt('bannerPrice');
    var description = prefs.get('bannerDesc').toString();
    return Watch(
        id: id!,
        name: name,
        description: description,
        price: price!,
        image: image);
  }

  Watch getFutureBannerWatch() {
    getBannerWatch().then((Watch value) {
      setState(() {
        bannerWatch = value;
      });
    });
    return bannerWatch;
  }



  @override
  Widget build(BuildContext context) {

 return WatchBanner(image: bannerWatch.image, name: bannerWatch.name);
  }
}
