import 'package:shop/models/change_favourites_model.dart';

abstract class ShopStates {}

class ShopIntialStates extends ShopStates {}

class ShopChangeBottomState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

//===================================================
class ShopSuccessChangeFavouritesState extends ShopStates {
  final ChangeFavouritesModel model;

  ShopSuccessChangeFavouritesState(this.model);
}

class ShopErrorChangeFavouritesState extends ShopStates {}

class ChangeFavouritesState extends ShopStates {}
