import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/layout/cubit/states.dart';
import 'package:shop/modules/layout/shop_app/categories/categories_screen.dart';
import 'package:shop/modules/layout/shop_app/favourites/favourites_screen.dart';
import 'package:shop/modules/layout/shop_app/products/products_screen.dart';
import 'package:shop/modules/layout/shop_app/settings/settings_screen.dart';
import 'package:shop/shared/network/dio_helper.dart';
import 'package:shop/shared/network/end_point/end_point.dart';

import '../../../models/home_models.dart';
import '../../../styles/constant.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopIntialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomState());
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromjson(value.data);
      print(homeModel!.data!.banners[0].image);
      emit(ShopSuccessHomeDataState());
    }).catchError(((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    }));
  }
}
