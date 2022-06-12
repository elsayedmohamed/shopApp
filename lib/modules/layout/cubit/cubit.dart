import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/modules/layout/cubit/states.dart';
import 'package:shop/modules/layout/shop_app/categories/categories_screen.dart';
import 'package:shop/modules/layout/shop_app/favourites/favourites_screen.dart';
import 'package:shop/modules/layout/shop_app/products/products_screen.dart';
import 'package:shop/modules/layout/shop_app/settings/settings_screen.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/shared/network/remote/end_point.dart';

import '../../../models/home_models.dart';
import '../../../styles/constant.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopIntialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavouritesScreen(),
    const SettingsScreen(),
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
      emit(ShopSuccessHomeDataState());
    }).catchError(((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    }));
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromjson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError(((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    }));
  }
}
