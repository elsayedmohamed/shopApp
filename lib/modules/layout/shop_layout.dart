import 'package:flutter/material.dart';
import 'package:shop/components/reuseable.dart';
import 'package:shop/modules/login/login_screen.dart';
import 'package:shop/shared/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sallah'),
      ),
      body: TextButton(
          child: const Text('LogOut'),
          onPressed: () {
            CacheHelper.removeData(key: 'onBoarding');
            NavigateAndFinsh(context: context, screen: Login_Screen());
          }),
    );
  }
}
