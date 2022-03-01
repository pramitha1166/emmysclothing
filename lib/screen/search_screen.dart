import 'package:ecommerce/presentaion/widget/product_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onTap: () {
            showSearch(context: context, delegate: ProductSearchDelegate());
          },
        )
      ],
    );
  }
}
