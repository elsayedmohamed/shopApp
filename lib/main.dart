import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/layout/shop_layout.dart';
import 'package:shop/modules/login/login_screen.dart';
import 'package:shop/shared/local/cache_helper.dart';
import 'package:shop/shared/network/dio_helper.dart';
import 'package:shop/styles/themes.dart';

import 'modules/login/cubit/bloc_observer.dart';
import 'modules/on_board_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  Widget? widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  String? token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = Login_Screen();
  } else {
    widget = OnBoardScreen();
  }

  BlocOverrides.runZoned(
    () => runApp(MyApp(
      startWidget: widget!,
    )),
    blocObserver: MyBlocObserver(),
  );

  HttpOverrides.global = MyHttpOverrides();
  DioHelper.init();
//  bool isDark = CacheHelper.getData(key: 'isDark');
}

class MyApp extends StatelessWidget {
  // MyApp({ required this.isdark, required this.onBoarding})

  // MyApp({    Key? key,
  // }) : super(key: key);
  Widget startWidget;
  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: startWidget,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
