import 'package:flutter/material.dart';

import '../../Constants/strings.dart';
import '../../Data/models/watch.dart';

class WatchItem extends StatelessWidget {
  final Watch watch;

  const WatchItem({super.key, required this.watch});

  @override
  Widget build(BuildContext context) {
    final height =MediaQuery.sizeOf(context).height;
    final width =MediaQuery.sizeOf(context).width;

    return Container(
      width: width*0.45,
      height: height*0.13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin:const EdgeInsets.all(10),
      child: Column(
       // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInImage.assetNetwork(
            image: watch.image,
            placeholder: 'assets/loading.gif',
            height: width*0.4,
            width: width*0.4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(watch.name),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('\$ ${watch.price}',
                    style: const TextStyle(
                        color:gradient3, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
         const Text(''),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: backgroundGrey,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12))
              ),
              child:const ListTile(
                title:Text("Add To your cart !",style: TextStyle(fontSize: 10,color: Colors.white),),
                trailing: Icon(Icons.add_circle_outlined,size: 20,color: Colors.white,),
              ),

            ),
          )
        ],
      ),
    );
  }}