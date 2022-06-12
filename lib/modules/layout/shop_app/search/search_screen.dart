import 'package:flutter/material.dart';
import 'package:shop/modules/layout/shop_app/shop_layout.dart';

import '../../../../shared/components/reuseable.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              NavigateTo(context: context, screen: const ShopLayout());
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            'Search Screen',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        body: const Text(
          'Search',
        ),
      ),
    );
  }
}
