import 'package:flutter/material.dart';

import '../components/reuseable.dart';
import '../modules/login/login_screen.dart';
import '../shared/local/cache_helper.dart';

const defaultColor = Colors.blue;

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      NavigateAndFinsh(context: context, screen: Login_Screen());
    }
  });
}

String? token = '';
