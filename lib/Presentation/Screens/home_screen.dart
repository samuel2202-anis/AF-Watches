import 'dart:async';

import 'package:af_watches2/Presentation/Widgets/watch_banner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:af_watches2/Data/models/watch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Bussiness_logic/Watch/watches_cubit.dart';
import '../../Constants/strings.dart';
import '../../Data/models/user.dart';
import '../../Data/services/bannerWatchOffline.dart';
import '../Widgets/ProductsTitle.dart';
import '../Widgets/product_filters.dart';
import '../Widgets/watch_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Watch> allWatches;
  AppUser? appUser;
  String? userName;

  @override
  void initState() {
    super.initState();
    allWatches = BlocProvider.of<WatchesCubit>(context).getallWatches();
    getFutureName();
    }

  String? getFutureName() {
    getName().then((String value) {
      setState(() {
        userName = value;
      });
    });
    return userName;
  }

  Future<String> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.get('name').toString();
    return name;
  }

  Widget welcome() {
    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Welcome ${userName} !',
            style: Theme
                .of(context)
                .textTheme
                .titleLarge,
          ),
        ],
      ),
    );
  }

  Widget buildBLockWidget() {
    return BlocBuilder<WatchesCubit, WatchesState>(builder: (context, state) {
      if (state is WatchesLoaded) {
        allWatches = (state).watches;
        return buildLoadedListWidgets();
      } else {
        return const Center(
          child: CircularProgressIndicator(color: gradient3),
        );
      }
    });
  }

  Widget buildLoadedListWidgets() {
    return Container(
      child: buildCharacterList(),
    );
  }

  Widget buildCharacterList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: allWatches.length,
        itemBuilder: (ctx, index) {
          return WatchItem(
            watch: allWatches[index],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundWhite,
        elevation: 0,
        leading: const Icon(Icons.grid_3x3, color: backgroundGrey, size: 36),
        actions: [
          IconButton(
              onPressed: () => {},
              icon: const Icon(
                Icons.search,
                size: 36,
                color: backgroundGrey,
              )),
          IconButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('name');
                Navigator.pushReplacementNamed(context, loginPage);
              },
              icon: const Icon(
                Icons.logout_rounded,
                size: 30,
                color: backgroundGrey,
              ))
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: backgroundGrey,
            child: Container(
              decoration: const BoxDecoration(
                color: backgroundWhite,
              ),
              child: Column(
                children: [
                  welcome(),
                 BannerWatchOffline(),
                  const SizedBox(height: 20),
                  const ProductsTitle(),
                  const SizedBox(height: 10),
                  ProductFilters(),
                  const SizedBox(height: 30),
                  Expanded(child: buildBLockWidget()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
