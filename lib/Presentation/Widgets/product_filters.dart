import 'package:flutter/material.dart';

import '../../Constants/strings.dart';

class ProductFilters extends StatefulWidget {
  const ProductFilters({super.key});

  @override
   createState() => _ProductFiltersState();
}

class _ProductFiltersState extends State<ProductFilters> {
  static const _filters = <String>[
    'All Products',
    'Recommended',
    'New Product',
    'Popular'
  ];

  String _selectedFilter = 'All Products';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.only(left: 24),
      height: 20,
      child: ListView(scrollDirection: Axis.horizontal, children: [
        ..._filters.map((filterText) => Padding(
          padding: const EdgeInsets.only(right: 16),
          child: TextButton(
            onPressed: () => setState(() => _selectedFilter = filterText),
            style: TextButton.styleFrom(
                backgroundColor: _selectedFilter == filterText
                    ?   gradient3
                    : Colors.transparent,
                side: _selectedFilter != filterText
                    ? BorderSide(color: Colors.grey.shade300)
                    : null,
                padding:const EdgeInsets.all(4),
                foregroundColor:gradient4,
                minimumSize:const Size(100, 2)),
            child: Text(
              filterText,
              style: TextStyle(
                  color: _selectedFilter == filterText
                      ? backgroundWhite
                      : Colors.grey,
                  fontSize: 12),
            ),
          ),
        ))
      ]),
    );
  }
}
