import 'package:af_watches2/Data/models/watch.dart';
import 'package:flutter/material.dart';

import '../../Constants/strings.dart';
import '../Widgets/DetailsScreen/top_rounded_container.dart';
import '../Widgets/DetailsScreen/watch_desc.dart';
import '../Widgets/warning.dart';

class DetailsScreen extends StatelessWidget {
  Watch? watch;

  DetailsScreen({super.key, this.watch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Row(
                  children: [
                    Text(
                      "4.7",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: AspectRatio(
              aspectRatio: 1,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FadeInImage.assetNetwork(
                  image: watch!.image,
                  fit: BoxFit.contain,
                  placeholder: 'assets/loading.gif',
                ),
              ),
            ),
          ),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  product: watch!,
                  pressOnSeeMore: () {},
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: TopRoundedContainer(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: gradient3,
                animationDuration: Duration(seconds: 3), // Background color
              ),
              onPressed: () {
                WarningPopup.showWarningDialog(
                    context,
                    false,
                    warning: true,
                    'Sorry This Function isn\'t available yet ... Wait us!');
              },
              child: const Text("Add To Cart"),
            ),
          ),
        ),
      ),
    );
  }
}
