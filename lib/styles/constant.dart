import 'package:flutter/material.dart';

import '../modules/login/login_screen.dart';
import '../shared/components/reuseable.dart';
import '../shared/network/local/cache_helper.dart';

const defaultColor = Colors.blue;

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      NavigateAndFinsh(context: context, screen: Login_Screen());
    }
  });
}

String? token = '';
