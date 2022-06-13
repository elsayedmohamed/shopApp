import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/favourites_model.dart';
import 'package:shop/models/shoplogin_model.dart';
import 'package:shop/modules/layout/cubit/states.dart';
import 'package:shop/modules/layout/shop_app/categories/categories_screen.dart';
import 'package:shop/modules/layout/shop_app/favourites/favourites_screen.dart';
import 'package:shop/modules/layout/shop_app/products/products_screen.dart';
import 'package:shop/modules/layout/shop_app/settings/settings_screen.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/shared/network/remote/end_point.dart';

import '../../../models/change_favourites_model.dart';
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
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomState());
  }

  HomeModel? homeModel;

  Map<int, bool> favourites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromjson(value.data);

      homeModel!.data!.products.forEach((element) {
        favourites.addAll({
          element.id!: element.inFavorites!,
        });
      });

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

//=====================================
  FavoriteModel? favoriteModel;
  void getFavorites() {
    emit(ShopLoadingGetFavouriteState());
    DioHelper.getData(
      url: FAVOURITES,
      token: token,
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      emit(ShopSuccessGetFavouriteState());
    }).catchError(((error) {
      print(error.toString());
      emit(ShopErrorGetFavouriteState());
    }));
  }

  //============================================================
  ShopUserLoginModel? userLoginModel;
  void getUserData() {
    emit(ShopLoadingGetFavouriteState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userLoginModel = ShopUserLoginModel.fromjson(value.data);
      emit(ShopSuccessUserDataState());
    }).catchError(((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    }));
  }

  //============================================================
  ChangeFavouritesModel? changeFavouritesModel;
  void changeFavourites(int productId) {
    favourites[productId] = !favourites[productId]!;
    emit(ChangeFavouritesState());

    DioHelper.postData(
      url: FAVOURITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavouritesModel = ChangeFavouritesModel.fromjson(value.data);

      if (changeFavouritesModel!.status == false) {
        favourites[productId] = !favourites[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavouritesState(changeFavouritesModel!));
    }).catchError(
      (error) {
        favourites[productId] = !favourites[productId]!;
        emit(ShopErrorChangeFavouritesState());
      },
    );
  }
}
