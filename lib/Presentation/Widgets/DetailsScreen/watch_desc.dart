import 'package:af_watches2/Constants/strings.dart';
import 'package:flutter/material.dart';
import '../../../Data/models/watch.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Watch product;
  final GestureTapCallback? pressOnSeeMore;
  @override
  State<ProductDescription> createState() => _ProductDescription();
}

class _ProductDescription extends State<ProductDescription> {
  bool seeMore=false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            widget.product.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.all(16),
            width: 48,
            decoration: const BoxDecoration(
              color: Color(0xFFFFE6E6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: const Icon(
              Icons.favorite,
              color: Color(0xFFFF4848),
              size: 16,
            ),
          ),
        ),
        Descr(seeMore),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            //padding: const EdgeInsets.only(bottom: 40),
            width: 70,
            decoration: const BoxDecoration(
              color: backgroundGrey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${ widget.product.price.toString()} \$',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget Descr(bool more) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 64,
          ),
          child: Text(
            widget.product.description,
            maxLines: more ? 20 : 3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          child: GestureDetector(
            onTap: _seeMoree ,
            child:  Row(
              children: [
                Text(more?'See less Details':
                  "See More Details",
                  style:
                      const TextStyle(fontWeight: FontWeight.w600, color: gradient3),
                ),
               const SizedBox(width: 5),
               const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: gradient3,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _seeMoree() {
    setState(() {
 seeMore=!seeMore;
 Descr(seeMore);
    });


  }
}
