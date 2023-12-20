import 'package:flutter/material.dart';
import '../../Constants/strings.dart';
class WatchBanner extends StatelessWidget {
  final String image;
  final String name;
  const WatchBanner({super.key, required this.image, required this.name});


  @override
  Widget build(BuildContext context) {
    final height= MediaQuery.sizeOf(context).height;
    final width= MediaQuery.sizeOf(context).width;
    return Container(
      height:height*0.25,
      child: Stack(children: [
        Container(
          height: height*0.25,
          margin:const EdgeInsets.only(left: 20.0, right: 20.0, top: 30,bottom: 10),
          decoration: BoxDecoration(
            color: backgroundGrey,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        Container(
          child: Row(
            children: [
              FadeInImage.assetNetwork(
                image: image,
                placeholder: 'assets/loading.gif',
                height: height*0.25,
                width: width*0.5,
              ),
              const  SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Container(
                    padding:const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: secondaryBackgroundGrey,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child:const Text(
                      'New Product',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                   name,
                    style:const TextStyle(
                        color: backgroundWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        backgroundColor: gradient3,
                        padding:
                      const  EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                        foregroundColor: Colors.orangeAccent,
                        minimumSize:const Size(5, 5)),
                    child:const Text(
                      'Buy Now',
                      style: TextStyle(color: backgroundWhite),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}