import 'package:shop/models/change_favourites_model.dart';
import 'package:shop/models/shoplogin_model.dart';

abstract class ShopStates {}

class ShopIntialStates extends ShopStates {}

class ShopChangeBottomState extends ShopStates {}
//===================================================

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}
//===================================================

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

//===================================================
class ShopSuccessChangeFavouritesState extends ShopStates {
  final ChangeFavouritesModel model;

  ShopSuccessChangeFavouritesState(this.model);
}

class ShopErrorChangeFavouritesState extends ShopStates {}

class ChangeFavouritesState extends ShopStates {}

//====================================================
class ShopLoadingGetFavouriteState extends ShopStates {}

class ShopSuccessGetFavouriteState extends ShopStates {}

class ShopErrorGetFavouriteState extends ShopStates {}

//=====================================================
class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {}

class ShopErrorUserDataState extends ShopStates {}

//======================================================
class ShopLoadingUpdateUserDataState extends ShopStates {}

class ShopSuccessUpdateUserDataState extends ShopStates {
  final ShopUserLoginModel loginModel;

  ShopSuccessUpdateUserDataState(this.loginModel);
}

class ShopErrorUpdateUserDataState extends ShopStates {}
//======================================================
